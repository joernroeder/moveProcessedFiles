
String processedFolderName = "_processed";
float timerDelay = 3; // rechecks the folder after timerDelay minutes. set to 0 to disable rechecks.

String sourceFolder;
String processedFolder;

ArrayList<String> sourceFiles;
ArrayList<String> processedFiles;

Timer rechecker;
Boolean recheckTimerTaskRunning = false;

int moved = 0;

void setup() {
  size(400, 150);
  color(255);
  noLoop();

  // set timer
  rechecker = new Timer();

  // select folders
  sourceFolder = selectFolder("source folder");
  processedFolder = selectFolder("processed folder");
}

void draw() {
  getFiles();
  compareFolders();
}

void updateUI() {
  background(0);
  text("moved " + moved + " files", 10, 30);
}

void getFiles() {
  // get Files
  File sourcePath = new File(sourceFolder);
  File processedPath = new File(processedFolder);

  // update lists
  sourceFiles = new ArrayList(Arrays.asList(sourcePath.list()));
  processedFiles = new ArrayList(Arrays.asList(processedPath.list()));
}

void compareFolders() {
  for (int i = 0; i < processedFiles.size(); i++) {
    String name = processedFiles.get(i);

    // move source file
    if (sourceFiles.contains(name)) {
      moveSourceFile(name);
      moved++;
    }

    // remove processed file from list
    processedFiles.remove(i);

    // add to chache
    //cachedFiles.add(name);
  }

  updateUI();

  // set timer
  if (timerDelay != 0) {
    rechecker.schedule(new RecheckTimerTask(), (long) timerDelay * 1000 * 60);
  }
}

void moveSourceFile(String name) {
  println("move file: " + name);
  File ff = new File(sourceFolder + "/" + name);
  ff.renameTo(new File(sourceFolder + "/" + processedFolderName + "/" + name));
}

public class RecheckTimerTask extends TimerTask {  
  RecheckTimerTask() {  
    println(hour() + ":" + minute() + ":" + second() + ": Recheck the folders in " + timerDelay + " minutes.");
  }  
  public void run() {  
    recheckTimerTaskRunning = true;

    getFiles();
    compareFolders();
  }
}

