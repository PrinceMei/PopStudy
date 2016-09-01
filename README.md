# PopStudy
这个学习Demo封装了轮播图、二维码、头部滑动等一些项目里经常用到的动画功能

##部分截图
![main](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016年8月8日%20下午6.28.40.png)
![tableView的Pop动画](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016年8月8日%20下午6.29.12.png)
![二维码](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016年8月8日%20下午6.29.38.png)
![头部滑动视图](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016年8月8日%20下午6.29.51.png)
![轮播图](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016年8月8日%20下午6.29.58.png)
![仿qq空间导航栏渐变效果](https://github.com/iosyaowei/PopStudy/blob/master/Screenshots/Simulator%20Screen%20Shot%202016%E5%B9%B49%E6%9C%881%E6%97%A5%20%E4%B8%8A%E5%8D%8810.55.45.png)
##新特性
- tableView的动画利用Pop框架 实现滑动和点击的特效，并具有拼音模糊搜索功能
- 二维码功能利用ZXingObjC实现二维码生成和扫描，接口都留出来了集成起来非常方便
- sliderView基于scrollView实现头部滑动视图支持文字、文字和图片两种形式，支持自定义样式
- 轮播图基于collectionView实现,可以添加图片和标题自定义了pageControl的样式，因为时间关系各种该属性接口还没留出来。
- 仿qq空间导航栏渐变效果 使用原生的navigationBar,利用scrollView的代理实现导航栏的渐变效果
##第三方
- Pop
- Masonry
- ZXingObjC
- LBXScan

##联系我
要是有什么Bug 15919688564@163.com 我要是看到正好有时间还有心情 我可能会改的