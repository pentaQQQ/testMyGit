//
//  CartViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "CartViewController.h"
#import "MineCartCell.h"
#import "MineSureOrderController.h"
#import "goodModel.h"
#import "UITableView+Sure_Placeholder.h"
#import "MBProgressHUD+Extension.h"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CartViewController
{
    UITableView *tableview;
    UIButton *orderBtn;
    UILabel *sumLab;
    UILabel *priceLab;
    UILabel *yunLab;
    UIButton *EditBtn;
    BOOL isEdit;
    BOOL isImg;
    UIImageView *selImage;
    NSMutableArray *dataArray;
    NSInteger num;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setNavView];
    
    [self makeUI];
    
    [self loadData];
    
}

//加入购物车
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    if(self.type==1){
    UIButton *backBtn = [UIButton new];
    [view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.sd_layout.leftSpaceToView(view,8).topSpaceToView(view,25).heightIs(30).widthIs(30);
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    }
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"购物车";
    
    EditBtn = [UIButton new];
    [view addSubview:EditBtn];
    EditBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    EditBtn.titleLabel.font = font(14);
    [EditBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [EditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    EditBtn.sd_layout.rightSpaceToView(view,17).topSpaceToView(view,35).widthIs(44).heightIs(14);
    [EditBtn addTarget:self action:@selector(EditBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)EditBtnClick
{
    isEdit = !isEdit;
    if (isEdit==NO) {
        
        [EditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [sumLab setHidden:NO];
        [priceLab setHidden:NO];
        [yunLab setHidden:NO];
        [orderBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    }
    else
    {
      [EditBtn setTitle:@"完成" forState:UIControlStateNormal];
      [sumLab setHidden:YES];
      [priceLab setHidden:YES];
      [yunLab setHidden:YES];
      [orderBtn setTitle:@"删除" forState:UIControlStateNormal];
    }
   
}

- (void)makeUI
{
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.rowHeight = 92;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = ClearColor;
    tableview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,64).topSpaceToView(self.view,64);
    [tableview registerNib:[UINib nibWithNibName:@"MineCartCell" bundle:nil] forCellReuseIdentifier:@"MineCartCell"];
    tableview.firstReload = YES;
    [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self makeBottomView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCartCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.numText.keyboardType = UIKeyboardTypeNumberPad;
    cell.addBtn.layer.cornerRadius= 4;
    cell.addBtn.layer.borderColor = colorWithRGB(0xCCCCCC).CGColor;
    cell.addBtn.layer.borderWidth = 1;
    
    cell.reduceBtn.layer.cornerRadius= 4;
    cell.reduceBtn.layer.borderColor = colorWithRGB(0xCCCCCC).CGColor;
    cell.reduceBtn.layer.borderWidth = 1;

    goodModel *model = dataArray[indexPath.row];
    cell.cartTitle.text = model.good_name;
    cell.cartPrice.text = model.unit_price;
    cell.numText.text = model.goods_number;
    cell.numText.userInteractionEnabled = NO;
    cell.num =10; //[model.start_num integerValue];
    NSString *str = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.good_img];
    [cell.cartImg sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"图层59"]];
    if ([model.selected isEqualToString:@"1"])
    {
        cell.selectedImg.image = [UIImage imageNamed:@"selected"];
    }
    else
    {
      cell.selectedImg.image = [UIImage imageNamed:@"pay_normal"];
    }
    
    //cell的点击事件
    __weak typeof(cell)weakcell = cell;
    cell.AddBlock = ^(void)
    {
       model.goods_number = [NSString stringWithFormat:@"%ld",[model.goods_number integerValue]+[model.start_num integerValue]];
       [DataSourceTool editNumgoods_id:model.good_id cart_id:model.cart_id num:model.goods_number ViewController:self success:^(id json) {
           if ([json[@"errcode"] integerValue]==0) {
               
             weakcell.numText.text = model.goods_number;
               float price1 = 0.00;
               NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
               NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
               for (goodModel *model in arr) {
                   
                   price1 += [model.unit_price floatValue]*[model.goods_number integerValue];
                   
               }
               
               priceLab.text = [NSString stringWithFormat:@"¥%.2f",price1];
           }
           
       } failure:^(NSError *error) {
           
           
       }];
    
    };
    
    cell.ReduceBlock = ^(void)
    {
         model.goods_number =  [NSString stringWithFormat:@"%ld",[model.goods_number integerValue]-[model.start_num integerValue]];
        [DataSourceTool editNumgoods_id:model.good_id cart_id:model.cart_id num:model.goods_number ViewController:self success:^(id json) {
            if ([json[@"errcode"] integerValue]==0) {
                
               weakcell.numText.text = model.goods_number;
                float price1 = 0.00;
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
                NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
                for (goodModel *model in arr) {
                    
                    price1 += [model.unit_price floatValue]*[model.goods_number integerValue];
                    
                }
                
                priceLab.text = [NSString stringWithFormat:@"¥%.2f",price1];
            }
            
        } failure:^(NSError *error) {
            
        }];
    
    };
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    goodModel *model = dataArray[indexPath.row];
    
    float price1 = 0.00;
    float price2 = 0.00;
    
    cell.isSelected = !cell.isSelected;
    if (cell.isSelected==YES) {
        cell.selectedImg.image = [UIImage imageNamed:@"selected"];
        model.selected = @"1";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
        NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
        for (goodModel *model in arr) {
            
        price1 += [model.unit_price floatValue]*[model.goods_number integerValue];
            
        }
        
        priceLab.text = [NSString stringWithFormat:@"¥%.2f",price1];
        
    }
    else
    {
        cell.selectedImg.image = [UIImage imageNamed:@"pay_normal"];
        model.selected = @"0";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
        NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
        for (goodModel *model in arr) {
            
        price2 = [model.unit_price floatValue]*[model.goods_number integerValue];
            
        }
        
        priceLab.text = [NSString stringWithFormat:@"¥%.2f",price2];
    }
    
}

- (void)makeBottomView
{
    UIView *view  = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = WhiteColor;
    if(self.type==1)
    {
     view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(64);
    }
    else
    {
     view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,50).heightIs(64);
    }
    
    orderBtn = [UIButton new];
    [view addSubview:orderBtn];
    orderBtn.titleLabel.font = font(14);
    orderBtn.backgroundColor = colorWithRGB(0xF77142);
    [orderBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [orderBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.sd_layout.rightSpaceToView(view,16*SCREEN_PRESENT).topSpaceToView(view,9).widthIs(107*SCREEN_PRESENT).heightIs(45*SCREEN_PRESENT);
    cornerRadiusView(orderBtn,4);
    
    UIButton *selBtn = [UIButton new];
    [view addSubview:selBtn];
    [selBtn addTarget:self action:@selector(selectedAll) forControlEvents:UIControlEventTouchUpInside];
    selBtn.sd_layout.leftSpaceToView(view,0).topSpaceToView(view,0).bottomSpaceToView(view,0).widthIs(70);
    
    selImage = [UIImageView new];
    selImage.image = [UIImage imageNamed:@"pay_normal"];
    [selBtn addSubview:selImage];
    selImage.sd_layout.leftSpaceToView(selBtn,16).topSpaceToView(selBtn,22).widthIs(19).heightIs(19);
    
    UILabel *allLab = [UILabel new];
    allLab.font= font(14);
    allLab.textColor = colorWithRGB(0x333333);
    allLab.textAlignment = NSTextAlignmentLeft;
    allLab.text = @"全选";
    [selBtn addSubview:allLab];
    allLab.sd_layout.leftSpaceToView(selImage,7).topSpaceToView(selBtn,25).widthIs(28).heightIs(14);
    
    sumLab = [UILabel new];
    sumLab.font= font(14);
    sumLab.textColor = colorWithRGB(0x333333);
    sumLab.textAlignment = NSTextAlignmentLeft;
    sumLab.text = @"合计：";
    [selBtn addSubview:sumLab];
    sumLab.sd_layout.leftSpaceToView(allLab,24).topSpaceToView(selBtn,19).widthIs(42).heightIs(14);
    
    priceLab = [UILabel new];
    priceLab.font= font(21*SCREEN_PRESENT);
    priceLab.textColor = colorWithRGB(0xEA5520);
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.text = @"¥ 0.00";
    [view addSubview:priceLab];
    priceLab.sd_layout.leftSpaceToView(sumLab,5).topSpaceToView(view,15).rightSpaceToView(orderBtn,5).heightIs(16);
    
    yunLab = [UILabel new];
    yunLab.font= font(12);
    yunLab.textColor = colorWithRGB(0x666666);
    yunLab.textAlignment = NSTextAlignmentLeft;
    yunLab.text = @"(不含运费)";
    [view addSubview:yunLab];
    yunLab.sd_layout.leftSpaceToView(allLab,24).topSpaceToView(sumLab,9).widthIs(70).heightIs(12);
    
}

- (void)selectedAll
{
    if (dataArray.count==0) {
        
        [MBProgressHUD showSuccess:@"购物车里暂无商品，请先去购买" toView:self.view complete:nil];
    }
    else{
    float price = 0;
    isImg = !isImg;
    if (isImg==YES) {
       selImage.image = [UIImage imageNamed:@"selected"];
        //遍历数组 然后给状态值赋值 让所有的都勾选
        for (goodModel *model  in dataArray) {
            model.selected = @"1";
            price +=[model.unit_price floatValue]*[model.goods_number integerValue];
        }
            priceLab.text = [NSString stringWithFormat:@"¥%.2f",price];
    }
    else
    {
      selImage.image = [UIImage imageNamed:@"pay_normal"];
        //遍历数组 然后给状态值赋值 让所有的都勾选
        for (goodModel *model  in dataArray) {
            
            model.selected = @"0";
        }
        priceLab.text = @"¥0.00";
    }
    }
    
    [tableview reloadData];
}

//确认订单 //删除订单
- (void)orderBtnClick
{
    //确认订单(去结算)
    if (isEdit==NO) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
        NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
        NSMutableArray *temp = [NSMutableArray array];
        
        for (goodModel *model in arr) {
            [temp addObject:model.cart_id];
        }
        NSString *goodIds = [temp componentsJoinedByString:@","];
        [DataSourceTool settleOrderID:goodIds ViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                MineSureOrderController *vc  = [MineSureOrderController new];
                vc.cart_ids = goodIds;
                vc.goodPrice = json[@"rsp"][@"all_amount"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } failure:^(NSError *error) {
            
        }];

    }
     //删除订单
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
        NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
        NSMutableArray *temp = [NSMutableArray array];
        
        for (goodModel *model in arr) {
            [temp addObject:model.cart_id];
        }
        NSString *goodIds = [temp componentsJoinedByString:@","];
        
        [DataSourceTool deleteOrderID:goodIds ViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:^{
                    [dataArray removeObjectsInArray:arr];
                    if (dataArray.count==0) {
                        priceLab.text = @"¥0.00";
                    }
                    [tableview reloadData];
                }];
            }
        
        } failure:^(NSError *error) {
            
        }];
        
    }
}

//加载数据
- (void)loadData
{
  [DataSourceTool cartListtoViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
       
          NSMutableArray *temp = [NSMutableArray array];
          for (NSDictionary *dic in json[@"rsp"][@"infos"]) {
              
              goodModel *model = [goodModel new];
              [model setValuesForKeysWithDictionary:dic];
              [temp addObject:model];
          }
           dataArray  = temp;
          [tableview reloadData];
      }
      
  } failure:^(NSError *error) {
      
  }];

}

@end
