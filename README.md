# XYMGuideView
首次启动打开某个页面的时候弹出的新手引导蒙版，再次进来这个页面后不会再提示。

##使用
这其实是一个UIView，在你需要新手引导或者新功能引导的页面导入头文件。
``` bash
#import "XYMGuideView.h"
```

在- (void)viewDidLoad里面创建它
``` bash
//直接创建不用给它frame(默认就是覆盖整个屏幕)
XYMGuideView *guideView = [[XYMGuideView alloc]init];
```

设置当前这个引导层的名字标识（一个项目中可能在不同的页面，会用到多个引导层，用这个标识区分开）
``` bash
guideView.guideName = @"hello";
```

设置引导用户关注的区域，提供两种类型，根据需要选择。
一种是圆形区域，调用对象方法 setCircularFocus ，传入GCPoint类型参数为圆形位置，radius为半径。
``` bash
[guideView setCircularFocus:GCPoint radius:int];
```
一种是矩形区域，调用对象方法 setRectangleFocus ，传入CGRect类型参数设置矩形框的frame。
``` bash
[guideView setRectangleFocus:CGRect];
```

提示引导信息的View
调用对象方法 addTipsView:传入一个你自己的自定义UIView(通常是一个UIImageView或者一个UILabel)
``` bash
[guideView addTipsView:UIView];
```

如果想要在点击完引导层的时候时候做一些事情，这里提供一个代理方法，得到当前点击的引导层的名字标识。

遵守协议
``` bash
@interface RootViewController ()<XYMGuideViewDelegate>
@end
```

设置代理
``` bash
guideView.delegate = self;
```

实现代理方法
``` bash
-(void)XYMGuideClick:(NSString*)guideName{
    NSLog(@"%@",guideName);
}

```

