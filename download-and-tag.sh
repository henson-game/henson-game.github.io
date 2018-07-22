#!/bin/bash


declare -r artist_name="${1}"
declare -r song_name="${2}"
declare -r video_url="${3}"

declare video_format
declare temp_filename

video_format="$(youtube-dl -F "${video_url}" | tail -n 1 | sed -nr 's/([0-9]+) .*/\1/p')"

temp_filename="$(youtube-dl -f "${video_format}" -x --audio-format=mp3 "${video_url}" | sed -nr 's/.*Destination: (.*.mp3)/\1/p')"

id3v2 -a "${artist_name}" -t "${song_name}" "${temp_filename}"
mv -v "${temp_filename}" "${artist_name// /_}-${song_name// /_}.mp3"