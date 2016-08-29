//
//  TitleButton.m
//  SinaWB
//
//  Created by 赵麦 on 8/29/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        self.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews]; //在默认基础上调整x即可
    // if only switch position
    
    //1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
    //2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    
    
    [self sizeToFit];
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect {
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 13;
//    CGFloat heigt = contentRect.size.height;
//    return CGRectMake(x, y, width, heigt);
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect {
//    CGFloat x = 0;
//    CGFloat y = 0;
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.titleLabel.font; //死循环 所以要用-(void)layoutSubviews
//    CGFloat width = [self.currentTitle sizeWithAttributes:attrs].width;
//    CGFloat heigt = contentRect.size.height;
//    return CGRectMake(x, y, width, heigt);
//}

@end
