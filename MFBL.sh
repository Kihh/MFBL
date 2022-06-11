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
neicun=1024
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
jmenu(){
clear
echo "------------MC Java 配置-----------------"
echo "  1. 关闭MC Java正版验证"
echo ""
echo "  2. 设置MC Java服务器启动内存(当前：${neicun} ）"
echo ""
echo "  3. 更换阿里云安装源"
echo ""
echo "  4. 返回主菜单"
echo "----------------------------------------"

read -e -p "请输入对应的数字：" num
case $num in
    1)
    sed -i "s/online-mode=true/online-mode=false/g" server.properties
    echo "关闭正版验证成功！"
    cmenu
	;;
    #设置内存
    2)
    read -p "设置MC Java服务器内存:" neicun
    echo "当前内存为 ${neicun}"
    cmenu
	;;
    3)
    echo "正在更换阿里云安装源"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak_`date "+%y_%m_%d"`
    sudo sed -i 's/http:\/\/.*.ubuntu.com/https:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
    sudo apt update
    sudo apt upgrade
    echo "已更换阿里云安装源！"
    cmenu
	;;
	4)
	menu
	;;
	*)
	clear
esac
}
#正片开始
menu(){
clear
echo "------------MFBL安装程序-----------------"
echo "  1. 一键安装java default + MC java 1.16.5"
echo ""
echo "  2. 启动 MC Java 服务端"
echo ""
echo "  3. MC Java服务端更多配置"
echo ""
echo "  5. 一键安装MC Bedrock 1.19.1.01"
echo ""
echo "  6. 启动 MC Bedrock 服务端"
echo ""
echo "  7. 退出脚本"
echo "----------------------------------------"

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
    wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
    echo "java default + MCJAVA 1.16.5 安装成功，请执行2开启服务端！"
    cmenu
	;;
	2)
    clear
    echo "正在启动Minecraft服务端，已自动同意EULA协议"
    sudo java -Xms${neicun}m -Xmx${neicun}m -jar server.jar nogui
    echo "服务端已关闭！"
    cmenu
	;;
    3)
    clear
    jmenu
	;;
    4)
    clear
    ubuntu_check
    echo "开始安装MC Bedrock 1.19.1.01"
    apt install -y bash curl sudo screen unzip
    wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.1.01.zip
    unzip bedrock-server-1.19.1.01.zip
    echo "MC Bedrock 1.19.1.01安装成功，请执行5开启服务端！"
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
