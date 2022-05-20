clear
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

error() {
    echo -e "\n$red 输入有误! $none\n"
}
ubuntu_check() {
    command -v apt >/dev/null 2>&1
    if [[ $? != 0 ]]; then
        echo "不支持此系统，请使用Ubuntu 20+系统后重新部署！"
        exit 1
    fi
}

# 说明
echo
echo -e "$yellow此脚本适用于Ubuntu系统，最佳适用于Ubuntu 20+系统，非Ubuntu系统请重装后部署此脚本！按Ctrl + C退出MFBL$none"
echo "----------------------------------------------------------------"
read -rsp "$(echo -e "点按 $green Enter  $none 继续   或按 $red Ctrl + C $none 退出脚本.")" -d $'\n'
echo
#更新系统centos+ubuntu
apt update
apt install -y bash curl sudo screen
menu(){
echo "------------MFBL安装程序-----------------"
echo "  1.一键安装java default + MCJAVA 1.16.5"
echo ""
echo "  2.启动 MCJAVA 服务端"
echo ""
echo "  3.穷请点此，替换覆盖关闭正版验证文件"
echo ""
echo "  4.退出脚本"
echo "----------------------------------------"
echo "$yellow#如有需要自行挂screen运行本脚本，脚本已自动安装screen$none"

read -e -p "请输入对应的数字：" num
case $num in
	1)
    clear
    ubuntu_check
    echo "开始安装java default + MCJAVA 1.16.5"
    sudo apt install default-jdk -y
    wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
    wget https://raw.githubusercontent.com/Kihh/MFBL/main/eula.txt
    wget https://raw.githubusercontent.com/Kihh/MFBL/main/olmode/server.properties
    echo "java default + MCJAVA 1.16.5 安装成功，请执行2开启服务端！"
	;;
	2)
    clear
    echo "正在启动Minecraft服务端，已自动同意EULA协议"
    sudo java -Xms1024m -Xmx1024m -jar server.jar nogui
    echo "服务端已关闭！"
	;;
    3)
    wget https://raw.githubusercontent.com/Kihh/MFBL/main/falseolmode/server.properties
    echo "关闭正版验证成功！"
	;;
	4)
	exit 0
	;;
	*)
	clear
	menu
esac
}