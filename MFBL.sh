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
cmenu() {
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${none}" && read temp
    menu
}
#正片开始
menu(){
clear
echo "------------MFBL安装程序-----------------"
echo "  1.一键安装java default + MC java 1.16.5"
echo ""
echo "  2.启动 MC Java 服务端"
echo ""
echo "  3.关闭MC Java正版验证"
echo ""
echo "  4.一键安装MC Bedrock 1.18.33.02"
echo ""
echo "  5.启动 MC Bedrock 服务端"
echo ""
echo "  6.退出脚本"
echo "----------------------------------------"
echo "#如有需要自行挂screen运行本脚本，运行一键安装后会自动安装screen"

read -e -p "请输入对应的数字：" num
case $num in
	1)
    clear
    ubuntu_check
    echo "开始安装java default + MCJAVA 1.16.5"
    apt install -y bash curl sudo screen
    sudo apt install default-jdk -y
    wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
    wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
    wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/olmode/server.properties
    echo "java default + MCJAVA 1.16.5 安装成功，请执行2开启服务端！"
    cmenu
	;;
	2)
    clear
    echo "正在启动Minecraft服务端，已自动同意EULA协议"
    sudo java -Xms1024m -Xmx1024m -jar server.jar nogui
    echo "服务端已关闭！"
    cmenu
	;;
    3)
    sed -i "s/online-mode=true/online-mode=false/g" server.properties
    echo "关闭正版验证成功！"
    cmenu
	;;
    4)
    clear
    ubuntu_check
    echo "开始安装MC Bedrock 1.18.33.02"
    apt install -y bash curl sudo screen unzip
    wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.18.33.02.zip
    unzip bedrock-server-1.18.33.02.zip
    echo "MC Bedrock 1.18.33.02安装成功，请执行5开启服务端！"
    cmenu
	;;
    5)
    clear
    echo "正在启动Minecraft Bedrock服务端"
    LD_LIBRARY_PATH=. ./bedrock_server
    echo "服务端已关闭！"
    cmenu
	;;
	6)
	exit 0
	;;
	*)
	clear
esac
}

menu
