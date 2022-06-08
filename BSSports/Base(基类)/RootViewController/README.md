
wcp
、、、用viewconteroller封装控制器。减少构建时重复代码
1最基层--RootViewController 
    封装viewcontroll 为了实际效果，隐藏nav,自定义vc的系统设置
    2视图层--WCPRootViewController   
    抽象封装两层(mainview、maintwoview)，为了方便管理视图层次。为需要可以自定义大小位置
    mainview-理论上为整个视图。nav和maintwoview的父类层
    maintwoview-理论所有内容展示view层。不包含nav
    添加了自定义nav方法 详情见代码。
3 -- wcpbaseTableviewcontroller
    具有1、2所有方法层次。视图已自动添加nav、tableview。
    并且实现tableview打大小为maintwo大小。有需求可自定义修改。
    需要在继承的子类实现WCPRootTabView的代理（代理必须实现regisTabCell） 

WCPShipAddressViewController为使用用例

4-键盘表情视图 WCPEmojiKeyboard
替换textfeild.inptview


------------
5-重新抽父类 WCPRootTabView、WCPRootCollView
    把tableview、collectionview从controller封装到view里
    抽离代理和数据源。 减少重复代码，减少耦合;
    为tableview、collection添加无数据缺失图。控制requestCode状态码实现不同缺省图。
    可以通过构造方法构建 实现必要代理即可使用.


6 - UIViewController (DefaultMapView)分类里为UIViewController封装了页面缺省图。可以通过控制分类属性控制缺省页
