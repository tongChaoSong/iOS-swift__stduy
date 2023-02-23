//
//  AVSpeechSynthesizerManger.h
//  1998demo
//
//  Created by TCS on 2022/11/18.
//  Copyright © 2022 TCS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVSpeechSynthesizerManger : NSObject

@property (nonatomic, copy) void (^SuccessEndingBlock)(BOOL isEnding);

@property(nonatomic,assign)float rate;   //语速

@property(nonatomic,assign)float volume; //音量

@property(nonatomic,assign)float pitchMultiplier;  //音调

@property(nonatomic,assign)BOOL  autoPlay;  //自动播放
//在读下一句的时候， 延时0.1s
@property(nonatomic,assign)float postUtteranceDelay;  //音调


//

@property(nonatomic,assign)BOOL isSpeaking;  //是否播放

//类方法实例出对象

+ (AVSpeechSynthesizerManger *)sharedInstance;

//播放并给出文字

- (void)play:(NSString *)string;

- (void)stopPlay;

- (void)pausePlay;

-(void)contiune;

@end

NS_ASSUME_NONNULL_END
