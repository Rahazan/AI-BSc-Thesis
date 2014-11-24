package;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;

/**
 * ...
 * @author Guido
 */
class MeasurementCutter
{
	var measurementStart:Float;
	
	// Samples per second
	var sampleRate: Int;
	var tasks: List<Task>;
	
	public function new(measurementStart:Float, sampleRate: Int, tasks: List<Task>) 
	{
		this.sampleRate = sampleRate;
		this.measurementStart = measurementStart;
		this.tasks = tasks;
	}
	
	public function cut(file: String)
	{
		var fin = File.read(file);
		var prevTime: Float = 0;
		
		trace("Cutting measurement file");
		trace("-----------------------");
		for (ctask in tasks) 
		{
			
			var fileName = ctask.subject + ctask.difficulty;
			trace('Now processing $fileName');
			
			
			var lines: List<String>;
			if (prevTime == 0) {
				var amount: Int = Std.int ( ((ctask.startTime - measurementStart) / 1000) * sampleRate );
				trace('Removing $amount measurements which were done before task start'); 
				
				takeNLines(amount, fin); //Remove the first lines, before first task was shown
			}
			else {
				trace(ctask.startTime);
				trace(prevTime);
				
				var amount: Int = Std.int ( ((ctask.startTime - prevTime) / 1000) * sampleRate );
				trace('Removing $amount measurements which were done in between tasks'); 
				takeNLines(amount, fin);
			}
			
			var amount: Int = Std.int ( ((ctask.endTime - ctask.startTime) / 1000) * sampleRate );
			lines = takeNLines(amount, fin);
			prevTime = ctask.endTime;
			
			trace('Putting $amount samples into $fileName'); 
			writeToFile(fileName, lines);
		}
		
	}
	
	private function writeToFile(fileName: String, lines: List<String>) 
	{
		
	}
	
	private function takeNLines(n: Int, fin: FileInput): List<String>
	{
		var list = new List<String>();
		for (i in 0...n) {
			list.add(fin.readLine());
		}
		return list;
	}
	
	
}