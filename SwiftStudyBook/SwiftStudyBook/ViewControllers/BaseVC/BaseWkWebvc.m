//
//  BaseWkWebvc.m
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/24.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "BaseWkWebvc.h"

@interface BaseWkWebvc ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *mainWkWeb;

@end

@implementation BaseWkWebvc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWKWeb];
    // Do any additional setup after loading the view.
}
-(void)setUrl:(NSString *)url{
    _url = url;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [self.mainWkWeb loadRequest:request];
}
-(void)createWKWeb{
    
    WKWebViewConfiguration * webConfig = [WKWebViewConfiguration new];
//    WKUserContentController *userController = [WKUserContentController new];
////        NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
////        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
////        [userController addUserScript:script];
////    webConfig.dataDetectorTypes = WKDataDetectorTypeAll;
////    webConfig.userContentController = userController;
//    webConfig.allowsInlineMediaPlayback = YES;//是否允许内联(YES)或使用本机全屏控制器(NO)，默认是NO。
//    if (@available(iOS 10.0, *)) {
//        webConfig.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
//    } else {
//        // Fallback on earlier versions
//    }
//    webConfig.allowsAirPlayForMediaPlayback = YES;
//    webConfig.allowsPictureInPictureMediaPlayback = YES;
//    
//    NSString *jSString = @"document.getElementsByTagName('video')[0].setAttribute('playsinline','');";
//    NSString *jSString2 = @"document.getElementsByTagName('video')[0].autoplay=false;";
//    NSString *jSString3 = @"document.getElementsByTagName('video')[0].setAttribute('playsinline','playsinline'";
//
//    //用于进行JavaScript注入
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserScript *wkUScript2 = [[WKUserScript alloc] initWithSource:jSString2 injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserScript *wkUScript3 = [[WKUserScript alloc] initWithSource:jSString3 injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//    
//    [webConfig.userContentController addUserScript:wkUScript];
//    [webConfig.userContentController addUserScript:wkUScript2];
//    [webConfig.userContentController addUserScript:wkUScript3];
//
//    //添加一个协议
//    [webConfig.userContentController addScriptMessageHandler:self name:@"pauseVideo"];
//    [webConfig.userContentController addScriptMessageHandler:self name:@"getPlayTime"];
//    [webConfig.userContentController addScriptMessageHandler:self name:@"setPlayTime"];
//    [webConfig.userContentController addScriptMessageHandler:self name:@"screenOrientation"];

    
    _mainWkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:webConfig];
//    _mainWkWeb.scrollView.scrollEnabled = false;
//    _mainWkWeb.configuration.allowsInlineMediaPlayback = YES;
//    _mainWkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//    _mainWkWeb.userInteractionEnabled = YES;
//    _mainWkWeb.backgroundColor = [UIColor clearColor];
//    _mainWkWeb.backgroundColor = [toolClass colorWithHexString:@"#F6F6F6" alpha:1];
    _mainWkWeb.navigationDelegate = self;
//    [_mainWkWeb evaluateJavaScript:@"document.getElementsByTagName('video')[0].setAttribute('playsinline','playsinline');" completionHandler:nil];

//    [wkWebview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F6F7F3'"];
//    [_mainWkWeb evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#F6F7F3'" completionHandler:nil];
    [self.view addSubview: _mainWkWeb];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.mainWkWeb loadRequest:request];
}

/**
 *页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"网页开始加载");
    
}

/**
 *页面加载失败时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"网页加载失败");
    
}
/**
 *页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用");
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"didReceiveScriptMessage==%@",message.name);
    if ([message.name caseInsensitiveCompare:@"pauseVideo"] == NSOrderedSame) {
        [self openShareWithBody:message.body];
        NSLog(@"video is readytoplay");
    }
    if ([message.name caseInsensitiveCompare:@"getPlayTime"] == NSOrderedSame) {
        NSLog(@"video is play");
    }
    if ([message.name caseInsensitiveCompare:@"setPlayTime"] == NSOrderedSame) {
        NSLog(@"video is pause");
    }
    if ([message.name caseInsensitiveCompare:@"screenOrientation"] == NSOrderedSame) {
        NSLog(@"video is ended");
    }
    if ([message.name isEqualToString:@"getRequestHeader"]) {
        [self getRequestHeader];
     }
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortraitUpsideDown) forKey:@"orientation"];
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
}
//分享链接
- (void)openShareWithBody:(id)body{
    if (body && ![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
}
//获取请求头数据
- (void)getRequestHeader {
    
//    NSString *jsStr = [NSString stringWithFormat:@"setRequestHeader('%@','%@','%@')",[SCUserEntity shareInstance].tokenId,[SCUserEntity shareInstance].memberId,[SCUserEntity shareInstance].phoneNum];
//    
//    [self.mainWkWeb evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"%@----%@",result, error);
//    }];
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
