if [ -z $1 ];then
	echo "Please input download link"
	exit 1
fi

if [ -z $2 ];then
        echo "Please input download filename"
        exit 1
fi

if [ -z $3 ];then
	location="/GithubActions"
	echo "Not detect upload location you inputed, use default: $location"
else
	location_temp="$3"
	if [ ${location_temp:0:1} = "/" ];then
		location="/GithubActions$3"
	else
		location="/GithubActions/$3"
	fi
	echo "Detected custom location settings, your files will be upload to $location"
fi

echo
echo "# Starting download file"
wget --user-agent="LogStatistic" "$1" -O "$2"
echo
echo
echo "# Starting upload file(may take up a long time, please wait)"
rclone mkdir e5:/GithubActions/"$location"
./OneDriveUploader -f -s "$2" -r "$location"
echo
echo "# Running competed"
