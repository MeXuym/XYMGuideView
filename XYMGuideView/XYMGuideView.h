//
//  XYMGuideView.h
//  healthcoming
//
//  Created by jack xu on 16/11/25.
//  Copyright © 2016年 Franky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYMGuideViewDelegate <NSObject>

-(void)XYMGuideClick:(NSString*)guideName;

@end


@interface XYMGuideView : UIView

//蒙版名字
@property(nonatomic,strong)NSString *guideName;

@property (nonatomic,assign) id<XYMGuideViewDelegate> delegate;

//自己定制的view用这个方法添加
-(void)addTipsView:(UIView *)tipsView;

//设置圆形焦点区域
-(void)setCircularFocus:(CGPoint)Center radius:(int)radius;
//设置矩形焦点区域
-(void)setRectangleFocus:(CGRect)rect;

@end
