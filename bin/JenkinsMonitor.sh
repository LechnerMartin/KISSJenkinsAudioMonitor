#!/bin/bash

###########################################################
# Edit the following data according your needs
# Authentication data
USER=yourjenkinsusername
PWD=somejenkinspwdtoken
URL=https://jenkins.yourdomain.com/view/product/eFeedback/cc.xml

# Directory setup
SCRIPTDIR=$(dirname $(readlink -f $0))
SOUNDDIR="$SCRIPTDIR/../sounddir"

FILEOLD="/tmp/efeedback_old.xml"
FILENEW="/tmp/efeedback_new.xml"

# Debug data
#FILEOLD="../testdata/cc-test_allOk.xml"
#FILENEW="../testdata/cc-test_oneFailed.xml"

###########################################################

# Get Jenkins XML status
wget -O- -q --no-check-certificate --auth-no-challenge --http-user=$USER --http-password=$PWD  $URL > $FILENEW

RESULT=`ruby $SCRIPTDIR/JenkinsMonitor.rb $FILEOLD $FILENEW`
cp $FILENEW $FILEOLD

function playSound {
	echo "playing $1"
	play -q $1
}

# enter line in logfile
NOW=$(date +"%m%d_%H%m%S")
echo "$NOW $RESULT"

# define result action
case $RESULT in
	FirstFailure)
		playSound "$SOUNDDIR/firstfail_redalert.mp3"
		;;
	LastFixed)
		playSound "$SOUNDDIR/allfixed_diagnosticcomplete_ep.mp3"
		;;
	StillFailing)
		playSound "$SOUNDDIR/stillfail_warningwarpcorecollapse_ep.mp3"
		;;
	NewFailure)
		playSound "$SOUNDDIR/onefail_tos_hullhit_3.mp3"
		;;
	OneFixed)
                playSound "$SOUNDDIR/onefixed_voy-doc-onedown.wav"
		;;
	OK)
		;;
	*)
		echo "Unknown"
esac




