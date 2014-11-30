package;

import neko.Lib;

/**
 * ...
 * @author Guido
 */

class Main 
{
	
	static function main() 
	{
		var args = Sys.args();
		if (args.length != 4 ) {
			trace ("Not enough arguments,\n 1st arg: time of measurement start (eg \"12:45:00\"),\n 2nd arg samples per second,\n 3rd argument task filepath,\n 4th argument measurement filepath");
			Sys.exit(1);
		}
		
		
		
		var r = new TaskFileParser(args[2]);
		var tasks = r.parsaeFile();
		
		var cutter = new MeasurementCutter(Date.fromString(args[1]).getTime(), Std.parseInt(args[2]), tasks);
		cutter.cut(args[4]);
	}
	
}