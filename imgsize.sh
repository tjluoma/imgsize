#!/bin/zsh
#
#	Author:		Timothy J. Luoma
#	Email:		luomat at gmail dot com
#	Date:		2011-07-30
#
#	Purpose: 	get the size of an image
#
#	URL:


# width="2048" height="1536"

# -r    2048 1536
# -a    (-width => 2048, -height => 1536)

case "$1" in
-h)
HTML="yes"
shift
;;


-H)
JUST_HEIGHT="yes"
shift
;;


-W)
JUST_WIDTH="yes"
shift
;;

-r)
RAW="yes"
shift
;;

-x)
BOTH="yes"
shift
;;

-a)
PERL="yes"
shift
;;


-m)
MARKDOWN="yes"
shift
;;



-*)
echo "$0:t Unknown argument $1"
exit 1
;;

esac


if [ "$#" -gt "1" ]
then
MULTIPLE=yes
else
MULTIPLE=no
fi


for PIC in $@
do

# do some basic converting to 'encode' filenames
# change ' ' to '%20'
ENCODED_FILENAME=`	echo "$PIC" | sed 's# #%20#g'`


if [ "$MULTIPLE" = "yes" ]
then
FILENAME=`echo "$PIC: "`
else
FILENAME=""
fi

FULLPATH=($PIC(:A))

IMGSIZE=(`sips --getProperty pixelWidth --getProperty pixelHeight ${FULLPATH} 2>/dev/null |\
fgrep 'pixel' | awk '{print $NF}'`)

while [ "$IMGSIZE" = "" ]
do
	sleep 5

	msg "Retrying size for $PIC" >/dev/null

IMGSIZE=(`sips --getProperty pixelWidth --getProperty pixelHeight ${FULLPATH} 2>/dev/null |\
fgrep 'pixel' | awk '{print $NF}'`)

done

WIDTH="${IMGSIZE[1]}"

HEIGHT="${IMGSIZE[2]}"

if [ "$IMGSIZE" = "" ]
then

      echo "${FILENAME}error"

elif [ "$BOTH" = "yes" ]
then

      echo "${FILENAME}${WIDTH}x${HEIGHT}"

elif [ "$RAW" = "yes" ]
then

      echo "${FILENAME}$WIDTH $HEIGHT"

elif [ "$PERL" = "yes" ]
then

      echo "${FILENAME}(-width => $WIDTH, -height => $HEIGHT)"


elif [ "$MARKDOWN" = "yes" ]
then

      echo "![]($ENCODED_FILENAME)"


elif [ "$HTML" = "yes" ]
then

      echo "<img alt='[image]' src=\"$ENCODED_FILENAME\" width=\"$WIDTH\" height=\"$HEIGHT\" border=\"0\" />"


elif [ "$JUST_WIDTH" = "yes" ]
then

      echo "${FILENAME}${WIDTH}"


elif [ "$JUST_HEIGHT" = "yes" ]
then

      echo "${FILENAME}${HEIGHT}"

else
      echo "${FILENAME}${WIDTH} ${HEIGHT}"

fi



done



exit 0
#EOF

