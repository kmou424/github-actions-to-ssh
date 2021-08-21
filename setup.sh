if [ -z $1 ];then
        echo "Please input filename"
        exit 1
fi
chmod +x $HOME/*.sh
bash rclone.sh $1
bash aria2install.sh $1
