//
//  ViewController.m
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/3/14.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "JIgSawPuzzViewController.h"
#import "PuzzleImageView.h"
#import "EastEggView.h"

#define kMainScreenWidth         ([UIScreen mainScreen].bounds).size.width              //屏幕的高度
#define kMainScreenHeight        ([UIScreen mainScreen].bounds).size.height             //屏幕的宽度
static const CGFloat halfImageLength = 50.0f;

@interface JIgSawPuzzViewController ()
@property (strong, nonatomic) IBOutlet UIView *startView;///< 切图片放置区域

@property (strong, nonatomic) IBOutlet UIView *finishView;///< 拼图区域

@property (strong, nonatomic) IBOutlet UIImageView *originImageView;///<缩小的拼图原图

@property (strong, nonatomic) NSMutableArray *array_ImageView;///< 切图数组

@property (strong, nonatomic) NSString *string_ImageName;///<拼图图片名称

@property(nonatomic ,strong)EastEggView *eastEggView;///<彩蛋视图

@property(nonatomic ,strong)NSMutableArray *randomArr;///<打乱切图片顺序数组

@property(nonatomic ,assign)int maxSquareTag;///<面积占比最大的切割图下标

@property(nonatomic ,assign)NSInteger pictureNumber;///<拼图标示

@property(nonatomic ,strong)NSArray *picturesArray;///<标图数组

@property(nonatomic ,strong)UIImage *pictureImage;///<拼图image

@property(nonatomic ,strong)UIImageView *finishImageView;///<拼图完成后的原图

@end

@implementation JIgSawPuzzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //初始化图片
    [self initPuzzleImage];
    
}

- (EastEggView *)eastEggView{
    if (!_eastEggView) {
        _eastEggView = [[EastEggView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    }
    return _eastEggView;
}

// 初始化必要数据
-(void) initData
{
    self.randomArr = [@[]mutableCopy];
    self.startView.backgroundColor = [UIColor clearColor];
    self.finishView.backgroundColor = [UIColor clearColor];
    self.title = @"拼图";
    self.picturesArray = @[@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg",@"img6.jpg"];
    self.pictureNumber = 0;
    self.string_ImageName = self.picturesArray[self.pictureNumber];
}

// 初始化图片
-(void) initPuzzleImage
{
    [self resetPuzzleImageWithImage:[UIImage imageNamed:self.string_ImageName]];
    self.originImageView.image = [UIImage imageNamed:self.string_ImageName];
}

// 重置图片
-(void) resetPuzzleImageWithImage:(UIImage *)image
{
    CGFloat scale = image.size.height / image.size.width;
    
    //重新设置图片尺寸(压缩图片)
    self.pictureImage = [self image:image ByScalingToSize:CGSizeMake(300, 300*scale)];
    
    //切割图片
    self.array_ImageView = [self separateImage:self.pictureImage ByX:3 andY:3];
    
    //加载图片视图(tip:可以通过修改坐标值，以及更改背景颜色，来观察，绘制位置)
    for (PuzzleImageView *pzView in self.array_ImageView)
    {
        //占位视图
        UIView *placeHolderView = [[UIView alloc]initWithFrame:pzView.originFrame];
        placeHolderView.layer.borderWidth = 1;
        placeHolderView.layer.borderColor = [UIColor redColor].CGColor;
        placeHolderView.tag =  pzView.tag + 900;
        [self.finishView addSubview:placeHolderView];
        
        pzView.frame = self.startView.frame;
        __weak __typeof(self) weakSelf = self;
        __weak PuzzleImageView *weakPzView = pzView;
        pzView.imageViewPanBlock = ^(UIPanGestureRecognizer *pan){
            NSMutableArray *mutableArr = [@[]mutableCopy];
            int maxSquareNumber = -1;
            double maxPercentage = 0;
            weakSelf.maxSquareTag = -1;
            if (pan.state == UIGestureRecognizerStateChanged) {
                //把当前滑动的视图放到最外层
                [weakSelf.view bringSubviewToFront:weakPzView];
                weakPzView.transform = CGAffineTransformMakeRotation(0);
                /*拖动时判断位置*/
                [weakSelf setImageViewPointAndAllowsAreaWithPan:pan pzView:weakPzView];
                
                if (CGRectIntersectsRect(weakPzView.frame, self.finishView.frame)){
                    maxSquareNumber = [weakSelf featchMaxSquareNumberWithWeakPzView:weakPzView
                                                                      maxPercentage:maxPercentage
                                                                    maxSquareNumber:maxSquareNumber
                                                                         mutableArr:mutableArr];
                    
                    NSLog(@"mutableArr : %@,maxSquareNumber : %d",mutableArr,maxSquareNumber);
                    CGRect maxRect = CGRectZero;
                    if (mutableArr.count && weakSelf.maxSquareTag >= 0) {
                        maxRect = CGRectFromString(mutableArr[maxSquareNumber]);
                        UIView *placeHolderView = [weakSelf.view viewWithTag:1000 + weakSelf.maxSquareTag];
                        placeHolderView.backgroundColor = [UIColor redColor];
                    }
                }
            }
            
            if (pan.state == UIGestureRecognizerStateEnded) {
                [weakSelf setImageViewPointAndAllowsAreaWithPan:pan pzView:weakPzView];
                
                maxSquareNumber = [weakSelf featchMaxSquareNumberWithWeakPzView:weakPzView
                                                                  maxPercentage:maxPercentage
                                                                maxSquareNumber:maxSquareNumber
                                                                     mutableArr:mutableArr];
                
                NSLog(@"mutableArr : %@,maxSquareNumber : %d",mutableArr,maxSquareNumber);
                if (mutableArr.count && weakSelf.maxSquareTag >= 0) {
                    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [weakPzView setFrame:CGRectFromString(mutableArr[maxSquareNumber])];
                        UIView *placeHolderView = [weakSelf.view viewWithTag:1000 + weakSelf.maxSquareTag];
                        placeHolderView.backgroundColor = [UIColor clearColor];
                    } completion:Nil];

                }
                
                //判断是否完成拼图
                [weakSelf isFinishGame];
            }
        };
        [self.randomArr addObject:pzView];
    }
    
    //随机取值将切割的图片置于左上角
    for (int i = 0; i < self.array_ImageView.count; i++) {
        NSInteger randomNumber = [self getRandomNumber:0 to:(int)self.randomArr.count - 1];
        if (self.randomArr.count) {
            PuzzleImageView *pzView = self.randomArr[randomNumber];
            [self.view addSubview: pzView];
            pzView.transform = CGAffineTransformMakeRotation(M_PI_4*(1 * (float)i/9.0f));
            [self.randomArr removeObjectAtIndex:randomNumber];
            NSLog(@"randomNumber : %ld",pzView.tag);
        }
    }
}

-(int)getRandomNumber:(int)from to:(int)to
{
    //分母不能为零
    if (to > from - 1) {
        return (int)(from + (arc4random() % (to - from + 1)));
    }
    NSLog(@"随机数取值错误");
    return 0;
}

- (void)setImageViewPointAndAllowsAreaWithPan:(UIPanGestureRecognizer *)pan pzView:(PuzzleImageView *)weakPzView{
    //注意，这里取得的参照坐标系是该对象的上层View的坐标。
    CGPoint offset = [pan translationInView:self.view];
    CGRect allowsPanRect = CGRectMake(halfImageLength, halfImageLength, kMainScreenWidth - 2 * halfImageLength, kMainScreenHeight - 2 * halfImageLength);
    CGPoint centerPoint = CGPointMake(weakPzView.center.x, weakPzView.center.y);
    
    /* 设置视图滑动的区域范围*/
    if (CGRectContainsPoint(allowsPanRect, centerPoint)
        || (centerPoint.x == kMainScreenWidth - halfImageLength && centerPoint.y <= kMainScreenHeight - halfImageLength)
        || (centerPoint.y == kMainScreenHeight - halfImageLength )) {
        //通过计算偏移量来设定weakPzView的新坐标
        [weakPzView setCenter:CGPointMake(weakPzView.center.x + offset.x, weakPzView.center.y + offset.y)];
        
    } else if (centerPoint.x < halfImageLength){
        [weakPzView setCenter:CGPointMake(halfImageLength, weakPzView.center.y + offset.y)];
        
    }else if (centerPoint.y < halfImageLength){
        [weakPzView setCenter:CGPointMake(weakPzView.center.x + offset.x, halfImageLength)];
        
    }else if (centerPoint.x > kMainScreenWidth - halfImageLength){
        [weakPzView setCenter:CGPointMake(kMainScreenWidth - halfImageLength, weakPzView.center.y + offset.y)];
        
    }else if (centerPoint.y > kMainScreenHeight - halfImageLength){
        [weakPzView setCenter:CGPointMake(weakPzView.center.x + offset.x, kMainScreenHeight - halfImageLength)];
        
    }
    //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (int)featchMaxSquareNumberWithWeakPzView:(PuzzleImageView *)weakPzView
                             maxPercentage:(double)maxPercentage
                           maxSquareNumber:(int)maxSquareNumber
                                mutableArr:(NSMutableArray *)mutableArr{
    for (int i = 0; i < self.array_ImageView.count; i++) {
        UIView *placeHolderView = [self.view viewWithTag:1000 + i];
        placeHolderView.backgroundColor = [UIColor clearColor];
        CGRect placeHolderViewInViewRect = [self.finishView convertRect:placeHolderView.frame toView:self.view];
        CGFloat
        placeHolderViewCenterX = CGRectGetMaxX(placeHolderViewInViewRect) - halfImageLength,
        placeHolderViewCenterY = CGRectGetMaxY(placeHolderViewInViewRect) - halfImageLength,
        weakPzViewCenterX = weakPzView.center.x,
        weakPzViewCenterY = weakPzView.center.y,
        xPadding          = fabs(placeHolderViewCenterX - weakPzViewCenterX),
        yPadding          = fabs(placeHolderViewCenterY - weakPzViewCenterY);
        
        if (CGRectIntersectsRect(weakPzView.frame, placeHolderViewInViewRect)) {
            CGFloat overLapAreaSuqre =fabs(2*halfImageLength - xPadding) * fabs(2*halfImageLength - yPadding),
            placeHolderViewSuqre = (2 * halfImageLength)*(2 * halfImageLength);
            double percentage = overLapAreaSuqre/placeHolderViewSuqre;
            NSLog(@"percentage : %f,maxPercentage : %f",percentage,maxPercentage);
            
            NSInteger sameFrameCount = 0;
            for (int j = 0; j < self.array_ImageView.count; j++) {
                PuzzleImageView *pzView = [self.view viewWithTag:100 + j];
                if (CGRectEqualToRect(pzView.frame, placeHolderViewInViewRect)){
                    sameFrameCount ++;
                }
            }
            
            if (sameFrameCount == 0) {
                maxPercentage = percentage >= maxPercentage ? percentage :maxPercentage;
            }
            
            if (percentage >= maxPercentage && sameFrameCount == 0) {
                maxSquareNumber++;
                [mutableArr addObject: NSStringFromCGRect(placeHolderViewInViewRect)];
                self.maxSquareTag = i;
            }
        }
    }
    return maxSquareNumber;
}

- (void )isFinishGame{
    int j = 0;
    for (int i = 0; i < self.array_ImageView.count; i++) {
        UIView *placeHolderView = [self.view viewWithTag:1000 + i];
        PuzzleImageView *pzView = [self.view viewWithTag:100 + i];
        CGRect placeHolderViewInViewRect = [self.finishView convertRect:placeHolderView.frame toView:self.view];
        if (CGRectEqualToRect(pzView.frame, placeHolderViewInViewRect)) {
            j++;
        }
    }
    
    if (j == self.array_ImageView.count){
        [self removeSubViews];
        self.finishImageView = [[UIImageView alloc]initWithImage:self.pictureImage];
        self.finishImageView.frame = self.finishView.frame;
        self.finishImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:self.finishImageView];
        
        self.eastEggView.contentStr = @"拼图成功，恭喜你哇！！！！！";
        [[UIApplication sharedApplication].delegate.window addSubview:self.eastEggView];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"游戏完成!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
//        UIAlertController *alert = [[UIAlertController alloc]init:@"恭喜" message:@"游戏完成!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
//
//        [alert show];
    }
}

//重新设置图片尺寸
- (UIImage *)image:(UIImage *)sourceImage ByScalingToSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGRect rect = CGRectMake(0.0, 0.0, targetSize.width, targetSize.height);
    //压缩图片过程
    UIGraphicsBeginImageContext(rect.size);
    [sourceImage drawInRect:rect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

// 分解图片
-(NSMutableArray *) separateImage:(UIImage *)image ByX:(int)x andY:(int)y
{
    // 数据监测
    if (x < 1 || y < 1 || ![image isKindOfClass:[UIImage class]])
    {
        return Nil;
    }
    
    CGFloat sWidth = self.finishView.frame.size.width;
    CGFloat sHeight = self.finishView.frame.size.height;
    CGFloat iWidth = image.size.width;
    CGFloat iHeight = image.size.height;
    // 图片大小适配（防止图片超过屏幕尺寸）
    if (iHeight > sHeight || iWidth > sWidth)
    {
        CGFloat scala = MIN(sHeight/iHeight, sWidth/iWidth);
        
        iWidth = iWidth * scala;
        iHeight = iHeight * scala;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    float resultX = iWidth * 1.0 / y;
    float resultY = iHeight * 1.0 / x;
    
    for (int i = 0; i < x; i++)
    {
        for (int j = 0; j < y; j++)
        {
            //获取分割的图片
            CGRect rect = CGRectMake(resultX*j, resultY*i, resultX, resultY);
            //获取在image图片的rect区域内的图片
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage* elementImage = [UIImage imageWithCGImage:imageRef];
            
            PuzzleImageView *puzzleImageView=[[PuzzleImageView alloc] initWithImage:elementImage];
            puzzleImageView.tag = 100 + i * x + j;
            puzzleImageView.originFrame = CGRectMake(resultX * j,resultY * i, resultX, resultY);
            puzzleImageView.accurateFrame = CGRectMake((self.view.frame.size.width - 300.0f)/2.f  + resultX * j,(self.view.frame.size.height - 300 -20) +resultY * i, resultX, resultY);
            
            [array addObject:puzzleImageView];
        }
    }
    return array;
}

- (IBAction)reSatrtAction:(UIButton *)sender {
    [self removeSubViews];
    self.string_ImageName = self.picturesArray[self.pictureNumber];
    [self initPuzzleImage];
}

- (IBAction)changeImageView:(UIButton *)sender {
    [self removeSubViews];
    self.pictureNumber++;
    if (self.pictureNumber == self.picturesArray.count) {
        self.pictureNumber = 0;
    }
    self.string_ImageName = self.picturesArray[self.pictureNumber];
    [self initPuzzleImage];
}

- (void)removeSubViews{
    for (PuzzleImageView *imageView in self.array_ImageView) {
        [imageView removeFromSuperview];
    }
    for (UIView *view in self.finishView.subviews) {
        [view removeFromSuperview];
    }
    [self.finishImageView removeFromSuperview];
}

- (void)dealloc{
    self.array_ImageView = nil;
}
@end
