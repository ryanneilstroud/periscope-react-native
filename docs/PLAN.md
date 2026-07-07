# Plan: `@ryanneilstroud/network-monitor-react-native`

## Product objective

Deliver an RN package that bridges `NetworkMonitorKit` with minimal setup friction and broad compatibility.

## Non-goals (initial release)

- No custom Metro plugin
- No manual app-side Xcode SPM integration steps
- No custom fork of React Native CLI linking

## Compatibility targets (v0.x)

| Surface | Target |
|---|---|
| React Native | 0.74+ |
| iOS | 15+ |
| Android | API 24+ (if Android bridge is added in same package) |
| JS engine | Hermes + JSC |
| Architecture | Legacy bridge + New Architecture (TurboModule shim path) |

## Recommended architecture

### iOS (recommended)

1. Build and release `NetworkMonitorKit.xcframework` from the Swift package pipeline.
2. Reference that binary from this RN package’s podspec (`vendored_frameworks`).
3. Expose minimal RN native module methods (`start`, `stop`, `setHost`, `injectConfiguration`).
4. Let RN autolinking + CocoaPods install everything automatically.

Why: this keeps app setup in the normal RN install flow and avoids app-level SPM friction.

### Android

- If Android SDK parity exists: include native module wrapper directly.
- If iOS-only initially: publish package as iOS-only and fail fast with clear Android unsupported message.

## Delivery phases

## Phase 1 — Scaffold + API contract

1. Define TypeScript public API and strict typing.
2. Define module behavior contract (errors, defaults, host/port semantics).
3. Create example app smoke test script.

Exit criteria: JS API stable and docs clear.

## Phase 2 — iOS native bridge

1. Add podspec with binary framework integration.
2. Implement ObjC/Swift bridge module.
3. Add runtime checks + explicit error surfaces.

Exit criteria: RN example app starts monitor with zero manual iOS project edits.

## Phase 3 — Compatibility and release hardening

1. Test matrix across RN versions and architectures.
2. Validate autolinking behavior on clean apps.
3. Automate release pipeline:
   - build/attach `.xcframework`
   - version package
   - publish npm package

Exit criteria: repeatable release and clean install docs.

## CI/CD plan

1. Lint + typecheck + unit tests (JS layer)
2. iOS integration smoke build (example app)
3. (Optional) Android smoke build
4. Release workflow triggered by tags

## Risk register

| Risk | Impact | Mitigation |
|---|---|---|
| RN/SWIFT ABI mismatch | iOS runtime failures | ship tested XCFramework per release, strict version pinning |
| CocoaPods edge cases | install friction | clean podspec, test on clean RN template |
| New Architecture changes | bridge breakage | maintain legacy + NA path until stable adoption threshold |

## Definition of done for v0.1.0

1. `npm install` + `npx pod-install` succeeds in clean RN app.
2. `NetworkMonitor.start(...)` works on simulator/device.
3. No manual app SPM steps required.
4. README includes exact install and troubleshooting steps.
