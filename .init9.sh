#!/bin/bash

###
## This script launches the program then waits for the window to be created. Once created, it moves it
## to the specified coordinates.
## Note as this script is still being tested, the coordinates are often arbitrarilly set, and destination
## workspaces will not be used yet.
###

###
## The program to load
###
prog='gnome-terminal'

###
## The arguments to pass to the program
###
args='--working-directory=/home/peyman/Documents/canvas_experiments'

###
## The Destination coordinates to use
###
coord='0,10500,0,-1,-1'

###
## Sleep period
###
period=0.1

###
## Maximum number of sleep periods before giving up.
###
maxTrials=100

###
## Current trial
###
curTrial=0

###
## Signal whether the program was successfully loaded and identified
###
success=0

###
## First get a copy of all the windows prior to running this one
###
wmctrl -l > oldOutput.txt

###
## Also store a version with just the window IDs
cut -c1-10 oldOutput.txt > oldOutput2.txt

###
## Launch the program
###
$prog $args &

###
## Next get a copy of all the windows after to running this one and write it to output.txt
###
wmctrl -l > output.txt

###
## Also store a version with just the window IDs
###
cut -c1-10 output.txt > output2.txt

###
## Initialize the system by doing a diff of the before and after files (used in the loop below)
###
diff output2.txt oldOutput2.txt > /dev/null

###
## Loop at 100 ms frequency and wait for the window to load
###
while [ $? = 0 ]
do	
	###
	## Increment the trial counter
	###
	curTrial=$( expr $curTrial + 1 )

	###
	## Break if we have exceded the maximum number of trials
	###
	if [ "$curTrial" -gt "$maxTrials" ]
	then
		success=1
		break
	fi

	###
	## Repeat at a frequency of 10 hertz
	###
	sleep $period
	
	###
	## Next get a copy of all the windows after to running this one and write it to output.txt
	###
	wmctrl -l > output.txt

	###
	## Also store a version with just the window IDs
	###
	cut -c1-10 output.txt > output2.txt

	###
	## Initialize the system by doing a diff of the before and after files (used in the loop below)
	###
	diff output2.txt oldOutput2.txt > /dev/null
done

if [ $success = 0 ]
then
	###
	## Get the window ID on success
	###
	windowID=`tail -1 output2.txt`

	###
	## Move to new coordinates
	###
	wmctrl -i -r "$windowID" -e $coord

	###
	## Optionally resize
	###
	wmctrl -i -r "$windowID" -b add,maximized_vert,maximized_horz

	echo 'Successfully moved' $prog '(init8.sh)'
else

	echo 'Failed to move' $prog '(init8.sh)'
fi
