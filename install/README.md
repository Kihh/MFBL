### Ubuntu/Debian一键安装脚本</br>
```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL.sh -O MFBL.sh && bash MFBL.sh
```
后续运行无需再次下载直接输入```bash MFBL.sh```即可

#### 国内主机请使用jsdelivr代理线路安装 </br>

```shell
wget --no-check-certificate https://fastly.jsdelivr.net/gh/Kihh/MFBL@main/MFBL.sh -O MFBL.sh && bash MFBL.sh
```
由于CDN缓存问题，如果下载到的不是最新版本请等待2-3小时后重新下载部署！
</br>
</br>

#### Beta测试版

```shell
bash -c "$(wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL-beta.sh -O -)"
```
测试版本在使用过程中可能出现不可预料的问题，谨慎使用
</br>
</br>

#### Centos一键安装脚本(暂不支持部署Bedrock Server) </br>

```shell
wget --no-check-certificate https://raw.githubusercontent.com/Kihh/MFBL/main/MFBL-centos.sh && bash MFBL-centos.sh
```
</br>
