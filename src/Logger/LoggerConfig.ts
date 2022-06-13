import winston = require('winston');

import { Transport } from '../transports';
import { Format } from '../formatters';
import { LoggerOptions } from './LoggerOptions';

export class LoggerConfig implements LoggerOptions {
  public namePath: string;
  public levels: winston.config.AbstractConfigSetLevels;
  public silent: boolean;
  public level: string;
  /* eslint-disable-next-line */
  public exitOnError: Function | boolean;
  /* eslint-disable-next-line */
  public defaultMeta: any;
  public transports: Array<Transport.Transporter>;
  public handleExceptions?: boolean;
  /* eslint-disable-next-line */
  public exceptionHandlers?: any;
  public formats: Array<Format.Interface>;

  constructor() {
    this.namePath = 'name';
    this.silent = false;
    this.level = 'info';
    this.formats = [
      Format.hostname(),
      Format.pid(),
      Format.json(),
      Format.splat(),
      Format.timestamp()
    ];
    this.transports = [
      new Transport.Console({
        format: Format.json()
      })
    ];
  }
}
