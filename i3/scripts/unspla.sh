#!/bin/sh
# unspla.sh - Set your background with a random Unsplash image
# Created by Thiago Ozores (ozor.es) based on Collin McKinley script (https://github.com/Bravotic/unspla.sh)

BACKGROUND_RES="1920x1080"                                                 # Set the size of unsplash image to pull
PARAMS="backgrounds"                                                       # Set the parameters used to pull the image. Add a comma between the parameters the choose more than one 
BACKGROUND_CMD="feh --bg-fill "                                            # The command that will be used to set the background
IMAGE_SAVE_DIR="/tmp/unsplash"                                             # Directory to save the image
IMAGE_SAVE_PATH="$IMAGE_SAVE_DIR/photo.jpg"                                # Full path to the file that will be used to save the image
UNSPLASH_URL="https://source.unsplash.com/random/$BACKGROUND_RES/?$PARAMS" # URL from Unsplash to grab the image
UPDATE_INTERVAL=1800                                                       # How long to wait before changing the picture (seconds). Default 30 minutes (1800 seconds)

PIDS=$(pgrep -f unspla.sh)
if [ -n "$PIDS" ]; then
   for PID in $PIDS; do
       if [ "$$" != "$PID" ]; then
           kill -15 "$PID"
	   printf "Old instance (PID $PID) killed"
       fi
   done
fi

mkdir -p $IMAGE_SAVE_DIR

printf "Launching unspla.sh"
printf "Grabbing image from $UNSPLASH_URL"
while :
   do
	wget --quiet $UNSPLASH_URL -4 -O $IMAGE_SAVE_PATH
	printf "Image saved to $IMAGE_SAVE_PATH"
	$BACKGROUND_CMD $IMAGE_SAVE_PATH
	sleep $UPDATE_INTERVAL
	print "Waiting $UPDATE_INTERVAL seconds to change the image"
   done &
