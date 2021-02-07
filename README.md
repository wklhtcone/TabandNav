## 1. UITabBarController与UINavigationController
### 1.1 区别
- `UINavigationController`以栈的形式保存视图控制器，使用push将视图控制器入栈、pop移除栈顶控制器，pop后视图控制器对象会被释放
- `UITabBarController`用于不同视图控制器间的切换，切换视图时视图控制器不会被销毁，通常作为整个程序的`rootViewController`
- 下面是苹果推荐的方式
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210207230517212.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1MDg3NDI1,size_16,color_FFFFFF,t_70)
### 1.2 为何嵌套使用
- 将导航控制器嵌套在`UITabBarController`中，能够在不同的标签项里实现不同的层次结构
- 如下图中`Tab Bar Controller`关联着3个导航控制器，不同导航控制器下管理着不同数量的`View Controller`
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210207231055403.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1MDg3NDI1,size_16,color_FFFFFF,t_70)

## 2. Demo
- 点击登录Button显示`Tab Bar Controller`，可以三个`Tab Bar`之间页面切换
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210207233610445.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1MDg3NDI1,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/2021020723302284.JPEG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1MDg3NDI1,size_16,color_FFFFFF,t_70)

1. 创建3个视图控制器类，并分别设为3个导航控制器的根视图

```swift
//title是导航控制器的标题
class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        title = "主页"
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        title = "联系人"
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "帮助"
    }
}

//title是Tab Bar标签上的文字
let vc1 = UINavigationController(rootViewController: FirstViewController())
let vc2 = UINavigationController(rootViewController: SecondViewController())
let vc3 = UINavigationController(rootViewController: ThirdViewController())

vc1.title = "主页"
vc2.title = "联系人"
vc3.title = "帮助"
```
2. 创建`Tab Bar Controller`并设置要显示的视图控制器数组，数组中顺序即显示的顺序

```swift
let tabBarVC = UITabBarController()
tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210207234819111.png)

3. 设置每个`Tab Bar`的图标

```swift
let items = tabBarVC.tabBar.items
let imgList = ["house", "person.circle", "gear"]
for index in 0..<imgList.count {
    items[index].image = UIImage(systemName: imgList[index])
}
```
4. 以上逻辑发生在点击登录button后
- 创建及设置button

```swift
let button: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    button.setTitle("登录", for: .normal)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    return button
}()
```

- 将button加入视图并设置点击后触发的方法

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    view.addSubview(button)
    button.center = view.center
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
}
```

- 实现`didTapButton`方法

```swift
@objc func didTapButton(){
    let tabBarVC = UITabBarController()

    let vc1 = UINavigationController(rootViewController: FirstViewController())
    let vc2 = UINavigationController(rootViewController: SecondViewController())
    let vc3 = UINavigationController(rootViewController: ThirdViewController())

    vc1.title = "主页"
    vc2.title = "联系人"
    vc3.title = "帮助"

    tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)

    guard let items = tabBarVC.tabBar.items else{
        return
    }

    let imgList = ["house", "person.circle", "gear"]

    for index in 0..<imgList.count {
        items[index].image = UIImage(systemName: imgList[index])
    }

    tabBarVC.modalPresentationStyle = .fullScreen
    present(tabBarVC, animated: true)
}
```
