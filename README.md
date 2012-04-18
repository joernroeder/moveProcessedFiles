Move processed Images
=====================

Do you know the problem:  
You have a folder with many files that should be processed automatically. For example, using Photoshop Actions. Since the whole process takes several hours you decide that the computer can do it all while you're sleeping.  
On the next morning you'll wake up and are pleased that everything is done, but Photoshop has crashed!
When you restart the action all the processed files will be processed by Photoshops action again.

This program will observe both folders (source-folder and destination-folder) and moves the source file into the sub-folder (`processedFolderName`) after it is saved in the destination directory.

Select source and destination folder and grab a coffee, because it's still breakfast time. :)  

### Required Actions

* Create a sub-folder (`processedFolderName`) in your source directory.


### Variables ###

	String processedFolderName = "_processed";

The time in minutes between checks. Set it to 0 to disable the timer.

	float timerDelay = 3;