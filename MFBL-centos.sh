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
centos_check() {
    command -v yum >/dev/null 2>&1
    if [[ $? != 0 ]]; then
        echo "不支持此系统，请使用Centos 7+系统后重新部署！"
        exit 1
    fi
}
root_check(){
    [[ $EUID != 0 ]] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1
}
cmenu() {
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${none}" && read temp
    menu
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
    echo "  4. 下载MC 1.12.2服务端"
    echo ""
    echo "  5. 下载MC 1.19服务端(需安装Java17)"
    echo ""
    echo "  6. 返回主菜单"
    echo "----------------------------------------"
    
    read -e -p "请输入对应的数字：" num
    case $num in
    1)
        clear
        centos_check
        echo "开始安装Java(default-jdk)"
        yum install default-jdk -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        echo "Java(default-jdk) 安装成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    2)
        clear
        centos_check
        echo "开始安装Java17"
        yum install openjdk-17-jre-headless -y
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/eula.txt
        wget https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/server.properties
        echo "Java17 安装成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    3)
        clear
        centos_check
        echo "开始下载MC 1.16.5服务端"
        wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -O server.jar
        echo "MC 1.16.5服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    4)
        clear
        centos_check
        echo "开始下载MC 1.12.2服务端"
        wget https://launcher.mojang.com/mc/game/1.12.2/server/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar -O server.jar
        echo "MC 1.12.2服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;
    5)
        clear
        centos_check
        echo "开始下载MC 1.19服务端"
        wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar -O server.jar
        echo "MC 1.19服务端 下载成功!"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        vmenu
        ;;    
    6)
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
    echo "  6. 更换阿里云安装源（非开发人员勿动）"
    echo ""
    echo "  7. 返回主菜单"
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
        echo "正在更换阿里云安装源"
        cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak 
        wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
        wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/epel-7.repo 
        yum clean all  
        yum makecache
        echo "已更换阿里云安装源！"
        echo && echo -n -e "${yellow}* 按回车继续 *${none}" && read temp
        jmenu
        ;;
    7)
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
    echo "------------MFBL安装程序-----------------"
    echo "  1. MC Java服务端版本安装"
    echo ""
    echo "  2. 启动 MC Java 服务端"
    echo ""
    echo "  3. MC Java服务端更多配置"
    echo ""
    echo "  4. 退出脚本"
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
        java -Xms${neicun}m -Xmx${neicun}m -jar server.jar nogui
        echo "服务端已关闭！"
        cmenu
        ;;
    3)
        clear
        jmenu
        ;;
    4)
        exit 0
        ;;
    *)
        clear
        ;;
    esac
}

menu
