## 👏使用MFBL，在Linux系统中快速部署Minecraft服务器
# 因其他原因，暂时停止更新，MC 1.19.1 前均可正常开服
# 及其测试版任不稳定，但也暂停更新
中文文档 | [英文文档](https://github.com/Kihh/MFBL/blob/main/README-en-us.md)</br>
</br>
如果你的服务器本身配置不高，还跑WindowsServer系统，那还怎么跑Minecraft服务器？</br>
所以在Linux发行版系统中部署Minecraft是绝佳选择，但命令行用起来始终比图形界面困难，此项目可以使用Shell脚本代替GUI，达到一样的效果</br>
</br>
Shell脚本已经实机测试支持多个Linux发行版系统，功能包括安装卸载不同版本的Java和MC核心，一键启动服务端，配置服务端功能以及陆续支持的一键部署和内网穿透功能，稳定版本保证脚本运行绝对稳定，已经过多次实机测试，Beta版为预览版本，仅共预览体验。脚本已开源且绝对安全，请放心使用</br>
### 安装脚本
### Ubuntu/Debian一键安装脚本</br>
```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL.sh -O MFBL.sh && bash MFBL.sh
```
后续运行无需再次下载直接输入```bash MFBL.sh```即可

#### 国内主机请使用jsdelivrCDN线路安装 </br>

```shell
wget --no-check-certificate https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/MFBL.sh -O MFBL.sh && bash MFBL.sh
```
由于CDN缓存问题，如果下载到的不是最新版本请等待5-10分钟后重新下载部署！
</br>
</br>

#### Beta测试版

```shell
wget --no-check-certificate https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/MFBL-beta.sh -O MFBL-beta.sh && bash MFBL-beta.sh
```
测试版本在使用过程中可能出现不可预料的问题，谨慎使用
</br>
</br>

#### Centos一键安装脚本(暂不支持部署Bedrock Server) </br>

```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL-centos.sh && bash MFBL-centos.sh
```
</br>

