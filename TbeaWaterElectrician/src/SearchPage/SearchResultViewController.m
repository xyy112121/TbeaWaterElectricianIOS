//
//  SearchResultViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES];
}

-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	UIImageView *imageviewtopblue = [[UIImageView alloc] init];
	imageviewtopblue.frame = CGRectMake(0, 0, SCREEN_WIDTH, StatusBarHeight+44);
	imageviewtopblue.backgroundColor =COLORNOW(27, 130, 210);
	[self.view addSubview:imageviewtopblue];
	
	//扫码记录
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2, StatusBarHeight+12, 90, 20)];
	labeltitle.text = @"搜索结果";
	labeltitle.font = FONTN(17.0f);
	labeltitle.textAlignment = NSTextAlignmentCenter;
	labeltitle.textColor = [UIColor whiteColor];
	[self.view addSubview:labeltitle];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.frame = CGRectMake(10, StatusBarHeight+2, 40, 40);
	[btreturn setImage:LOADIMAGE(@"regiest_back", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
	
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight+44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-44) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self getsearchresult:self.searchtext];
}


#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
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
	return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	//NSArray *arrayhp = [dichp objectForKey:@"companylist"];
	return [arraydata count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    if(_searchtype == EnSearchGoods)
    {
        NearByProductPageCellView *productcell = [[NearByProductPageCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp];
        [cell.contentView addSubview:productcell];
    }
    else
    {
        NearByJXSPageViewCellView *jxscell = [[NearByJXSPageViewCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp FomeFlag:@"0"];
        [cell.contentView addSubview:jxscell];
    }
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    if(_searchtype == EnSearchGoods)
    {
        NearByGoodsDetailViewController *goodsdetail = [[NearByGoodsDetailViewController alloc] init];
        goodsdetail.strproductid = [dictemp objectForKey:@"id"];
        goodsdetail.strdistrid = [dictemp objectForKey:@"companyid"];
        goodsdetail.strdistributype = [dictemp objectForKey:@"companytypeid"];
    //	goodsdetail.fromflag = @"1";
        [self.navigationController pushViewController:goodsdetail animated:YES];
    }
    else if(_searchtype == EnSearchShop)
    {
        NearByJXSDetailViewController *jxsdetail = [[NearByJXSDetailViewController alloc] init];
        jxsdetail.dicjsxfrom = dictemp;
        jxsdetail.strdistribuid = [dictemp objectForKey:@"id"];
        [self.navigationController pushViewController:jxsdetail animated:YES];
    }
    else
    {
        if([[dictemp objectForKey:@"companytypeid"] isEqualToString:@"firstleveldistributor"])
        {
            NearByJXSDetailViewController *jxsdetail = [[NearByJXSDetailViewController alloc] init];
            jxsdetail.dicjsxfrom = dictemp;
            jxsdetail.strdistribuid = [dictemp objectForKey:@"id"];
            [self.navigationController pushViewController:jxsdetail animated:YES];
        }
        else if([[dictemp objectForKey:@"companytypeid"] isEqualToString:@"distributor"])
        {
            //longitude  latitude
            WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
            webviewcontent.strtitle = [dictemp objectForKey:@"tasktitle"];
            NSString *str = [NSString stringWithFormat:@"%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:URLHeader,HttpDistribute];
            //            @"http://www.u-shang.net/enginterface/index.php/Apph5/business?companyid=";
            str = [NSString stringWithFormat:@"%@%@&userid=%@&longitude=%@&latitude=%@",str,[dictemp objectForKey:@"id"],app.userinfo.userid,[NSString stringWithFormat:@"%f",app.dili.longitude],[NSString stringWithFormat:@"%f",app.dili.latitude]];
            webviewcontent.strnewsurl = str;
            [self.navigationController pushViewController:webviewcontent animated:YES];
        }
    }
}

#pragma mark 接口
-(void)getsearchresult:(NSString *)searchtext
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:self.searchtext forKey:@"keyword"];
    NSString *strtype;
    if(self.searchtype == 1)
        strtype = @"commodity";
    else if(self.searchtype == 3)
        strtype = @"distributor";
    else
        strtype = @"companyseller";
	[params setObject:strtype forKey:@"searchtype"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG002001004000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 arraydata = [[dic objectForKey:@"data"] objectForKey:@"list"];
			 tableview.delegate = self;
			 tableview.dataSource = self;
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
