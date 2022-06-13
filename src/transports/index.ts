import * as ITransport from 'winston-transport';
import winston = require('winston');

/* eslint-disable-next-line @typescript-eslint/no-namespace */
export namespace Transport {
  export type Transporter = ITransport;
  export const Console = winston.transports.Console;
}
