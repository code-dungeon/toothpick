import { LoggerInterface, createLogger } from './Logger/Logger';
import { Format as format } from './formatters';
import { Transport as transport } from './transports';
import { LoggerConfig } from './Logger/LoggerConfig';
import { LoggerOptions } from './Logger/LoggerOptions';
import { getPkgJsonDir } from './util';

const config: LoggerConfig = new LoggerConfig();

/* eslint-disable-next-line @typescript-eslint/no-namespace */
export namespace Logger {
  export type Interface = LoggerInterface;
  export type Options = LoggerOptions;

  export const Config = config;
  export const Format = format;
  export const Transport = transport;
  export function create(opts: LoggerOptions = {}): LoggerInterface {
    return createLogger(config, opts);
  }
  export function createWithFilename(filename: string, opts: LoggerOptions = {}): LoggerInterface {
    const root: string = getPkgJsonDir();
    let name = filename.replace(`${root}/`, '');
    name = name.substr(0, name.lastIndexOf('.')) || name;

    return createLogger(config, { ...opts, name });
  }
}
