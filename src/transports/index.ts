import * as ITransport from 'winston-transport';
import winston = require('winston');

export namespace Transport {
  export type Transporter = ITransport;
  export const Console = winston.transports.Console;
}
