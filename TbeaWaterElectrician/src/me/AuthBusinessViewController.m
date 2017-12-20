//
//  AuthBusinessViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AuthBusinessViewController.h"

@interface AuthBusinessViewController ()

@end

@implementation AuthBusinessViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self initview];
    [self getcertificationinfo];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
	
	//返回按钮和标题
	UIButton *buttonback = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonback.frame = CGRectMake(10, StatusBarHeight +2, 40, 40);
	buttonback.backgroundColor = [UIColor clearColor];
	[buttonback setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	[buttonback addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonback];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(50, XYViewTop(buttonback), SCREEN_WIDTH-100, 40)];
	labelname.text = @"实名认证";
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor whiteColor];
	[self.view addSubview:labelname];
}

-(void)viewheader
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
	view.backgroundColor = COLORNOW(0, 170, 238);
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-102)/2, 100, 102, 75)];
	
	[view addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(40, XYViewBottom(imageview)+10, SCREEN_WIDTH-100, 20)];
	labelname.text = @"你未通过实名认证";  //证件审核中   已通过实名认证
	labelname.font = FONTN(14.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor whiteColor];
	[view addSubview:labelname];
	
    if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"notidentify"]) //未认证
    {

    }
    else if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"identifyfailed"]) //认证失败
    {
        imageview.image = LOADIMAGE(@"me审核未通过", @"png");
        labelname.text = @"你未通过实名认证";
    }
    else if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"identified"]) //已认证
    {
        imageview.image = LOADIMAGE(@"me审核通过", @"png");
        labelname.text = @"你已通过实名认证";
    }
    else //认证中
    {
        imageview.image = LOADIMAGE(@"me审核中", @"png");
        labelname.text = @"实名认证审核中";
    }
    
	
	
	//四个按钮
	tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

//-(void)gotosetting:(id)sender
//{
//    MyPageSettingViewController *mysetting = [[MyPageSettingViewController alloc] init];
//    mysetting.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:mysetting animated:YES];
//}

#pragma mark ActionDelegate


#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
		return 2;
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return 0.001;
	return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return nil;
	else
	{
		UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
		viewheader.backgroundColor = COLORNOW(235, 235, 235);
		return viewheader;
	}
	return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 90, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(14.0f);
	[cell.contentView addSubview:labelname];
	
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-115, 20)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = [UIColor blackColor];
	labelvalue.font = FONTN(14.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labelvalue];
	
	switch (indexPath.section)
	{
		case 0:
			switch (indexPath.row)
			{
				case 0:
					labelname.text = @"真实姓名";
					labelvalue.text = [FCcompanyidentifyinfo objectForKey:@"realname"];
					break;
				case 1:
					labelname.text = @"身份证号";
					labelvalue.text = [FCcompanyidentifyinfo objectForKey:@"personcardid"];
					break;
			}
			break;
		case 1:
			switch (indexPath.row)
			{
				case 0:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
					labelname.text = @"证件审核";
                    labelvalue.frame = CGRectMake(100, 10, SCREEN_WIDTH-140, 20);
					labelvalue.text = [FCcompanyidentifyinfo objectForKey:@"identifystatus"];
					break;
			}
			break;
		
		
			
	}
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section ==1)&&(indexPath.row == 0))
    {
        if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"notidentify"]) //未认证
        {
//            UserAuthorizationViewController *userauth = [[UserAuthorizationViewController alloc] init];
//            [self.navigationController pushViewController:userauth animated:YES];
        }
        else if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"identifyfailed"]) //认证失败
        {
            AuthNotPassReasonViewController *authnotpass = [[AuthNotPassReasonViewController alloc] init];
            [self.navigationController pushViewController:authnotpass animated:YES];
//            AuthNotPassReasonViewController *authnowpass = [[AuthNotPassReasonViewController alloc] init];
//            [self.navigationController pushViewController:authnowpass animated:YES];
        }
        else if([[FCcompanyidentifyinfo objectForKey:@"identifystatusid"] isEqualToString:@"identified"]) //已认证
        {
            AuthEndViewController *authend = [[AuthEndViewController alloc] init];
            [self.navigationController pushViewController:authend animated:YES];
        }
        else //认证中
        {
            AuthEndViewController *authend = [[AuthEndViewController alloc] init];
            [self.navigationController pushViewController:authend animated:YES];

        }
    }
}

#pragma mark 接口


-(void)getcertificationinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001002004" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
     {
         
     }
                                          Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             
             FCcompanyidentifyinfo = [[dic objectForKey:@"data"] objectForKey:@"useridentifyinfo"];
             [self viewheader];
             [tableview reloadData];
         }
         else
         {
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
         }
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
