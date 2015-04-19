#!/bin/bash

# brew install ffmpeg --with-fdk-aac

# variables
i=0
green='\033[0;32m'
reset='\033[0m'
output_file="output/output.mp3"

mkdir -p input
mkdir -p output

echo "${green}Combining the following audiobook parts: ${reset}"
for audiobook in input/*.mp3; do
	# get audiobook name without the input prefix
	name="${audiobook#"input/"}"

	# get the filename without the extension
	filename="${name%.*}"

	# concat parts file into a single string for
	if [[ $i < 1 ]]; then
		parts="${audiobook}"
	else
		parts="$parts|${audiobook}"
	fi

	echo "${name}"
	(( i++ ))
done

echo "${green}Ready to combine and convert to m4b (y/n)? ${reset}"
read response
if echo "$response" | grep -iq "^y" ;
then
	echo "${green}Combining audiobook parts... ${reset}"
	ffmpeg -i concat:"${parts}" -acodec copy output/output.mp3

	if [ -f "$output_file" ]
	then
		echo "${green}Converting mp3 to m4a... ${reset}"
		ffmpeg -i "${output_file}" -c:a libfdk_aac "output/${filename}-converted.m4a"
		if [[ -f "output/${filename}-converted.m4a" ]]; then
			echo "${green}Renaming .m4a to .m4b... ${reset}"
			rm -rf ${output_file}
			cd output/ && rename -s m4a m4b *
			say -v "Vicki" Finished
		fi
	fi
fi