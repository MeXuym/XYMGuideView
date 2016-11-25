//
//  XYMGuideView.m
//  healthcoming
//
//  Created by jack xu on 16/11/25.
//  Copyright © 2016年 Franky. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "XYMGuideView.h"

@interface XYMGuideView ()

@property(nonatomic,assign)CAShapeLayer *shapeLayer;

@end


@implementation XYMGuideView

@synthesize delegate;

- (instancetype)init{
    
    if (self = [super init]) {
    }
    return self;
}

/**
 * 不管调用的init还是initWithFrame,都会来到这里
 */
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
    }
    return self;
}

-(void)setGuideName:(NSString *)guideName{
    
    _guideName = guideName;
    
    int startCount = [self addStartCount:_guideName];
    if (startCount == 1)
    {
        [self newUserGuide];
    }
}

-(int)addStartCount:(NSString *)name{

    NSString* key=[NSString stringWithFormat:@"start%@count_version",name];
    int startcount=[((NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:key]) intValue];
    startcount++;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:startcount] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return startcount;
}


- (void)newUserGuide
{

    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    //引导层是加在window上
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [self addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    
    // 这里添加第二个路径 （这个是圆）
    CGPoint point = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:50 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    _shapeLayer = shapeLayer;
    [self.layer setMask:_shapeLayer];

}

//设置圆形焦点区域
-(void)setCircularFocus:(CGPoint)Center radius:(int)radius{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    // 这里添加第二个路径 （这个是圆）
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:Center radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    _shapeLayer = shapeLayer;
    
    [self.layer setMask:_shapeLayer];
    
    [self layoutSubviews];
    
}
//设置矩形焦点区域
-(void)setRectangleFocus:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    // 这里添加第二个路径 （这个是矩形）
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    _shapeLayer = shapeLayer;
    
    [self.layer setMask:_shapeLayer];
    
    [self layoutSubviews];
}

-(void)addTipsView:(UIView *)tipsView{
    
    NSString* key=[NSString stringWithFormat:@"start%@count_version",self.guideName];
    int startcount=[((NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:key]) intValue];
    if (startcount == 1)
    {
        [self addSubview:tipsView];
    }
    [self layoutSubviews];
}


/**
 *   点击了指引层
 */
- (void)sureTapClick:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [view removeFromSuperview];
    [view removeGestureRecognizer:tap];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstCouponBoard_iPhone"];
    
    if(delegate && [delegate respondsToSelector:@selector(XYMGuideClick:)])
    {
        [delegate XYMGuideClick:self.guideName];
    }
}


@end
