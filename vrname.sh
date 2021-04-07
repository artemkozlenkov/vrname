#!/bin/bash

[[ ! -z $(exiftool -ver) ]] && echo $(exiftool -ver) || echo 'sudo apt-get install -y exiftool';


if [ -z "$@" ]; then 
  dirname=${PWD##*/} 
  shopt -s extglob          
  result=${dirname%%+(/)}    
  input=${result##*/}
  input=$(printf "%s_" "$input") 
else
  input=$(printf "%s_" "$1") 
fi;


for f in "$(pwd)"/*.mp4; do
  datetime="$(exiftool "${f}" | grep 'Media Create Date')"
  strReplaced="${datetime/'Media Create Date'/$input}"
  modified=$(sed 's/://g' <<<"$strReplaced")
  fileName=$(basename "${f}")
  mv "$fileName" "${modified// /}.mp4" | echo "file renamed: ${modified// /}.mp4"
done

