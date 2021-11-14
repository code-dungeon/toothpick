import { LoggerInterface, createLogger } from './Logger/Logger';
import { Format as format } from './formatters';
import { Transport as transport } from './transports';
import { LoggerConfig } from './Logger/LoggerConfig';
import { LoggerOptions } from './Logger/LoggerOptions';

const config: LoggerConfig = new LoggerConfig();

export namespace Logger {
  export type Interface = LoggerInterface;
  export type Options = LoggerOptions;

  export const Config = config;
  export const Format = format;
  export const Transport = transport;
  export function create(opts: LoggerOptions = {}): LoggerInterface {
    return createLogger(config, opts);
  }
}
