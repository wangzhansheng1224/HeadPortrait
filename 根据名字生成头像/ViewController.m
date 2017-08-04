//
//  ViewController.m
//  根据名字生成头像
//
//  Created by 王战胜 on 2017/5/18.
//  Copyright © 2017年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#define IMScreenWidth [UIScreen mainScreen].bounds.size.width
#define IMScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageV.center = CGPointMake(self.view.center.x, self.view.center.y);
    imageV.layer.cornerRadius=100;
    UIImage *img = [self imageWithTitle:@"胜" fontSize:52 imageColor:[UIColor redColor] titleColor:[UIColor whiteColor]];
    imageV.image = img;
    [self.view addSubview:imageV];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize imageColor:(UIColor *)imageColor titleColor:(UIColor *)titleColor{
    //画布大小
    UIImage * iconImage = [[UIImage alloc]init];
    
    CGRect iconRect=CGRectMake(0, 0, IMScreenWidth/2, IMScreenWidth/2);
    UIGraphicsBeginImageContext(iconRect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [imageColor CGColor]);
    CGContextFillRect(context, iconRect);
    iconImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    fontSize = iconRect.size.width/10.0*6.0;
    CGSize size=iconImage.size;
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    
    [iconImage drawAtPoint:CGPointMake(0.0,0.0)];
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:iconImage.size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}context:nil].size;
    CGFloat width = iconImage.size.width;
    CGFloat height = iconImage.size.height;
    
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    //绘制文字
    [title drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:titleColor,NSParagraphStyleAttributeName:paragraphStyle}];
    
    //返回绘制的新图形
    iconImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return iconImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
