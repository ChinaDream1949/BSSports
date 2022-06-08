
基于mvc的开发框架
各个库如何使用请查看各个库的github

项目结构 -文件结构
1、codeblock     ----开发的代码块
2、appdelegate  ---应用层入口、appdelegate分类
3、base              ---基类，包含controller、cell、view、webview、model、tabar、nav
4、define            ---全局宏定义
5、pubilcm         ---包含了一个emptyjudeg常用工具判断类
6、resource        ---全局资源文件
7、treeparty        ---本地第三方库文件
8、utils                ---工具文件，定义了一些分类，viewconstructor 工具为快速创建lab、btn、imgview、textfeild的类



**pod文件**

pod 'MJExtension'  #转model的库
pod 'AFNetworking' #网络库
pod 'YTKNetwork'  #网络库
pod 'YYKit'      
pod 'MJRefresh'  #表视图刷新
pod 'MBProgressHUD'  #转菊花
pod 'SDWebImage'    #图片加载
pod 'Masonry'       #约束
pod 'CYLTabBarController' #tabbar

pod 'MMKV'      # wecat团队封装的开源NSUserDefaults
pod 'JXCategoryView'  #分页控制器
pod 'BRPickerView'    #包含各种各样的pickertview
pod "DZNEmptyDataSet" #加载scrollview缺省页的库

快速代建项目包  只需basecode文件里的（1-8）文件包放入你的项目 ，删除原有的appdelegate
添加PrefixHeader pch文件到配置。
界面快速代建在base基类。详情看基类
