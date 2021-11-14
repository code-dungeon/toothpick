import winston from "winston";
import { Formatter as LogFormatter } from "./formatter";
import { createAppname } from './Appname';
import { createHostname } from './Hostname';
import { createPid } from './Pid';
import { createContextInfo } from './ContextInfo';
import { createLabel } from './Label';

export namespace Format {
  export type Interface = LogFormatter;
  export const align = winston.format.align;
  export const appname = createAppname;
  export const combine = winston.format.combine;
  export const format = winston.format;
  export const hostname = createHostname;
  export const json = winston.format.json;
  export const label = createLabel;
  export const metadata = winston.format.metadata;
  export const pid = createPid;
  export const prettyPrint = winston.format.prettyPrint;
  export const printf = winston.format.printf;
  export const splat = winston.format.splat;
  export const timestamp = winston.format.timestamp;
  export const context = createContextInfo;
}
