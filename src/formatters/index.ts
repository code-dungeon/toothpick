import winston from "winston";
import { Formatter as LogFormatter } from "./formatter";
import { createAppname } from './Appname';
import { createHostname } from './Hostname';
import { createPid } from './Pid';
import { createContextInfo } from './ContextInfo';
import { createLabel } from './Label';
import { createPrettyErrors } from './PrettyErrors';

/* eslint-disable-next-line @typescript-eslint/no-namespace */
export namespace Format {
  export type Interface = LogFormatter;
  export const align = winston.format.align;
  export const appname = createAppname;
  export const cli = winston.format.cli;
  export const colorize = winston.format.colorize;
  export const combine = winston.format.combine;
  export const context = createContextInfo;
  export const errors = winston.format.errors;
  export const format = winston.format;
  export const hostname = createHostname;
  export const json = winston.format.json;
  export const label = createLabel;
  export const logstash = winston.format.logstash;
  export const metadata = winston.format.metadata;
  export const ms = winston.format.ms;
  export const prettyErrors = createPrettyErrors;
  export const padLevels = winston.format.padLevels;
  export const pid = createPid;
  export const prettyPrint = winston.format.prettyPrint;
  export const printf = winston.format.printf;
  export const simple = winston.format.simple;
  export const splat = winston.format.splat;
  export const timestamp = winston.format.timestamp;
  export const uncolorize = winston.format.uncolorize;
}
