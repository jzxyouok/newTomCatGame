//
//  ViewController.m
//  仿汤姆猫(高仿)
//
//  Created by YYSky on 16/6/12.
//  Copyright © 2016年 yaomars. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;//动画展示控件

@property(nonatomic, strong)NSDictionary *imgs;//接受字典

@end

@implementation ViewController

//懒加载
- (NSDictionary *)imgs{

    if (!_imgs) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tom.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        _imgs = dict;
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

//各个UIButton控件的处理事件方法
- (IBAction)clickBtn:(UIButton *)sender {
    
//    NSLog(@"sender.tag = %ld",(long)sender.tag);
    //根据绑定的tag值,来进行判断
    switch (sender.tag) {
        case 101:
        {
            int count = [self.imgs[@"pie"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"pie"];
      
        }
            break;
            
        case 102:
        {
            int count = [self.imgs[@"cymbal"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"cymbal"];
        }
            break;
            
        case 103:
        {
            int count = [self.imgs[@"drink"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"drink"];
        }
            break;
            
        case 104:
        {
            int count = [self.imgs[@"eat"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"eat"];
        }
            break;
            
        case 105:
        {
            int count = [self.imgs[@"fart"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"fart"];
        }
            break;
            
        case 106:
        {
            int count = [self.imgs[@"scratch"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"scratch"];
        }
            break;
            
        case 107:
        {
            int count = [self.imgs[@"knockout"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"knockout"];
            
        }
            break;
            
        case 108:
        {
            int count = [self.imgs[@"angry"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"angry"];

        }
            break;

        case 109:
        {
            int count = [self.imgs[@"stomach"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"stomach"];
           
        }
            break;

        case 110:
        {
            int count = [self.imgs[@"foot_right"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"footRight"];
            
        }
            break;

        case 111:
        {
            int count = [self.imgs[@"foot_left"] intValue];
            [self playAnimationWithCount:count andPrefixName:@"footLeft"];
        }
            break;
            
        default:
            break;
    }
    
}

//播放动画效果的方法
- (void)playAnimationWithCount:(int)count andPrefixName:(NSString *)name{
    
    if(self.imgView.isAnimating){
    
        return;
    }
    
    NSMutableArray *imgArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        NSString *imgName = [NSString stringWithFormat:@"%@_%02d.jpg",name,i];
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
        
        UIImage *newImage = [self getImage:image andSize:[UIScreen mainScreen].bounds.size];
        
        [imgArray addObject:newImage];
    }
    
    self.imgView.animationImages = imgArray;
    self.imgView.animationDuration = count * 0.1;
    self.imgView.animationRepeatCount = 1;
    [self.imgView startAnimating];
    
    //必须把创建的数组,在播放动画完成后,置为nil,进行释放.
    [self.imgView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:count * 0.1];
    
}

//在子线程中完成对图片的重采集
- (UIImage *)getImage:(UIImage *)image andSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{

    return YES;
}

@end
