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
java_check() {
    command -v java >/dev/null 2>&1
    if [[ $? != 0 ]]; then
        echo "当前未安装Java，请安装后重试！"
        cmenu
    fi
}
root_check(){
    [[ $EUID != 0 ]] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1
}
cmenu() {
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${none}" && read temp
    menu
}
Ngrokmenu() {
    clear
    echo "--------------Ngrok内网穿透--------------"
    echo "  1. 安装&设置Ngrok内网穿透"
    echo ""
    echo "  2. 修改Ngrok设置"
    echo ""  
    echo "  3. 启动Ngrok并内穿服务器25565端口"
    echo ""
    echo "  4. 关闭Ngrok"
    echo ""
    echo "  5. 查看内网穿透地址"
    echo ""
    echo "  6. 卸载Ngrok内网穿透工具"
    echo ""
    echo "  7. 返回更多工具"
    echo "----------------------------------------"
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok-stable-linux-amd64.zip
        apt install unzip -y
        unzip ngrok-stable-linux-amd64.zip
        chmod +x ngrok
        rm -rf ngrok-stable-linux-amd64.zip
        echo "Ngrok内网穿透安装完成！"
        read -e -p "请输入Ngrok Authtoken：" NGROKTOKEN
        read -e -p "请输入内穿服务器地区(默认jp)：" REGION
        if [ -z "${REGION}" ];then
	        REGION="jp"
        fi
        echo "Ngrok设置完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;
    2)
        clear
        read -e -p "请输入Ngrok Authtoken：" NGROKTOKEN
        read -e -p "请输入内穿服务器地区(默认jp)：" REGION
        if [ -z "${REGION}" ];then
	        REGION="jp"
        fi
        echo "Ngrok设置完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;
    3)
        clear
        apt install screen -y
        screen -dmS ngrokstart bash -c './ngrok tcp --authtoken ${NGROKTOKEN} --region ${REGION} 25565';
        echo "Ngrok内网穿透已开启！"
        echo "curl -s http://localhost:4040/api/tunnels | python3 -c \"import sys, json; print(\\\"内网穿透地址:\\\n\\\",\\\"\\\"+json.load(sys.stdin)['tunnels'][0]['public_url'][6:].replace(':', ':'),\\\"\\\n\\\")\" || echo \"\n错误：请检查Ngrok密钥是否正确，或密钥是否被占用\n\""
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;
    4)
        clear
        screen -S ngrokstart -X quit
        echo "Ngrok内网穿透已关闭！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;
    5)
        clear
        echo "curl -s http://localhost:4040/api/tunnels | python3 -c \"import sys, json; print(\\\"内网穿透地址:\\\n\\\",\\\"\\\"+json.load(sys.stdin)['tunnels'][0]['public_url'][6:].replace(':', ':'),\\\"\\\n\\\")\" || echo \"\n错误：请检查Ngrok是否开启\n\""
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;    
    6)
        clear
        rm -rf ngrok
        echo "Ngrok卸载完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        Ngrokmenu
        ;;
    7)
        clear
        tmenu
        ;;
    *)
        clear
        ;;
    esac
}
tmenu() {
    clear
    echo "--------------MFBL更多工具----------------"
    echo "  1. 更新软件源和软件"
    echo ""
    echo "  2. 卸载所有Java环境"
    echo ""  
    echo "  3. Ngrok内网穿透配置"
    echo ""
    echo "  4. 更换阿里云安装源（非开发人员勿动）"
    echo ""
    echo "  5. 返回主菜单"
    echo "----------------------------------------"
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        apt-get update
        apt-get upgrade
        clear
        echo "更新软件源和软件完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        tmenu
        ;;
    2)
        clear
        java_check
        apt-get purge default-jdk
        apt-get purge openjdk-17-jre-headless
        apt-get purge openjdk-8-jre-headless
        apt-get purge openjdk-11-jre-headless
        apt-get purge openjdk-18-jre-headless
        clear
        echo "Java环境卸载完成，此功能仅能卸载APT及脚本内安装的Java环境，若不能完全卸载编译安装的Java环境请手动卸载！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        tmenu
        ;;
    3)
        Ngrokmenu
        ;;
    4)
        echo "正在更换阿里云安装源"
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak_$(date "+%y_%m_%d")
        sudo sed -i 's/http:\/\/.*.ubuntu.com/https:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
        sudo apt update -y
        sudo apt upgrade -y
        echo "已更换阿里云安装源！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        tmenu
        ;;
    5)
        menu
        ;;
    *)
        clear
        ;;
    esac
}
omenu() {
    clear
    echo "-------------MC 一键部署-----------------"
    echo "  1. 部署Java + MC 1.16.5 服务端"
    echo ""
    echo "  2. 部署Java17 + MC 1.19.1"
    echo "" 
    echo "  3. 部署Spigot-1.8.8起床战争整合包"
    echo ""
    echo "  4. 返回主菜单"
    echo "----------------------------------------"
    
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        ubuntu_check
        echo "开始安装Java(default-jdk)"
        apt-get update -y
        sudo apt install default-jdk -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        echo "Java(default-jdk) 安装成功!"
        echo "开始下载MC 1.16.5服务端"
        wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -O server.jar
        echo "MC 1.16.5服务端 下载成功!"
        clear
        echo "Java + MC 1.16.5 部署完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        omenu
        ;;
    2)
        clear
        ubuntu_check
        apt-get update -y
        sudo apt install openjdk-17-jre-headless -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar -O server.jar
        clear
        echo "Java17 + MC 1.19.1 部署完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        omenu
        ;;
    3)
        clear
        ubuntu_check
        echo "开始部署Spigot-1.8.8起床战争整合包"
        apt-get update -y
        sudo apt install openjdk-8-jre-headless -y
        wget https://mfblserverfile-kaggw.run-us-west2.goorm.io/mfblbedwars.zip
        apt install unzip -y
        unzip mfblbedwars.zip
        echo "Spigot-1.8.8起床战争整合包部署完成！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        omenu
        ;;
    4)
        menu
        ;;
    *)
        clear
        ;;
    esac
}
vmenu() {
    clear
    echo "------------MC Java 版本-----------------"
    echo "  1. 安装Java(default-jdk)"
    echo ""
    echo "  2. 安装Java17(适用于MC 1.18及以上版本)"
    echo ""
    echo "  3. 下载MC 1.16.5服务端"
    echo ""
    echo "  4. 下载MC 1.15.2服务端"
    echo ""
    echo "  5. 下载MC 1.14.4服务端"
    echo ""
    echo "  6. 下载MC 1.12.2服务端"
    echo ""
    echo "  7. 下载MC 1.19服务端(需安装Java17)"
    echo ""
    echo "  8. 返回主菜单"
    echo "----------------------------------------"
    
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        ubuntu_check
        echo "开始安装Java(default-jdk)"
        apt-get update -y
        sudo apt install default-jdk -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        echo "Java(default-jdk) 安装成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    2)
        clear
        ubuntu_check
        echo "开始安装Java17"
        apt-get update -y
        sudo apt install openjdk-17-jre-headless -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        echo "Java17 安装成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    3)
        clear
        ubuntu_check
        echo "开始下载MC 1.16.5服务端"
        wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -O server.jar
        echo "MC 1.16.5服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    4)
        clear
        ubuntu_check
        echo "开始下载MC 1.15.2服务端"
        wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -O server.jar
        echo "MC 1.15.2服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    5)
        clear
        ubuntu_check
        echo "开始下载MC 1.14.4服务端"
        wget https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar -O server.jar
        echo "MC 1.14.4服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    6)
        clear
        ubuntu_check
        echo "开始下载MC 1.12.2服务端"
        wget https://launcher.mojang.com/mc/game/1.12.2/server/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar -O server.jar
        echo "MC 1.12.2服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    7)
        clear
        ubuntu_check
        echo "开始下载MC 1.19服务端"
        wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar
        echo "MC 1.19服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;    
    8)
        menu
        ;;
    *)
        clear
        ;;
    esac
}
jmenu() {
    clear
    echo "------------MC Java 配置-----------------"
    echo "  1. 关闭MC Java正版验证"
    echo ""
    echo "  2. 开启MC Java正版验证"
    echo ""
    echo "  3. 设置MC Java服务器启动内存(当前：${neicun} )"
    echo ""
    echo "  4. 启用命令方块"
    echo ""
    echo "  5. 关闭命令方块"
    echo ""
    echo "  6. 返回主菜单"
    echo "----------------------------------------"

    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        sed -i "s/online-mode=true/online-mode=false/g" server.properties
        echo "关闭正版验证成功！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    2)
        sed -i "s/online-mode=false/online-mode=true/g" server.properties
        echo "开启正版验证成功！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    3)
        read -p "设置MC Java服务器内存:" neicun
        echo "当前内存为 ${neicun}"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    4)
        sed -i "s/enable-command-block=false/enable-command-block=true/g" server.properties
        echo "启用命令方块成功！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    5)
        sed -i "s/enable-command-block=true/enable-command-block=false/g" server.properties
        echo "关闭命令方块成功！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    6)
        menu
        ;;
    *)
        clear
        ;;
    esac
}
#正片开始
menu() {
    root_check
    clear
    echo "--------------MFBL安装程序---------------"
    echo "  1. MC Java服务端版本安装"
    echo ""
    echo "  2. 启动 MC Java 服务端"
    echo ""
    echo "  3. MC Java服务端更多配置"
    echo ""
    echo "  4. MFBL一键部署"
    echo ""
    echo "  5. 一键安装MC Bedrock 1.19.1.01"
    echo ""
    echo "  6. 启动 MC Bedrock 服务端"
    echo ""
    echo "  7. MFBL更多工具"
    echo ""
    echo "  8. 退出脚本"
    echo "----------------------------------------"
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        vmenu
        ;;
    2)
        clear
        echo "正在启动Minecraft服务端，已自动同意EULA协议"
        java_check
        java -Xms${neicun}m -Xmx${neicun}m -jar server.jar nogui
        echo "服务端已关闭！"
        cmenu
        ;;
    3)
        clear
        jmenu
        ;;
    4)
        clear
        omenu
        ;;
    5)
        clear
        ubuntu_check
        echo "开始安装MC Bedrock 1.19.1.01"
        apt-get update
        apt install -y bash curl sudo screen unzip
        wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.1.01.zip
        unzip bedrock-server-1.19.1.01.zip
        echo "MC Bedrock 1.19.1.01安装成功，请执行5开启服务端！"
        cmenu
        ;;
    6)
        clear
        echo "正在启动Minecraft Bedrock服务端"
        LD_LIBRARY_PATH=. ./bedrock_server
        echo "服务端已关闭！"
        cmenu
        ;;
    7)
        clear
        tmenu
        ;;
    8)
        exit 0
        ;;
    *)
        clear
        ;;
    esac
}

menu
