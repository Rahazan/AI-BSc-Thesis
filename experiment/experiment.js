var tasks = [
    {
      difficulty:1,
      answers:[3, 1, 2],
      sumparts:[1,0,1,0],
      correct:2
    },
    {
      difficulty:1,
      answers:[4, 3, 2],
      sumparts:[1,0,1,0],
      correct:2
    },
    {
      difficulty:2,
      answers:[21, 19, 17],
      sumparts:[4,3,5,9],
      correct:21
    },
    {
      difficulty:2,
      answers:[23, 22, 20],
      sumparts:[8,9,4,1],
	  correct: 22
      
    },
    {
      difficulty:3,
      answers:[203, 196, 199],
      sumparts:[71,48,34,50],
	  correct: 203
    },
    {
      difficulty:3,
      answers:[214, 222, 236],
      sumparts:[95,19,80,28],
	  correct: 222
    },
    {
      difficulty:4,
      answers:[1836, 1866, 1844],
      sumparts:[252,438,270,872],
	  correct: 1832
    },
    {
      difficulty:4,
      answers:[1659, 1662, 1708],
      sumparts:[443,452,642,171],
	  correct: 1708
    }


    ]; //2 of each difficulty.

	var mistakes = 0;
	var started = false;
	document.getElementById("content").addEventListener("click", onSpace, true);
	var _log= "";
	function onSpace() {
		if (started) {
			return;
		}
		log("Start of experiment");
		logTasks();
		
		
		started = true;
		
		nextTrial();
		
	}
	
	function downloadLog() {
		var d = new Date();
		var textFileAsBlob = new Blob([_log], {type:'text/plain'});
		var fileNameToSaveAs = "log" + d;
		var a = document.createElement("a");
		a.href = window.URL.createObjectURL(textFileAsBlob);
		a.textContent = "Download";
		a.dataset.downloadurl = [{type:'text/plain'}, a.download, a.href].join(":");
		document.body.appendChild(a);
	}
	

	function log(value) {
		var d = new Date();
		_log += d.toUTCString() + " " + value + "\n";
		console.log( d.toUTCString() + " " + value);
	}
	
	function logTasks() {
		log ("Task difficulties: ");
		for (var i = 0; i < tasks.length; i++){
			log(tasks[i].difficulty);
		}
	}

    tasks = shuffle(tasks);
    var currentTask ;

    var timeBetweenActions = 4000;

    var elem = document.querySelector("#content");

    Math.seedrandom("sumseed");


    function showText(number){
      elem.innerHTML = "<p>" + number + "</p>";
    }

    function showAnswers(){
      elem.innerHTML = "";

      for(var i = 0; i < currentTask.answers.length; i++)
      {
        elem.innerHTML += "<p><a href=\"#\" onclick=\"answer(this.innerHTML);\">" + currentTask.answers[i] + "</a></p>";
      }
    }

	function answer(ans) 
	{
		log("Answered " + ans);
		if (currentTask.correct != parseInt(ans)) {
			log("Wrong, was " + currentTask.correct);
			mistakes++;
		}
		nextTrial();
	}
	
    function nextTrial()
    {
      if (0 !== tasks.length) { //Get next task
          currentTask =  tasks.shift();
          showText(Array(currentTask.difficulty+1).join("*")); //Show difficulty
          sleep(timeBetweenActions*2, runTrial); //Start after a while
        }
      else {
			log("Finished");
			log("Wrong answers: " + mistakes);
			console.log(_log);
			downloadLog();
          showText("Klaar!");
        }
    }

    function runTrial()
    {
		log("Showing number");
      if (currentTask.sumparts.length < 1) {
          answerPart();
          return;
      }
        showText(currentTask.sumparts.shift());
        sleep(timeBetweenActions, runTrial);
    }

    function answerPart()
    {
      showAnswers(currentTask.answers);
	  log("Showing answers");
      //Wait for user to click one of the options..
    }

    function sleep(millis, callback) {
      setTimeout(function()
            { callback(); }
      , millis);
    }

    function shuffle(array) { //Fisher-Yates shuffle, source https://github.com/coolaj86/knuth-shuffle
      var currentIndex = array.length, temporaryValue, randomIndex ;

      // While there remain elements to shuffle...
      while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
      }

      return array;
    }