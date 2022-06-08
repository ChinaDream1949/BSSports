## BSSports(基于mvc的开发框架 各个库如何使用请查看各个库的github)

- 项目结构 -文件结构
    - codeblock ----开发的代码块
    - appdelegate ---应用层入口、appdelegate分类
    - base ---基类，包含controller、cell、view、webview、model、tabar、nav
    - define ---全局宏定义
    - pubilcm ---包含了一个emptyjudeg常用工具判断类
    - resource ---全局资源文件
    - treeparty ---本地第三方库文件
    - utils ---工具文件，定义了一些分类，viewconstructor 工具为快速创建lab、btn、imgview、textfeild的类

* pod文件
    * pod 'MJExtension' #转model的库
    * pod 'AFNetworking' #网络库
    * pod 'MJRefresh' #表视图刷新
    * pod 'CYLTabBarController' #tabbar 等等
* 快速代建项目包
    * 只需basecode文件里的（1-8）文件包放入你的项目 ，删除原有的appdelegate 添加PrefixHeader pch文件到配置。 界面快速代建在base基类。详情看基类
