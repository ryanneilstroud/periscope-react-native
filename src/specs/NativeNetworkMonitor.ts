export type StartOptions = {
  host?: string;
  port?: number;
};

export interface NativeNetworkMonitorSpec {
  start(options?: StartOptions): Promise<void>;
  stop(): Promise<void>;
}
