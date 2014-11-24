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
		var r = new TaskFileParser('vera.txt');
		var tasks = r.cut();
		
		var cutter = new MeasurementCutter(Date.fromString('19:55:52').getTime(), 1000, tasks);
		cutter.cut('verabio.txt');
	}
	
}