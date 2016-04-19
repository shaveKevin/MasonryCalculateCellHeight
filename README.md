# MasonryCalculateCellHeight
masonry和storyboard高度自适应  目前只实现了masonry 来实现tableviewcell 高度自适应
###使用storyboard和masonry来实现自适应cell动态高度。

#本次更新说明

1.本次更新新加了UITableview子类  使在vc里调用高度的方法更简单。

2.新增了对tableview 的子视图 添加约束的方法

先讲一下使用masonry来自适应cell高度

首先，这里采用的是使用懒加载来加载控件。


#例如：
```
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tableView;
}
```
然后我们就在tableview的代理方法中可以这样写
之前：
```

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//在前面已经注册过cell了 所以这里直接deq
    CustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //这个加上是为了解决约束冲突
    cell.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
    cell.contentView.frame = cell.frame;
    [cell customListBlindCell: _dataArray[indexPath.row]];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    return cell;
}
```
现在：
```

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //这里的操作是对cell上的子view 根据数据源 添加 更新约束
    [cell customListBlindCell: _dataArray[indexPath.row]];
    [cell  layOutViews];
    return cell;
}
```
其中里面添加了
```
cell.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
cell.contentView.frame = cell.frame;

```


 添加这两行的目的是为了解决因为高度带来的冲突。
 
 
 
 //在这里定义了一个重用标示符
 
 static  NSString *const cellIdentifier = @"cell";

 这里作者采用的是懒加载一个cell专门用来计算高度(这个cell非必须)。看下面的cell：
 ```
 //懒加载一个cell 用于计算高度(从重用池中取出)
- (CustomListCell *)tempCell {
    
    if (!_tempCell) {
        
        _tempCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return _tempCell;
}
 ```
 在heightforrow里面执行如下操作
 
 之前：
 
 ```
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从重用池取出去的cell 然后对cell进行赋值 通过赋值 来调用是否更新约束的方法
    [self.tempCell customListBlindCell:_dataArray[indexPath.row]];
    [self.tempCell setNeedsUpdateConstraints];
    [self.tempCell updateConstraintsIfNeeded];
    [self.tempCell setNeedsLayout];
    [self.tempCell layoutIfNeeded];
    return [self.tempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1 ;
}

```
#更新说明
 ##1.本次更新新加了UITableview子类 在子类里做的操作是
 
 ```
 - (void)layOutViews {
    
    //这个加上是为了解决约束冲突
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.contentView.frame = self.frame;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

 - (CGFloat)calculateHeight{
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

```
 把计算高度的操作放到父类里。 然后子类中调用。现在的cell 里返回高度是这样写的
 现在：
 
 ```
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //从重用池取出去的cell 然后对cell进行赋值 通过赋值 来调用是否更新约束的方法
    // 获得高度有两种方法： 如果子类对父类方法做了修改那么就 用方法2 如果没修改就用方法1
    /**
     *  1.  [self.tempCell customListBlindCell:_dataArray[indexPath.row]];
     
     *     [self.tempCell calculateHeight];

     *  2. [self.tempCell calculateHeightWithModel:_dataArray[indexPath.row]]
     */
    return [self.tempCell calculateHeightWithModel:_dataArray[indexPath.row]];

}

 ```
 ##2. 新增了对tableview 的子视图 添加约束的方法
 
 TableviewHeaderview不可以被加约束可是它的子视图可以加约束 这里给获取一个高度就好 添加footview   添加区头区尾 也是同样的方法
 ```
 - (void)addHeaderView {
    
    //headerview
    UIView *viewContview = [UIView new];
    viewContview.backgroundColor = [UIColor clearColor];
    UIView *viewCss = [UIView new];
    [viewContview addSubview:viewCss];
    viewCss.backgroundColor = [UIColor orangeColor];
    [viewCss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.height.mas_equalTo(100);
    }];
    CGFloat height = [viewContview systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = viewContview.frame;
    frame.size.height = height;
    viewContview.frame = frame;
    self.tableView.tableHeaderView = viewContview;
    
}
 ```
//在iOS7的时候我们使用这样的方法来得到cell的高度 目的是让系统根据我们添加的约束来自动帮我们计算出内容的高度

因为我们使用的是self.contentview所以最后得到的结果应该加上分割线1的高度。

在iOS8以后我们就可以给一个高度让系统帮我们来实现求cell高的方法(这样说法不太准确 因为一下面两个APIiOS7就有了 只不过在iOS7需要我们必须实现heightForRowAtIndexPath 这个方法，所以高度我们需要在这里返回)
```
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
```
在iOS8以后添加了这两行代码我们就不用在实现heightForRowAtIndexPath 这个方法了。系统会帮我们计算好并返回高度。

# 值得注意的是：在cell的高度变化特别大的时候 慎用estimatedRowHeight  预估高度的方法，因为如果高度差别太大的话 界面会因为预估高度和实际高度相差太大而造成界面闪动明显。


我们在自定义cell是怎么做的呢？
```
- (void)layoutSubviews {

    //这个得写上，不写的话不能自适应高度  因为自适应的高度的话宽度是要固定的。所以这里要给上最大的宽度
    _nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(PhoneBounds) - kDefaultSeperate;
    _contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(PhoneBounds) - kDefaultSeperate;
    [super layoutSubviews];
}
```
   然后呢，我们在customListBlindCell这个方法中只负责对其进行赋值。
在cell里面定义一个bool类型的属性，主要是为了进行判断，如果是第一次进入的话，会make所有约束。然后第二次以后进入就会触发更新约束的方法
具体是这样的：
```
#pragma mark  - 约束的添加和更新
- (void)updateConstraints {

       [super updateConstraints];

    //第一次进来的话走的是make  再次进来走的是update 或者 remake
    //这里我们在第一次的时候会把我们所有的控件约束加载一遍 这里只加载一次，然后我们需要在下面做的就是对约束进行更新
    if (!_isFirstVisit) {

    //约束创建
        _isFirstVisit = YES;
    }
    //更新约束的适用范围：(根据业务逻辑来更新约束)我们把动态的东西在这里进行更新 比如说图像的有无，label 文字的显隐等等。这里只需要做的是更新约束就好。
    if (xxx) {
        
    }
    else  {

    }
    
}

```
还有一点我们在cell的初始化方法里需要这样处理：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //这个加上是为了解决约束冲突  这个目前已经放到父类去写了 
        self.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
        self.contentView.frame = self.frame;
        _isFirstVisit = NO;
    }
    return self;
}

```
####这样处理的目的是为了防止约束冲突。因为我们刚创建的时候cell的高度是默认的44.所以为了避免我们在添加子控件的时候由于两者高度不同造成的约束冲突。


```

方法解释：

告诉对象约束需要更新
setNeedsUpdateConstraints
Controls whether the view’s constraints need updating.
When a property of your custom view changes in a way that would impact constraints, you can call this method to indicate that the constraints need to be updated at some point in the future. The system will then call updateConstraints as part of its normal layout pass. Updating constraints all at once just before they are needed ensures that you don’t needlessly recalculate constraints when multiple changes are made to your view in between layout passes.

  调用此方法告诉对象检测是否需要更新约束。
updateConstraintsIfNeeded
Updates the constraints for the receiving view and its subviews.
Whenever a new layout pass is triggered for a view, the system invokes this method to ensure that any constraints for the view and its subviews are updated with information from the current view hierarchy and its constraints. This method is called automatically by the system, but may be invoked manually if you need to examine the most up to date constraints.

是否立即需要把更新约束的视图效果展示
标记为需要重新布局，异步调用

setNeedsLayout

Lays out the subviews immediately. 
Use this method to force the layout of subviews before drawing. Using the view that receives the message as the root view, this method lays out the view subtree starting at the root.

刷新布局，不立即刷新，但layoutSubviews()一定会被调用
如果，有需要刷新的标记，立即调用layoutSubviews()进行布局（如果没有标记，不会调用layoutSubviews）
layoutIfNeeded

Lays out the subviews immediately.
Use this method to force the layout of subviews before drawing. Using the view that receives the message as the root view, this method lays out the view subtree starting at the root.


如果要立即刷新，要先调用setNeedsLayout，把标记设为需要布局，然后马上调用layoutIfNeeded，实现布局.

```

```

Additoions:

iOS layout机制相关方法(转)

- (CGSize)sizeThatFits:(CGSize)size
- (void)sizeToFit
——————-

- (void)layoutSubviews
- (void)layoutIfNeeded
- (void)setNeedsLayout
——————–

- (void)setNeedsDisplay
- (void)drawRect
layoutSubviews在以下情况下会被调用：

1、init初始化不会触发layoutSubviews

   但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发

2、addSubview会触发layoutSubviews

3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化

4、滚动一个UIScrollView会触发layoutSubviews

5、旋转Screen会触发父UIView上的layoutSubviews事件

6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

在苹果的官方文档中强调:

      You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.

layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。

反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。

刷新子对象布局

-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
-setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
-layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）

如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局

在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]

重绘

-drawRect:(CGRect)rect方法：重写此方法，执行重绘任务
-setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
-setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘

sizeToFit会自动调用sizeThatFits方法；

sizeToFit不应该在子类中被重写，应该重写sizeThatFits

sizeThatFits传入的参数是receiver当前的size，返回一个适合的size

sizeToFit可以被手动直接调用

sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己

———————————-

layoutSubviews对subviews重新布局

layoutSubviews方法调用先于drawRect

setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews

layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的

layoutIfNeeded遍历的不是superview链，应该是subviews链

drawRect是对receiver的重绘，能获得context

setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
```

个人博客  [www.shavekevin.com](http://shavekevin.com/)

QQ交流群：214541576

 
 






