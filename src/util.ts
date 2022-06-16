import * as path from 'path';
import * as fs from 'fs';

export function getPkgJsonDir(): string {
  const { dirname } = path;
  const { accessSync, constants } = fs;

  let pkgJsonPath: string;

  for (let pathToTest of module.paths) {
    try {
      const pathDir: string = dirname(pathToTest);
      accessSync(pathDir, constants.F_OK);
      accessSync(path.resolve(pathDir, 'package.json'), constants.F_OK);
      pkgJsonPath = pathDir;
    }
    catch (e) {
      // move on, not package.json here
    }
  }

  return pkgJsonPath;
}
