//
//  SearchController.h
//  Choose
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "BaseViewController.h"
#import "TTTagView.h"
#import "TTGroupTagView.h"
#import "FTPopOverMenu.h"


typedef NS_ENUM(NSInteger, SearchType) {
    
    SearchTypeGoods = 0,    //产品
    SearchTypeRecruit = 1,      //服务
    SearchTypeVideo = 2,        //培训
    SearchTypeIdea = 3,         // 金点子
};

@interface SearchController : BaseViewController

//@property (nonatomic, assign) SearchType type;
//@property (nonatomic, copy  ) void(^selectedTagBlock)(NSString *strValue);          // 搜索内容

+(void)presentToSearchControllerWithContext:(UIViewController *)target type:(SearchType)type;

@end
