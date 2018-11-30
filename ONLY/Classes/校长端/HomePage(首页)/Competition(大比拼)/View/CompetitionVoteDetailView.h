//
//  CompetitionVoteDetailView.h
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionVoteDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *portraitIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *photoIVArray;
@property (weak, nonatomic) IBOutlet UIView *videoBgView;

@property (nonatomic,strong)NSMutableArray * photoArray;
@property (nonatomic,strong)NSString * videoUrlStr;

@end
