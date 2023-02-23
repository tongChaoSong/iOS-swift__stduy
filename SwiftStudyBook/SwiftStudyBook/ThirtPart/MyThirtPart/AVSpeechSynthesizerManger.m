//
//  AVSpeechSynthesizerManger.m
//  1998demo
//
//  Created by TCS on 2022/11/18.
//  Copyright © 2022 TCS. All rights reserved.
//

#import "AVSpeechSynthesizerManger.h"
#import <AVFoundation/AVFoundation.h>
@interface AVSpeechSynthesizerManger()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer * speechSynthesizer;


@end
@implementation AVSpeechSynthesizerManger
+ (AVSpeechSynthesizerManger *)sharedInstance {
    static AVSpeechSynthesizerManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AVSpeechSynthesizerManger alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        return;
    }
    self.speechSynthesizer = [AVSpeechSynthesizer new];
    self.speechSynthesizer.delegate = self;

    //音量 0-1；
    self.volume = 1;
    //阅读的速率 0-1
    self.rate = 0.5;
    ////音调， 默认为1.0 ， 取值范围为0.5 - 2.0
    self.pitchMultiplier = 0.8;
    //在读下一句的时候， 延时0.1s
    self.postUtteranceDelay = 0.1f;
}
- (BOOL)isSpeaking
{
    return self.speechSynthesizer.isSpeaking;
}
//播放并给出文字

- (void)play:(NSString *)string{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];

//    zh-CN 中文
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.volume = self.volume;
    utterance.rate = self.rate;
    utterance.pitchMultiplier = self.pitchMultiplier;
    utterance.postUtteranceDelay = self.postUtteranceDelay;
    if ([self.speechSynthesizer isSpeaking])
    {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
    [self.speechSynthesizer speakUtterance:utterance];
}

- (void)stopPlay{
    //停止读音，传入的参数 立刻停止还是读完一个单词停止
    if( [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord]){
        NSLog(@"成功停止");
    }else {
        NSLog(@"停止失败");
    }
}

- (void)pausePlay{
    if ([self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate]) {
        NSLog(@"成功暂停");
    }else {
        NSLog(@"暂停失败");
    }
}

-(void)contiune {
    if( [self.speechSynthesizer continueSpeaking]){
        NSLog(@"成功播放");
    }else {
        NSLog(@"播放失败");
    }

}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    //每一个utterance对象读取之前回调
    NSLog(@"%s", __func__);

}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    
  NSLog(@"%s", __func__);

}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {

   NSLog(@"%s", __func__);
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"%s", __func__);

}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
     //每一个utterance对象读取完之后回调
    NSLog(@"%s", __func__);

}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
  //根据读取的范围， 或者读取的文字内容做自定义操作
    NSLog(@"%@---", synthesizer.outputChannels);
}
@end
