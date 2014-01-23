#!/bin/sh

## original source
# https://github.com/chia/minify_recursive/blob/master/minify_recursive.sh

# Configuration
YUICOMPRESSOR_PATH="/path/to/yuicompressor-2.4.8.jar"

# if you want to enable it for specific directory set it here, by default its current dir
CURRENT_DIR=$PWD

# First argument must be either css / js
TYPE=$1

# Second argument - folder - must be specified 
if [ !  -d $2 ]; then
  echo "Second argument must be a folder / directory. $file $ERROR_DISPLAY"
  exit 0
fi


# Status messages
ERROR_DISPLAY="\t\033[31;40m\033[1m[error]\033[0m"
OK_DISPLAY="\t\033[1;32;40m\033[1m[ok]\033[0m"

create_directory_if_not_exist() {
  # check if directory exists
  if [ ! -d $1 ];
  then
   mkdir -p $1 >/dev/null 2>&1 ||  echo "Error: Failed to create $1 directory. $ERROR_DISPLAY"
  fi
}

[ -z $TYPE ] && \
  echo "First argument missing, it should be either css or js. $ERROR_DISPLAY" && \
  exit 0

[ $TYPE != 'js' ] && [ $TYPE != 'css' ] && \
  echo "First argument must be either css or js. $ERROR_DISPLAY" && \
  exit 0

[ -z $YUICOMPRESSOR_PATH ] || [ ! -f $YUICOMPRESSOR_PATH ] && \
  echo "YUICOMPRESSOR_PATH must be correctly set. $ERROR_DISPLAY" && \
  exit 0

# If second argument is not null use it as current directory
if [ ! -z "$2" ];
then
  # Make all path absolute
   [[ $2 = /* ]] && \
   CURRENT_DIR=$2 || \
   CURRENT_DIR="$PWD/$2"
fi
echo "Minifying all $TYPE files recursively in $CURRENT_DIR $OK_DISPLAY"

for file in `find $CURRENT_DIR -name "*.$TYPE"`
  do   
    # Get the current file directory
    FILE_DIRECTORY=$(dirname $file)
    # Get the basename of the current directory
    BASE_DIR_NAME=`basename $FILE_DIRECTORY`

    if test $BASE_DIR_NAME != 'minified';
    then
      # Get the current file name
      BASE_FILE_NAME=`basename $file`
      MINIFIED_FILE_NAME=${BASE_FILE_NAME%$TYPE}min.$TYPE
      # Minified directory path for the current file
	  
  		# if file is already minified skip that file
  		if ( echo $file | grep -qE ^*min.$TYPE$ )
    		then 
    			echo "Already minified: $file $ERROR_DISPLAY"
    	# if the file does not have a minified version create it!
    		else		
    			# MINIFIED_FILE_DIRECTORY="$FILE_DIRECTORY/minified" # ORG
    			MINIFIED_FILE_DIRECTORY="$FILE_DIRECTORY"
    			# create_directory_if_not_exist $MINIFIED_FILE_DIRECTORY # ORG
    			MINIFIED_OUTPUT_FILE="$MINIFIED_FILE_DIRECTORY/$MINIFIED_FILE_NAME"
    			echo "Compressing $file $OK_DISPLAY"
    			java -jar $YUICOMPRESSOR_PATH --type $TYPE -o $MINIFIED_OUTPUT_FILE $file
  		fi
    fi 
  done
