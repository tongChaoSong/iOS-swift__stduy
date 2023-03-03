//
//  SliderView.h
//  SwiftStudyBook
//
//  Created by TCS on 2023/3/2.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SliderViewDelegate <NSObject>



@end
@interface SliderView : BaseView

@property (nonatomic, assign) BOOL isdragging; ///< 是否滑动

@property (nonatomic, assign) CGFloat value; ///<

@property (nonatomic, assign) CGFloat bufferValue; ///<


@property (nonatomic, strong) UIButton* sliderBtn; ///<

@property (nonatomic, assign) id <SliderViewDelegate>delegate; ///<

@end

NS_ASSUME_NONNULL_END
