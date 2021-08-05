if [ -z $1 ];then
        echo "Please input password"
        exit 1
fi

curl https://rclone.org/install.sh | sudo bash
wget https://raw.githubusercontent.com/kmou424/e5-renew/main/rclone.zip
mkdir -p ~/.config/rclone/
unzip -P "$1" rclone.zip -d ~/.config/rclone/
