# CJKPasswordBoxView
[![](https://raw.githubusercontent.com/caiji2015/CJKPasswordBoxView/master/example/demo-small.gif)](https://raw.githubusercontent.com/caiji2015/CJKPasswordBoxView/master/example/demo.gif)
### 这个工具是密码框，可根据跟人需要调整密码框的样式，大小，个数
### 此工具支持swift3.0及以后版本

#### 主要是根据以上属性改变UI的
```
/// 验证码位数
var digit: Int = 4

/// 是否密文
var isSecure: Bool = true

/// 格子间距
var spacing: CGFloat = 0

/// 密码内容
var password: String = ""

/// 边框颜色
var borderColor: UIColor = UIColor.black

/// 边框宽度
var borderWidth: CGFloat = 1

/// 边框圆角
var cornerRadius: CGFloat = 1

/// 存放CJKPasswordTextField数组
var textFieldArray: [CJKPasswordTextField] = []

/// 回调
var complete: ((_ password: String) -> Void)?
```
