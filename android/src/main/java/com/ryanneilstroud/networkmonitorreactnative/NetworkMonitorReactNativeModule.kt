package com.ryanneilstroud.networkmonitorreactnative

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.ryanneilstroud.periscopeandroid.Periscope
import okhttp3.HttpUrl.Companion.toHttpUrlOrNull
import okhttp3.OkHttpClient
import okhttp3.Request

class NetworkMonitorReactNativeModule(
  reactContext: ReactApplicationContext
) : ReactContextBaseJavaModule(reactContext) {
  init {
    Periscope.initialize(reactContext.applicationContext)
  }

  override fun getName(): String = "PeriscopeBridge"

  @ReactMethod
  fun capture(options: ReadableMap?, promise: Promise) {
    val receiver = if (options?.hasKey("receiver") == true && !options.isNull("receiver")) {
      options.getMap("receiver")
    } else {
      options
    }
    val port = if (receiver?.hasKey("port") == true && !receiver.isNull("port")) {
      receiver.getInt("port")
    } else {
      61337
    }

    if (port !in 1..65_535) {
      promise.reject("invalid_port", "Expected port in range 1...65535.")
      return
    }

    val host = if (receiver?.hasKey("host") == true && !receiver.isNull("host")) {
      receiver.getString("host")?.trim()?.takeIf { it.isNotEmpty() }
    } else {
      null
    }

    val receiver = if (host == null) {
      Periscope.Receiver.simulator(port)
    } else {
      Periscope.Receiver.device(host, port)
    }

    Periscope.capture(receiver)
    promise.resolve(null)
  }

  @ReactMethod
  fun start(options: ReadableMap?, promise: Promise) {
    capture(options, promise)
  }

  @ReactMethod
  fun stop(promise: Promise) {
    Periscope.stop()
    promise.resolve(null)
  }

  @ReactMethod
  fun sendTestRequest(urlString: String?, promise: Promise) {
    val resolvedURLString = urlString?.trim().takeUnless { it.isNullOrEmpty() }
      ?: "https://jsonplaceholder.typicode.com/todos/1"
    val url = resolvedURLString.toHttpUrlOrNull()

    if (url == null) {
      promise.reject("invalid_url", "sendTestRequest expected a valid URL string.")
      return
    }

    Thread {
      try {
        val client = OkHttpClient.Builder()
          .addInterceptor(Periscope.default.interceptor())
          .build()
        val request = Request.Builder()
          .url(url)
          .build()

        client.newCall(request).execute().use { response ->
          promise.resolve(response.code)
        }
      } catch (error: Exception) {
        promise.reject("request_failed", error.message, error)
      }
    }.start()
  }
}
