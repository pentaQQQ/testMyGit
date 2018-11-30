//
//  CommentItem.h
//  ONLY
//
//  Created by Dylan on 27/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject

@property (nonatomic, strong) NSString *comment_id;

@property (nonatomic, strong) NSString *member_comment_id;

@property (nonatomic, strong) NSString *member_name;

@property (nonatomic, strong) NSString *comment_content;

@property (nonatomic, strong) NSString *member_id;

@property (nonatomic, strong) NSString *is_privated;

@property (nonatomic, assign) CGFloat comment_star;

@property (nonatomic, strong) NSString *comment_time;

@property (nonatomic, strong) NSArray *comment_img;

@property (nonatomic, strong) NSString *portrait;

@end
