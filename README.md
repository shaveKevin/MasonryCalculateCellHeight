# MasonryStoryboardCellHeight
masonry和storyboard高度自适应
###使用storyboard和masonry来实现自适应cell动态高度。

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
 ```
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tempCell customListBlindCell:_dataArray[indexPath.row]];
    [self.tempCell setNeedsUpdateConstraints];
    [self.tempCell updateConstraintsIfNeeded];
    [self.tempCell setNeedsLayout];
    [self.tempCell layoutIfNeeded];
    return [self.tempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1 ;
}
```
//在iOS7的时候我们使用这样的方法来得到cell的高度 目的是让系统根据我们添加的约束来自动帮我们计算出内容的高度

因为我们使用的是self.contentview所以最后得到的结果应该加上分割线1的高度。

在iOS8以后我们就可以给一个高度让系统帮我们来实现求cell高的方法
```
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
```
在iOS8以后添加了这两行代码我们就不用在实现heightForRowAtIndexPath 这个方法了。系统会帮我们计算好并返回高度。

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
        //这个加上是为了解决约束冲突
        self.frame = CGRectMake(0, 0, CGRectGetWidth(PhoneBounds), CGRectGetHeight(PhoneBounds));
        self.contentView.frame = self.frame;
        _isFirstVisit = NO;
    }
    return self;
}

```
####这样处理的目的是为了防止约束冲突。因为我们刚创建的时候cell的高度是默认的44.所以为了避免我们在添加子控件的时候由于两者高度不同造成的约束冲突。



个人博客  [www.shavekevin.com](www.shavekevin.com)

QQ交流群：214541576

 
 






