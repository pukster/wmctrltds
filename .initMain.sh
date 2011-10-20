#!/bin/bash

###
## This is the main file for launching the init files which will launch windows and move them around,
## thus initializing the system after login. Ideally this script should be called once per login.
## NOTE: I introduced sleep statements as without them problems were arising.
###

./.init1.sh
sleep 4
./.init2.sh
sleep 1
./.init3.sh
sleep 2
./.init4.sh
sleep 1
./.init5.sh
sleep 4
./.init6.sh
sleep 2
./.init7.sh
sleep 4
./.init8.sh
sleep 4
./.init9.sh
sleep 1
./.init10.sh
sleep 4
