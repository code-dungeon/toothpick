import winston = require('winston');
import { Format } from '../formatters';
import { LoggerConfig } from './LoggerConfig';
import { LoggerOptions } from './LoggerOptions';

function getOptionValue<T>(opt: T, defaultValue: T): T {
  if (opt !== undefined) {
    return opt;
  }

  return defaultValue;
}

function getFormat(configuredFormatters: Array<Format.Interface>, name: string, path: string): Format.Interface {
  let formatters: Array<Format.Interface> = configuredFormatters;

  if (name !== undefined && name !== null) {
    formatters = [Format.label(name, path), ...configuredFormatters];
  }

  return Format.combine(...formatters);
}

// export type LoggerOptions = winston.LoggerOptions;
export type LoggerInterface = winston.Logger;

export function createLogger(config: LoggerConfig, opts: LoggerOptions): LoggerInterface {
  const path: string = getOptionValue(opts.namePath, config.namePath);

  return winston.createLogger({
    levels: getOptionValue(opts.levels, config.levels),
    silent: getOptionValue(opts.silent, config.silent),
    level: getOptionValue(opts.level, config.level),
    exitOnError: getOptionValue(opts.exitOnError, config.exitOnError),
    defaultMeta: getOptionValue(opts.defaultMeta, config.defaultMeta),
    handleExceptions: getOptionValue(opts.handleExceptions, config.handleExceptions),
    exceptionHandlers: getOptionValue(opts.exceptionHandlers, config.exceptionHandlers),
    format: getFormat(getOptionValue(opts.formats, config.formats), opts.name, path),
    transports: getOptionValue(opts.transports, config.transports)
  });
}
