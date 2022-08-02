## 👏 Use MFBL to quickly deploy Minecraft server in Linux
If your server itself is not well configured and still runs Windows Server system, how can you still run Minecraft server? </br>
So deploying Minecraft in a Linux distribution system is an excellent choice, but the command line is always more difficult to use than the graphical interface. This project can use Shell script instead of GUI to achieve the same effect</br>
</br>
Shell scripts have been tested on real machines to support multiple Linux distribution systems. The functions include installing and uninstalling different versions of Java and MC cores, one-click startup of the server, configuration of server functions, and successively supported one-click deployment and intranet penetration functions. At present, the script has more than 500 lines of code and more than 100 submission records. The stable version ensures that the script runs absolutely stable. It has been tested on real machines for many times. The Beta version is a preview version, only for preview experience</br>
### install script
### Ubuntu/Debian one-click installation script</br>
```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL.sh -O MFBL.sh && bash MFBL.sh
````
Subsequent runs do not need to download again and directly enter ```bash MFBL.sh```

#### For servers in China, please use the jsdelivr CDN line to install </br>

```shell
wget --no-check-certificate https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/MFBL.sh -O MFBL.sh && bash MFBL.sh
````
Due to the CDN cache problem, if the downloaded version is not the latest version, please wait for 5-10 minutes to download and deploy again!
</br>
</br>

#### Beta version

```shell
bash -c "$(wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL-beta.sh -O -)"
````
Unforeseen problems may occur during the use of the test version, use it with caution
</br>
</br>

#### Centos one-click installation script (temporarily does not support the deployment of Bedrock Server) </br>

```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL-centos.sh && bash MFBL-centos.sh
````
</br>
