
String processedFolderName = "_processed";
float timerDelay = 1; // rechecks the folder after timerDelay minutes. set to 0 to disable rechecks.

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
  //noLoop();

  // set timer
  rechecker = new Timer();

  // select folders
  sourceFolder = "/Volumes/HDD/Users/joern/Dropboxes/kontakt@joernroeder.de/Dropbox/fbManchester/images03"; //selectFolder("source folder");
  processedFolder = "/Volumes/HDD/Users/joern/Projects/fbFaces/fbManchester/300dpis/images03"; //selectFolder("processed folder");
}

void draw() {
  if (!recheckTimerTaskRunning) {
    getFiles();
    compareFolders();
  }

  background(0);
  text("moved " + getMoved() + " files", 10, 30);
}

void getFiles() {
  // get Files
  File sourcePath = new File(sourceFolder);
  File processedPath = new File(processedFolder);

  // update lists
  sourceFiles = new ArrayList(Arrays.asList(sourcePath.list()));
  processedFiles = new ArrayList(Arrays.asList(processedPath.list()));
}

int getMoved() {
  return moved;
}

void compareFolders() {
  recheckTimerTaskRunning = true;
  
  println("\tsource files: "+ sourceFiles.size());
  println("\tprocessed files: "+ processedFiles.size() + "\n");

  for (int i = 0; i < sourceFiles.size(); i++) {
    String name = sourceFiles.get(i);

    // move source file
    if (processedFiles.contains(name)) {
      moveSourceFile(name);
      moved++;
    }

    // remove processed file from list
    sourceFiles.remove(i);
  }
  
  println("\n - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");

  // set timer
  if (timerDelay != 0) {
    rechecker.schedule(new RecheckTimerTask(), (long) (timerDelay * 1000) * 60);
  }
}

void moveSourceFile(String name) {
  println("\t- move file: " + name);
  File ff = new File(sourceFolder + "/" + name);
  ff.renameTo(new File(sourceFolder + "/" + processedFolderName + "/" + name));
}

public class RecheckTimerTask extends TimerTask {  
  RecheckTimerTask() {  
    println("\n" + hour() + ":" + minute() + ":" + second() + ": Recheck the folders in " + timerDelay + " minutes.\n");
  }  
  public void run() {  
    recheckTimerTaskRunning = true;

    getFiles();
    compareFolders();
  }
}

