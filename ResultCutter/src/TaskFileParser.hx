package;
using StringTools;
import sys.io.File;
import sys.io.FileInput;

/**
 * Parses a task file (i.e. joris.txt)
 */
class TaskFileParser
{
	var taskFile: String;
	var taskDifficulties: List<Int>;
	
	var prevTime: Float = 0;
	var tasks: List<Task>;
	var subjectName: String;
	
	
	public function new(taskFile: String) 
	{
		this.taskFile = taskFile;
		this.taskDifficulties = new List<Int>();
		this.tasks = new List<Task>();
		
		subjectName = taskFile.split('.')[0];
	}
	
	public function cut(): List<Task> {
		
		var fin = File.read(taskFile);
		try {
				trace("Started parsing");
				parse(fin.readLine(), fin);
		}
		catch (exception: haxe.io.Eof) {
			trace("Done");
			fin.close();
		}
		return tasks;
		
	}
	
	function parse(line: String, fin: FileInput) {
		if (getContent(line).startsWith("Task difficulties"))
		{
			parseTaskDifficulties(fin.readLine(), fin);
		}
		else if (getContent(line).startsWith("Showing"))
		{
			parseTask(line, fin);
		}
		else {
			//Ignore this line, parse the next line
			parse(fin.readLine(), fin);
		}
		
	}
	
	function parseTask(line: String, fin: FileInput) {
		var task: Task = { startTime: 0, endTime: 0, difficulty: 0, subject: subjectName };
		task.startTime = getTime(line);
		task.difficulty = taskDifficulties.pop();
		
		while (!getContent(line).startsWith("Answered"))
		{
			line = fin.readLine();
		}
		task.endTime = getTime(line);
		
		tasks.push(task);
		trace("Parsed task: " + task);
		
		//Parse the rest of the file
		parse(fin.readLine(), fin);
	}
	
	
	function parseTaskDifficulties(line: String, fin: FileInput) 
	{
		var con = getContent(line);
		while (con.length == 1) {
			taskDifficulties.add(Std.parseInt(con));
			con = getContent(fin.readLine() );
		}
		trace("Parsed task difficulties: " + taskDifficulties.toString());
		parse(line, fin);
	}
	
	function getContent(line: String) {
		var val = line.split('GMT')[1];
		return val.trim();
	}
	
	function getTime(line: String) {
		var timeString = line.split('2014')[1].split('GMT')[0].trim();
		var date = Date.fromString(timeString);
		return date.getTime();
	}
	
	
	
}