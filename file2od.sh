if [ -z $1 ];then
        echo "Please input filename"
        exit 1
fi

if [ -z $2 ];then
	location="GithubActions"
	echo "Not detect upload location you inputed, use default: /$location"
else
	location_temp="$2"
	if [ ${location_temp:0:1} = "/" ];then
		location="GithubActions$2"
	else
		location="GithubActions/$2"
	fi
	echo "Detected custom location settings, your files will be upload to /$location"
fi

echo
echo "# Starting upload file(may take up a long time, please wait)"
rclone mkdir e5:/"$location"
./OneDriveUploader -f -s "$1" -r "$location"
echo
echo
echo "# Clean up downloaded file"
rm -rf "$1"
echo
echo "# Running completed"
