//
//  LayIfneedViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2022/2/21.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "LayIfneedViewController.h"
#import "LayNeedView.h"
@interface LayIfneedViewController ()
@property (nonatomic,strong)UIButton * clickBtn;
@property (nonatomic,strong)LayNeedView * layView;
@property(nonatomic,assign)NSInteger currentTag;
@end

@implementation LayIfneedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runloopTest];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    self.currentTag = 0;
    self.clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH - 40, 50)];
    self.clickBtn.center = self.view.center;
    self.clickBtn.backgroundColor = [UIColor redColor];
    [self.clickBtn setTitle:@"创建视图" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.clickBtn addTarget:self action:@selector(chooseViewMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickBtn];
    
    YYImage * yyimage = [YYImage imageNamed:@"btn_pengyouquan"];
    
    
    YYLabel * label = [[YYLabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.clickBtn.frame) + 20, self.clickBtn.width, 100)];
    label.backgroundColor = [UIColor grayColor];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = label.width;
    label.textLayout = [self createTextImage1:@"文字,文字文字,文字文字,文字文字,文字文字,文字文字,文字文字,文字," witImage:@"btn_pengyouquan" withSize:label.size];
//    label.attributedText = [self createTextImage:@"文字,文字" witImage:@"btn_pengyouquan"];
    [self.view addSubview:label];

    
    YYTextView * textView = [[YYTextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame) + 20, self.clickBtn.width, 100)];
    textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textView];
    
    
    
}
- (NSMutableAttributedString*)createTextImage:(NSString*)text witImage:(NSString*)imageName{
    NSMutableAttributedString *scaleStr=  [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
   //添加图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.bounds = CGRectMake(0, 2, 12, 7); //根据图片位置进行调整
    textAttachment.image = [UIImage imageNamed:imageName];
    NSAttributedString *attributedImage = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(textAttachment)];
   //图片插入到文字后方
//    [scaleStr appendAttributedString:attributedImage];
   //如果要插入到前面
   [scaleStr insertAttributedString:attributedImage atIndex:1];
    return scaleStr;
}
- (YYTextLayout *)createTextImage1:(NSString*)text witImage:(NSString*)imageName withSize:(CGSize)finalSize{
    UIFont *font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *textGold = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:font}];
  //可以添加UIKit的控件及事件
//    UIImageView *imagImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    imagImage.image = [UIImage imageNamed:imageName];
    UIImage * iamge = [UIImage imageNamed:imageName];
    NSMutableAttributedString *attachTextRecahrage = [NSMutableAttributedString attachmentStringWithContent:iamge contentMode:UIViewContentModeLeft attachmentSize:CGSizeMake(62, 22) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [textGold  appendAttributedString:attachTextRecahrage];
    //如果要插入到前面
//    [textGold insertAttributedString:attachTextRecahrage atIndex:0];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(finalSize.width, finalSize.height)]; //图文混排需要的宽度及高度
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:textGold];
    return textLayout;
}
-(void)chooseViewMsg:(UIButton*)sender{
    
    switch (self.currentTag) {
        case 0:
        {
            self.currentTag = 1;
            if (self.layView == nil) {
                self.layView = [[LayNeedView alloc]initWithFrame:CGRectMake(20, 128, SCREEN_WIDTH - 40, 40)];
                self.layView.backgroundColor = [UIColor greenColor];
                [self.view addSubview:self.layView];

            }else{
                self.layView.backgroundColor = [UIColor purpleColor];

            }
            [sender setTitle:@"调用创建" forState:UIControlStateNormal];

        }
            break;
        case 1:
        {
            self.currentTag = 2;
            [sender setTitle:@"调用layoutSubviews" forState:UIControlStateNormal];
            [self.layView layoutSubviews];
        }
            break;
        case 2:
        {
            self.currentTag = 3;
            [sender setTitle:@"调用setNeedsLayout" forState:UIControlStateNormal];
            [self.layView setNeedsLayout];
        }
            break;
        case 3:
        {
            self.currentTag = 4;
            [sender setTitle:@"调用layoutIfNeeded" forState:UIControlStateNormal];
            [self.layView layoutIfNeeded];
        }
            break;
        case 4:
        {
            self.currentTag = 5;
            [sender setTitle:@"调用setNeedsDisplay" forState:UIControlStateNormal];
            [self.layView setNeedsDisplay];

        }
            break;
        case 5:
        {
            self.currentTag = 0;
            [sender setTitle:@"修改farme" forState:UIControlStateNormal];
//            [UIView animateWithDuration:0.5 animations:^{
                self.layView.frame = CGRectMake(30, 158, SCREEN_WIDTH - 60, 40);
//            }];

        }
            break;
            
        default:
            break;
    }
}
-(void)runloopTest{
    //1.创建监听者
        /*
         第一个参数:怎么分配存储空间
         第二个参数:要监听的状态 kCFRunLoopAllActivities 所有的状态
         第三个参数:时候持续监听
         第四个参数:优先级 总是传0
         第五个参数:当状态改变时候的回调
         */
//    CFRunLoopSourceRef
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            
            /*
             kCFRunLoopEntry = (1UL << 0),        即将进入runloop
             kCFRunLoopBeforeTimers = (1UL << 1), 即将处理timer事件
             kCFRunLoopBeforeSources = (1UL << 2),即将处理source事件
             kCFRunLoopBeforeWaiting = (1UL << 5),即将进入睡眠
             kCFRunLoopAfterWaiting = (1UL << 6), 被唤醒
             kCFRunLoopExit = (1UL << 7),         runloop退出
             kCFRunLoopAllActivities = 0x0FFFFFFFU
             */
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"即将进入runloop");
                    break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"即将处理timer事件");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"即将处理source事件");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"即将进入睡眠");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"被唤醒");
                    break;
                case kCFRunLoopExit:
                    NSLog(@"runloop退出");
                    break;
                    
                default:
                    break;
            }
        });
        
        /*
         第一个参数:要监听哪个runloop
         第二个参数:观察者
         第三个参数:运行模式
         */
        CFRunLoopAddObserver(CFRunLoopGetCurrent(),observer, kCFRunLoopDefaultMode);
    
//    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), nil, kCFRunLoopDefaultMode);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
