import winston = require('winston');

import { Transport } from '../transports';
import { Format } from '../formatters';


export interface LoggerOptions {
  name?: string;
  namePath?: string;
  levels?: winston.config.AbstractConfigSetLevels;
  silent?: boolean;
  formats?: Array<Format.Interface>;
  level?: string;
  exitOnError?: Function | boolean;
  defaultMeta?: any;
  transports?: Array<Transport.Transporter>;
  handleExceptions?: boolean;
  exceptionHandlers?: any;
}
