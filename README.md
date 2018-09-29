
---

 ----------- 最后一次更新 2018-09-29 -------------

差不多一年没有更新过repo了，一个是懒，另外一个是github上遍地开花，大家都分享了自己的配置，搜一下总会找到比我这个完善的；最后一个就是，从10.11开始我就一直明确的目标，我的XPS是日常主力开发机型，它担当着生产力工具的重任，并不适合经常去折腾。

很多朋友在repo里提了issue，我也没时间没精力去研究帮助解决，只能靠大家多爬insanelymac和tonymacx86还有pcbeta了。

接下来会开一个10.14的repo，还是老样子，只是单纯分享自己的配置，大家可以参考、调整，找到最合适自己的。

对了，Other文件夹里提供了`VoodooI2C`触摸板驱动，这个可以模拟Magic Trackpad的手势(双指缩放，三指拖拽，四指各种），需要配合VoodooPS2使用，直接放clover/kexts/other里重启就行了，但是目前它并不稳定，**只建议有经验的用户**折腾，否则开不了机什么的你又不会用`UEFI Shell`来删除它，那你就很被动了。

啊，还得说一点，这套配置我在10.13.6的时候是配合HFS+文件系统使用的，不知道APFS下会不会有什么问题，不过理论上应该不会，因为我用这配置升级到10.14正式版+APFS，也没出什么乱子。忘了提，我BIOS好像是`1.6.1`。

总之，**TimeMachine**是很有必要的一件事，不要拿重要数据来冒风险。

---

## XPS15-9550 macOS High Sierra 教程

10.13为第三方NVMe SSD带来支持，以及Clover DSDT热补丁技术的普及，进一步降低了黑苹果的门槛，前段时间我10.12.1的教程写得各种混乱，让黑苹果新手看得云里雾里的，决定重新写一个完全版的新手向教程，但是是**针对我个人的硬件配置写的**，我没有4K屏，如果有4K屏的同学愿意提供相关的补充，那就太感谢了。

### 机型配置

- 机型：DELL XPS15 9550
- CPU：Intel i7 6700HQ
- 内存：16G DDR4 2400（原厂8G，自己换了）
- 硬盘：东芝XG3 256G NVMe SSD (THNSN5256GPU7)
- 核显：HD530, 1920x1080
- 声卡：Realtek ALC298（也叫ALC3266）
- 无线网卡：DW1830（带蓝牙）

DW1830是免驱的，如果你的无线网卡是Killer的，那就很不幸了，目前还没有驱动，你得去深水宝买一张免驱卡来更换才行。

### 安装完之后的一些问题

- 独显不指望了
- 无线5GHz达不到最高速度（我没具体测试过）
- ThunderBolt/USB-C 应该不行（没设备测试）
- 低亮度会有轻微闪屏

### 硬件准备

- 大于等于**8G**的U盘一个（用的时候会完全清空，请先备份好重要资料）
- 另外一台电脑（防止因你遇到什么特殊情况无法顺利完成安装时，可以搜索爬贴）

### 软件准备

- Win系统（一般刚买回来的XPS就是win10了）
- TransMac（下载[辅助工具](https://pan.baidu.com/s/1sla24zj)）
- [Download ZIP](https://github.com/darkhandz/XPS15-9550-High-Sierra/archive/master.zip)后解压得到的文件夹（下称**我Repo提供的文件**）
- 带Clover引导的macOS安装映像一个（可以在pcbeta论坛找，我这里也[提供一个10.13PB的](https://pan.baidu.com/s/1hspDXcS)）

#### 关于系统安装镜像

为什么我要建议你准备一个带Clover引导的映像呢，完全是为了不想你用两个U盘分别做**引导**和**安装**那么麻烦。

写本文的时候论坛里找不到有带**Clover**的**10.13PB(17A315i)**映像，于是我就自己弄了一个带`Clover4124`的。其实我也不知道正宗的方法是怎么制作**DMG**，就自己搜索几个教程用`hdiutil`瞎搞了一下，自己用`TransMac`试写到U盘竟然凑合可以用，于是就放上来了。

考虑到我提供的映像版本很快会过时，但是基本操作步骤是不会过时的，所以如果你在看本文的时候发现pcbeta论坛有更加新版的系统映像，不妨去下载新的。

### BIOS版本

开机狂按`F2`，进入BIOS设置界面，在`General`-`System Information`看看你的`Bios version`是什么。
如果是比`1.2.21`更小，则可以在[这里下载](https://pan.baidu.com/s/1bA7Cj8)到`1.2.21`，然后接上笔记本电源，确保电池电量大于20%，在windows环境双击这个exe，升级成`1.2.21`。
如果出厂版本就比`1.2.21`更大，虽然说可以降级，但是我不清楚会不会出现什么意外，所以，接下来就会麻烦一点。

### 写映像到U盘

右击TransMac，以管理员身份运行，然后看图操作，耐心等待几分钟，出现Restore Complete即为写入完成。
（图片是旧教程里的，dmg名字请忽略）

![](http://darkhandz.qiniudn.com/2017-07-27-15008814357644.jpg)

写完映像之后，U盘会变成两个分区，一个叫`EFI`的就是`U盘引导区`，里面存在**UEFI版本的Clover**；另外一个叫`U盘`的提示你未格式化，这个时候千万不要手贱去格式化，这是因为windows认不出macOS的文件系统而已，并不是里面没有东西。

打开资源管理器，你可以大概浏览一下U盘`EFI`引导区目录结构：

![](http://darkhandz.qiniudn.com/2017-07-27-15008824001924.jpg)

- 顶上的`AptioFix2`文件夹是我留给你备用的 
- 红色箭头的`config.plist`是Clover的配置文件
- 绿色箭头是`AptioFix`，先有个印象

如果你是从论坛下载的带Clover引导的dmg映像，你可以在我的`辅助工具`里找到`USB-EFI.zip`，解压出来的文件就是上图所有文件了，删除你U盘引导区里所有文件，把解压得到的所有文件复制进去。

- 如果你和我一样是`i7`的CPU，可以进入下一步`BIOS设置`了。
- 如果你是`i5`的CPU，用[Notepad++](https://notepad-plus-plus.org/download/v7.4.2.html)打开`config.plist`，搜索`191b0000`，改成`19160000`，保存。

### BIOS设置

重启，开机狂按F2，直到**DELL Logo**下方出现蓝色进度条，错过的话，重启再试。

- Secure Boot - Secure Boot Enable里改成`Disabled`
- System Configuration - SATA Operation 改成 `AHCI`

#### 注意

一旦你把`SATA Operation`从`RAID On`改成了`AHCI`，你的原厂win10就启动不了了，你需要改回`RAID On`才能启动win10.

#### 自动发现启动项

在 General - Boot Sequence，在右边列表找到一个`UEFI: U盘型号, Partition 1`这样的启动项，如下图，把它挪到最顶部，然后`Apply`，`OK`，`Exit`，就可以让U盘第一启动顺序了。

- 如果你找到这样的启动项，跳到下面的`Clover引导`小节
- 如果你没找到，往下看。

![](http://darkhandz.qiniudn.com/2017-07-27-15010307433600.jpg)



#### 手动添加U盘引导项

右边点击`Add Boot Option`，如下图操作，`Boot Option Name`可以随便填，我这里写`USB-Clover`，然后点击`File Name`右边的按钮进入选择引导的efi文件。

![](http://darkhandz.qiniudn.com/2017-07-27-15009443383614.jpg)

选择文件的操作如下：

![](http://darkhandz.qiniudn.com/2017-07-27-15009450911043.jpg)


然后把刚刚添加的`USB-Clover`选中，点击右边的上箭头把它置顶，然后`Apply`，`OK`，`Exit`：

![](http://darkhandz.qiniudn.com/2017-07-27-15008876062348.jpg)


#### Clover引导

如果一切顺利，笔记本重启后你可以进入到Clover引导画面了：

![](http://darkhandz.qiniudn.com/2017-07-27-15009452783378.jpg)


选择`Boot OS X Install from HS_Beta`这个**安装图标**按回车键。

- 如果顺利的话，就会进入满屏英文滚动，两三分钟后进入安装界面，请跳过下面的`slide计算`，直奔`安装`这一节。

- 如果很不幸，选择安装图标后出现了类似下面的画面，提示`can not allocate relocation block...`的话，就需要手动计算`slide`值了。

    ![1225-er](http://darkhandz.qiniudn.com/2017-07-08-1225-err.jpg)

### slide计算

用备用电脑把U盘引导里面的`AptioFix2`文件夹下的`OsxAptioFix2Drv-64.efi`剪切到`Clover/drivers64UEFI`里，然后把`OsxAptioFixDrv-64.efi`（前面绿色箭头指的那个）剪切到`AptioFix2`文件夹（留个备份）。

然后打开`config.plist`，搜索`kext-dev-mode`，在它前面加一个`slide=168 `，变成了下面这样：

```
<string>slide=168 kext-dev-mode=1 dart=0 nv_disable=1 -v</string>
```

现在保存，然后重启，再次进入Clover引导画面，选择安装图标，看看是否顺利进入满屏英文，两三分钟后进入安装界面，跳到下一节——`安装`。

如果很不幸，选择安装图标后卡住在下面的画面，说明`168`这个数不适合你：

![1218-11](http://darkhandz.qiniudn.com/2017-07-08-1218-11.jpg)

留意错误信息`Error allocating 0x13d3a pages at 0x0000000003f26000 ...`，记住`0x13d3a`这个数值，你将会面临本教程最艰难的部分。

重启，再回到Clover引导画面，如下图，选取下面行的第一个图标，进入`UEFI Shell 64`界面：

![clover-1](http://darkhandz.qiniudn.com/2017-07-08-clover-1.png)

当命令行准备好之后，输入`memmap`命令，输出如下图：

![1218-0](http://darkhandz.qiniudn.com/2017-07-08-1218-0.jpg)

不同的内存容量和不同的BIOS版本，上图的数据是不同的，上图是我自行升级的海盗船16G内存在`1.2.18`BIOS下的情况。

我们在图中找符合以下条件的行：
    1. `Type`列的值是`Available`
    2. `# Pages`列的值大于等于`13d3a`这个值
    3. `Start`列的值比`100000`大

不难得出两个结果：

| Start | # Pages |
| --- | --- |
| 9F41000 | 1DB30 |
| 100000000 | 3BE000 |

第二个`Start`数值太大了，我们只要第一个`9F41000`即可。

打开你第二台电脑的计算器，切换到`程序员`模式，选择16进制（HEX）。（如果你实在小白到不会用win的计算器，请[点击在线计算](http://www.yunsuan.org/app/s3127)，计算出来的结果忽略小数部分）

用公式：`Start / 200000 + 1` 计算出`Slide`值：`9F41000 / 200000 = 4F`，`4F + 1 = 50`，转换成10进制（点击HEX上面的DEC），显示为80。

以上计算方法参考自 [@wmchris 的教程](https://github.com/wmchris/DellXPS15-9550-OSX/blob/master/Additional/slide_calc.md)，有修改。

实测一下，在Clover启动画面，选`UEFI Shell 64`图标那行的第三个`Options`，如图，把`Boot Args`的`slide=168`改为`slide=80`（对这行按空格，就进入编辑模式了，用方向箭头移动光标），改完按回车，然后`Esc`键。（图片是以前截的显示slide=0，别在意）

![args](http://darkhandz.qiniudn.com/2017-07-08-clover-2.png)

再次选择安装图标，一般来说你就能进入安装界面了，跳到下一小节——`slide注意`。

如果计算出来的值还是有问题（出现前面同样的错误，或者只显示一排++++号就不动了），那你可以试试把计算出的值**加1或减1**，即`slide=79`和`slide=81`都试试。

如果很不幸，你还是无法进入满屏英文的画面，我只能建议你降级BIOS到`1.2.21`版本，然后用`OsxAptioFixDrv-64.efi`了，也就是U盘刚被写入dmg映像的状态。

#### slide注意

要注意的是，这里只是临时修改启动参数，你每次重启它都会恢复回原来的样子。所以我们要备用电脑，打开`config.plist`把`slide=168`改成`slide=你测试出的可启动值`，保存，然后再进入安装界面。

还有要注意的是，你的kernel cache变化的时候（安装了第三方驱动到系统），有可能会导致slide值需要重新计算。

### 进入安装前的verbose模式

满屏英文就是系统启动过程的各种信息显示，如果你卡住在这个英文画面很久（超过2分钟没有任何变化），你就要去论坛求救一下了。  
如果遇到`BrcmPatchRAM2: Firmware upgrade not needed.`5行不断重复的情况，你可以先把U盘EFI/Clover/kexts/other里面的两个Brcm开头的文件夹剪切到其他地方（可以放AptioFix2文件夹），然后再试试进安装图标。等正常安装完成后再在后面`安装硬盘引导`的时候把这两个还原回去other里。

### 安装

希望你不是经历了上面梦魇般的slide计算步骤才来到这里的，如果是的话，您辛苦了。

进入安装界面后，你可以用磁盘工具对你的SSD进行分区，比如我就分成两个`OSX`和`Source`两个区了。  
第一次进入安装过程2分钟左右就会重启，然后Clover多了一个叫`Boot macOS Install from OSX（我的系统分区名）`的图标，直接对着它回车。  
然后第二次进入的话，几秒钟就重启了。第三次进入，大概10多分钟就安装好系统了。

安装完之后笔记本自动重启，Clover的引导画面已经多了一个**系统图标**：`Boot macOS from XXX`，选择它进入就可以启动系统了，设置时区、语言、无线连接、用户登陆什么的。

有个比较重要的就是提示是否开启`FileVault`，这东西似乎和用户数据加密有关，我个人不开启，也不知道黑苹果开启了会不会有什么不好的地方，请自行搜索，斟酌。

进入桌面后建议你再重启一次系统，不然亮度调节无效。

### 硬盘EFI引导

目前都是靠U盘的Clover引导才能进入系统的，所以我们要把Clover安装到硬盘的EFI分区，让系统脱离U盘引导。

在屏幕左下方有个蓝白的笑脸图标，叫做`Finder`，打开它，然后在`Finder`窗口的左边栏找到`HS_Beta`，也就是U盘写入dmg映像后的分区，里面有个`Clover_v2.4k_r4124.pkg`，如果你不是用我的dmg映像，可以在`辅助工具-mac_app`里找到它。

![](http://darkhandz.qiniudn.com/2017-07-27-15010478826615.jpg)

双击打开，提示来自身份不明的开发者，这个时候你可以按组合键`Alt + 空格`，然后输入`term`回车，就跳出终端窗口了。  
你也可以点击Finder图标旁边的小火箭`LaunchPad`-`其他`-终端来打开。

在终端输入：`sudo spctl --master-disable`回车，提示输入密码执行，然后没有任何输出，这就代表执行成功了，这个行为我下称`执行命令`，后文还有一些命令要执行，请记住哦。

再次双击刚才的pkg进入安装。


#### 安装Clover

出现安装窗口，点击Continue（继续），再Continue，点击Change Install Location...（更改安装位置），选择你的***系统分区***，点击Continue，再点击左下角的Customize（自定义），按下图的勾选，主题你可以勾`BlackGreenMoody`，我图勾少了这个。

注意`Drivers64UEFI`选什么不重要，因为我们后面要覆盖它。

![](http://darkhandz.qiniudn.com/2017-07-27-15009491386933.jpg)

点击Install（安装），输入密码，5秒左右就安装完成了。

#### 覆盖配置

继续在`HS_Beta`里找到`Clover Configurator`，把它拖到Finder左边的`应用程序`里，然后点击Finder图标旁边的小火箭`LaunchPad`，找到`Clover Configurator`，打开。

![](http://darkhandz.qiniudn.com/2017-07-27-15010491616192.jpg)


两个都`Mount`之后，分别点击旁边的`Open Partition`，弹出两个Finder窗口，如何区分哪个是U盘的EFI区，哪个是硬盘EFI区？如果你是用我的dmg，有`AptioFix2`的那个就是U盘的EFI。否则你可以展开EFI文件夹，看看哪个的`Clover`文件夹日期比较新，哪个就是硬盘EFI。

区分好之后，我们要做的就是，把硬盘EFI的Clover文件夹下的下面四个删除：

```
ACPI
config.plist
driver64UEFI
kexts
```

然后把**U盘EFI的Clover**文件夹的这四个复制到**硬盘EFI的Clover**文件夹下：

![](http://darkhandz.qiniudn.com/2017-07-27-15009508543582.jpg)

现在应该一切就绪了，重启系统，黑屏的时候拔掉U盘，耐心等待，Clover画面再次出现的话，说明硬盘Clover引导成功。

#### 注意配置更新

如果你用的是我提供的dmg，那么U盘EFI里的文件总是针对10.13PB版本的设定，如果你在几个月后才看到本文，那时候PB早就被正式版或`10.13.x`取代了，这个时候你就应该用**本文最顶上的那些文件了**，即**我Repo提供的文件**，来覆盖到硬盘EFI的Clover文件夹。

我会跟进系统更新，把自己的最新配置更新上来github的，前提是我还没挂掉，而且还在用XPS15做`iOS开发`的话。

### 网卡顺序修正

原理嘛，忘记了，如果顺序错了，就不能在App Store下载东西。

打开`终端`，执行命令：`networksetup -listallhardwareports`，如下图，留意`en0`对应的`Port`是否**Wi-Fi**，如果是，说明顺序正确了，跳过本步骤。

![](http://darkhandz.qiniudn.com/2017-07-27-15010511349743.jpg)

如果顺序不正确，你需要点击屏幕左上角的苹果图标，打开系统偏好设置-网络，点击左下角的减号，把所有列表项删除干净，然后执行命令：`sudo rm -f /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist`，重启。

重启后，再进入系统偏好设置-网络，点击左下角的加号，**先添加WiFi，再添加蓝牙**，然后应用，就可以了。

### 安装其他辅助app

我在`HS_Beta`或**我Repo提供的文件**里提供了一个叫`Other`的文件夹，里面有几个文件夹，我们先来处理`ComboJack`。

#### ComboJack

- 执行命令：`cd 把ComboJack文件夹拖过来`
- 执行命令：`chmod +x install.sh`
- 执行命令：`./install.sh`
    
    ![](http://darkhandz.qiniudn.com/2017-11-03-132202.png)

没提示错误的话，ComboJack就安装完成了。

顺带提一下它的作用：检测耳机拔插，修复耳机孔多合一下产生的一些问题，关于它的原理，请看[wmchris的教程](https://github.com/wmchris/DellXPS15-9550-OSX/blob/master/10.12/Post-Install/AD-Kexts/Audio/VerbStub_knnspeed/README.md)。


#### VoodooPS2Daemon

- 执行命令：`cd 把VoodooPS2Daemon文件夹拖过来`
- 执行命令：`chmod +x _install.command`
- 执行命令：`./_install.command`
    
    ![](http://darkhandz.qiniudn.com/2017-07-27-15009537096412.jpg)

它的作用嘛……我忘了，你稍后自行搜索呗？

#### LE

这个文件夹的东西是要安装到`/Library/Extensions/`里面的。

- 执行命令：`sudo cp -r 把AppleGraphicsDevicePolicyInjector.kext拖过来 /Library/Extensions/`
- 执行命令：`sudo cp -r 把X86PlatformPluginInjector.kext拖过来 /Library/Extensions/`
- 执行命令：`sudo kextcache -i /`

第一条命令的`AppleGraphicsDevicePolicyInjector.kext`是用来打开`MacBookPro13,3`这个SMBIOS的HDMI图像输出的。
第二条命令的`X86PlatformPluginInjector.kext`是用来让CPU获得0.8GHz的最低频率的。
第三条是重建缓存，让前面两个驱动在重启后生效。

### 其他

#### touristd进程耗电，耗流量

我在surge一直看着这个家伙以2MB/s的速度在下载东西，永远不停止，这可能是个系统BUG(升级到PB4 17A330h似乎没有这个BUG了)，这个进程我查了一下，似乎是做一些新机使用指引什么的，可以禁用。

- 执行命令：`launchctl remove com.apple.touristd`
- 执行命令：`sudo mv /System/Library/LaunchAgents/com.apple.touristd.plist /System/Library/LaunchAgents/com.apple.touristd.plist.bak`

#### 关闭Verbose

如果你觉得你的系统足够稳定了，但是每次开机依然一屏屏英文字符把你刷得头晕眼花无心工作，那就在config.plist里找到下面这句，去掉`-v`就行了：

```
<string>kext-dev-mode=1 dart=0 nv_disable=1 -v</string>
```

#### 关掉SDCard Reader

在BIOS里禁用读卡器会更省电，反正我是很少在win用读卡器，在macOS更是没有驱动。

#### 禁止生成休眠文件

简单来说就是SSD的写入寿命有限，而默认的休眠模式3会每次都把内存数据写入SSD（大概8G一次）。

然后说说禁用休眠的命令，3条按顺序执行：

```bash
sudo pmset hibernatemode 0
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

#### 原生NTFS读写

1. 打开终端输入 `diskutil list` 查看所有分区的卷标（NAME列）
2. 输入 `sudo nano /etc/fstab` 再输入密码回车进入配置
3. 根据自己要配置的NTFS分区的**卷标**或**UUID**输入配置信息，下面各列举一条：

    ```
    UUID=C3C40C2E-7766-48A0-AA99-18305C9BAD3A none ntfs rw,auto,nobrowse
    LABEL=多媒体 none ntfs rw,auto,nobrowse
    ```
UUID可以从磁盘工具查到，输入完成之后按Ctrl+X再输入Y再回车进行保存。
4. 用磁盘工具将配置好的分区进行卸载再装载使配置生效（无需重启）
5. 因为加入了`nobrowse`所以`Finder`中看不到修改过的NTFS分区（不加入`nobrowse`会无法写入）所以要使用快捷方式进行访问.
在终端中输入 `sudo ln -s /Volumes/卷标 ~/Desktop/卷标` 即可在桌面生成NTFS分区的快捷方式。
6. 将快捷方式拖动到`Finder`的侧边栏就可以很方便的打开NTFS分区进行操作了

#### 一些常用命令

- 挂载系统EFI：`diskutil mount EFI && open /Volumes/EFI`
- 安装驱动：`sudo cp -r AAA/BBB/CCC/**.kext /Library/Extensions/`
- 重建缓存：`sudo kextcache -i /`

### 最后

你现在已经拥有一个可以正常使用的macOS系统了，我们没有修改任何系统的驱动，它比较接近原版了，所以理论上可以直接小版本无痛升级的。

虽然它还不完美：你可能还需要HandOff、HDMI输出、USB-TypeC等等，你可能还想win10双系统什么的，这些只能由你自行测试和研究了，没有哪篇文章可以面面俱全给你从入门到精通，我已经尽力了，如果你遇到什么解决不了的问题，可以自行去pcbeta论坛搜索，爬贴，提问。

对你有帮助的话，点个赞呗 😎



