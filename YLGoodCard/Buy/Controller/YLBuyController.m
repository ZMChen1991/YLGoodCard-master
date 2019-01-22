//
//  YLBuyController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//


#import "YLBuyController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLBuyTableViewCell.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"
#import "YLSortView.h"
#import "YLBrandController.h"
#import "YLBuyCellFrame.h"
#import "YLNoneView.h"
#import "YLBuyTool.h"
#import "YLSearchParamModel.h"
#import "YLRequest.h"
#import "YLSearchParamView.h"
#import "YLHomeTool.h"
#import "YLTitleLinkageView.h"
#import "YLConditionParamView.h"
#import "YLBarButton.h"
#import "YLBarView.h"
#import "YLBuyConditionModel.h"

/*
 品牌列表
 */
#define YLBuyPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"buy.text"]

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define YLTITLEHEIGHT 50

@interface YLBuyController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIGestureRecognizerDelegate, YLTitleLinkageViewDelegate, YLConditionParamViewDelegate>

@property (nonatomic, strong) YLTitleLinkageView *linkage;
@property (nonatomic, assign) BOOL isSelectLinkage;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) UITableView *tableView;// 数据表
@property (nonatomic, strong) YLSortView *sortView;// 排序视图
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格视图
@property (nonatomic, strong) YLSelectView *selectView; // 筛选视图
@property (nonatomic, assign) BOOL isSelect;// 是否选中标题
@property (nonatomic, strong) UIView  *coverView;// 蒙板
@property (nonatomic, assign) BOOL isLarge;// 是否大图模式，默认是NO
@property (nonatomic, strong) YLNoneView *noneView;// 搜索为空显示的视图

@property (nonatomic, strong) YLSearchParamView *searchParamView; // 搜索参数视图
@property (nonatomic, strong) YLConditionParamView *conditionParamView; // 搜索参数显示的视图

@property (nonatomic, strong) NSMutableArray *recommends;// 推荐列表或者搜索列表
@property (nonatomic, strong) NSMutableArray *modelArray;// 存放数据模型的数组

@property (nonatomic, strong) NSMutableDictionary *selectParam;// 网络请求的参数
@property (nonatomic, strong) NSMutableDictionary *params;// 网络请求的参数

@property (nonatomic, strong) NSMutableArray *sortModels;// 排序
@property (nonatomic, strong) NSMutableArray *priceModels;// 价格
@property (nonatomic, strong) NSMutableArray *multiSelectModels;// 筛选

@property (nonatomic, strong) NSMutableArray *selectParams;// 存放选中条件的数组
@property (nonatomic, strong) NSMutableArray *selectViewSelectParams;// 存放筛选视图选中的条件数组
//@property (nonatomic, strong) NSMutableDictionary *selectDict;
//@property (nonatomic, strong) NSMutableArray *allModels; // 存放所有的model

@property (nonatomic, strong) YLBuyConditionModel *lowModel;
@property (nonatomic, strong) YLBuyConditionModel *highModel;
@property (nonatomic, strong) YLBuyConditionModel *brandModel;
@property (nonatomic, strong) YLBuyConditionModel *seriesModel;
//@property (nonatomic, assign) BOOL isShowParamView;


@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self setNav];
    [self yl_initView];
    [self yl_initData];
    [self getLocationData];
    [self loadData];
}

// 加载数据
- (void)loadData {
    // 获取搜索列表数据
    self.noneView.hidden = YES;
    
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.detailsLabel.text = @"加载中，请稍后";
    [hub showAnimated:YES];
    [self.view addSubview:hub];
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=search";
//    NSString *urlString = @"http://192.168.0.104:8080/winglok/detail?method=search";
    __weak typeof(self) weakSelf = self;
    NSLog(@"selectParam:%@", self.selectParam);
    [YLRequest GET:urlString parameters:self.selectParam success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"buyCar:%@", responseObject[@"message"]);
            [hub removeFromSuperview];
        } else {
            [weakSelf keyedArchiverObject:responseObject toFile:YLBuyPath];
            [weakSelf getLocationData];
            [hub removeFromSuperview];
        }
    } failed:nil];
    
}
- (void)getLocationData {
    
    [self.recommends removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBuyPath];
    self.modelArray = [YLTableViewModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLTableViewModel *model in self.modelArray) {
        YLBuyCellFrame *cellFrame = [[YLBuyCellFrame alloc] init];
        cellFrame.model = model;
        cellFrame.isLargeImage = self.isLarge;
        [self.recommends addObject:cellFrame];
    }
    [self showResultView];
    [self.tableView reloadData];
    
}
- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"买车数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (void)yl_initView {
    YLTitleLinkageView *titleLinkageView = [[YLTitleLinkageView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 50)];
    titleLinkageView.delegate = self;
    titleLinkageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLinkageView];
    self.linkage = titleLinkageView;
    
    YLConditionParamView *paramView = [[YLConditionParamView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLinkageView.frame), YLScreenWidth, 50)];
    paramView.delegate = self;
    [self.view addSubview:paramView];
    self.conditionParamView = paramView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLinkageView.frame), YLScreenWidth, YLScreenHeight - CGRectGetHeight(titleLinkageView.frame) - 64 - 44)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.view addSubview:self.noneView];
}

- (void)setNav {
    // 添加左右导航栏按钮
    YLBarButton *barButton = [YLBarButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 45, 44);
    barButton.title = @"阳江";
    barButton.icon = @"地区下拉";
    [barButton addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"看图模式"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 255, 44)];
    YLBarView *barView = [[YLBarView alloc] initWithFrame:CGRectMake(10, (44 - 36) / 2, 235, 36)];
    barView.layer.cornerRadius = 5.f;
    barView.layer.masksToBounds = YES;
    barView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    barView.icon = @"搜索";
    barView.title = @"搜索您想要的车";
    __weak typeof(self) weakSelf = self;
    barView.barViewBlock = ^{
        NSLog(@"点击了barView标题视图");
        
//        YLSearchController *search = [[YLSearchController alloc] init];
//        [weakSelf.navigationController pushViewController:search animated:YES];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [YLHomeTool hotBrandWithParam:param success:^(NSDictionary * _Nonnull result) {
            NSMutableArray *hotBrands = (NSMutableArray *)result[@"data"][@"keyword"];
            YLSearchController *search = [[YLSearchController alloc] init];
            search.hotSearch = hotBrands;
            [weakSelf.navigationController pushViewController:search animated:YES];
        } failure:^(NSError * _Nonnull error) {
        }];
    };
    [view addSubview:barView];
    self.navigationItem.titleView = view;
    
    [self setNavgationBarBackgroundImage];
}

- (void)setNavgationBarBackgroundImage {
    CGGradientRef gradient;// 颜色的空间
    size_t num_locations = 2;// 渐变中使用的颜色数
    CGFloat locations[] = {0.0, 1.0}; // 指定每个颜色在渐变色中的位置，值介于0.0-1.0之间, 0.0表示最开始的位置，1.0表示渐变结束的位置
    CGFloat colors[] = {
        13.0/255.0, 196.f/255.f, 255.f/255, 1.0,
        3.0/255.0, 141.f/255.f, 255.f/255, 1.0,
    }; // 指定渐变的开始颜色，终止颜色，以及过度色（如果有的话）
    gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), colors, locations, num_locations);
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    CGPoint endPoint = CGPointMake(self.view.frame.size.width, 1.0);
    CGSize size = CGSizeMake(self.view.frame.size.width, 1.0);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    NSLog(@"%f-%f", image.size.width, image.size.height);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)leftBarButtonItemClick {
    [self showMessage:@"暂只支持阳江地区"];
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"切换大小图显示");
    self.isLarge = !self.isLarge;
    NSArray *temp = [NSArray arrayWithArray:self.recommends];
    [self.recommends removeAllObjects];
    for (YLBuyCellFrame *cellFrame in temp) {
        cellFrame.isLargeImage = self.isLarge;
        [self.recommends addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;// 获取最上层窗口
    
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 50, 50);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    
    [UIView animateWithDuration:2 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
}

// 下拉刷新
- (void)refreshHeader {
    [self loadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark 初始化数据model
- (void)yl_initData {
    
    NSArray *titles = @[@"不限", @"3万以下", @"3-5万", @"5-7万", @"7-9万", @"9-12万", @"12-16万", @"16-20万", @"20万以上"];
    NSArray *params = @[@"", @"0fgf30000", @"30000fgf50000", @"50000fgf70000", @"70000fgf90000", @"90000fgf120000", @"120000fgf160000", @"160000fgf200000", @"200000fgf99999999"];
    for (NSInteger i = 0; i < titles.count; i++) {
        YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
        model.param = params[i];
        model.title = titles[i];
        model.detail = titles[i];
        model.key = @"price";
        [self.priceModels addObject:model];
    }
    YLBuyConditionModel *lowModel = [[YLBuyConditionModel alloc] init];
    self.lowModel = lowModel;
    
    YLBuyConditionModel *highModel = [[YLBuyConditionModel alloc] init];
    self.highModel = highModel;
    
    NSArray *titles1 = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
    NSArray *params1 = @[@"1", @"2", @"3", @"4", @"5"];
    for (NSInteger i = 0; i < titles1.count; i++) {
        YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
        model.param = params1[i];
        model.title = titles1[i];
        model.detail = titles1[i];
        model.key = @"sort";
        [self.sortModels addObject:model];
    }
    
    NSArray *data = @[@[@"两厢轿车", @"三厢轿车", @"跑车", @"SUV", @"MPV", @"面包车", @"皮卡"],
                      @[@"本地牌照", @"外地牌照"],
                      @[@"手动", @"自动"],
                      @[@"低于3年", @"3-5年", @"5-7年", @"7-9年", @"9-12年", @"12年以上"],
                      @[@"低于3万", @"3-5万", @"5-7万", @"7-9万", @"9-12万", @"12万以上"],
                      @[@"低于1.0L", @"1.0L-1.3L", @"1.3L-1.6L", @"1.6L-1.9L", @"1.9L-2.2L", @"2.2L以上"],
                      @[@"国二及以上", @"国三及以上", @"国四及以上", @"国五"],
                      @[@"黑色", @"白色", @"银灰色", @"深灰色", @"银色", @"绿色", @"红色", @"咖啡色", @"香槟色", @"蓝色", @"橙色", @"其他"],
                      @[@"2座", @"4座" ,@"5座" ,@"6座" ,@"7座以上"],
                      @[@"汽油", @"柴油", @"电动", @"油电混合", @"其他"],
                      @[@"德系", @"日系", @"美系", @"法系", @"韩系", @"国产", @"其他"],
                      @[@"全景天窗", @"车身稳定控制", @"倒车影像系统", @"真皮座椅", @"无钥匙进入",@"儿童座椅接口", @"倒车雷达", @"GPS导航"]];
    NSArray *params2 = @[@"bodyStructure", @"isLocal", @"gearbox", @"vehicleAge", @"course", @"emission", @"emissionStandard", @"color", @"seatsNum", @"fuelForm", @"country", @"other"];
    NSArray *params3 = @[@"panoramicSunroof", @"stabilityControl", @"reverseVideo", @"genuineLeather", @"keylessEntrySystem", @"childSeatInterface", @"parkingRadar", @"gps"];
    for (NSInteger i = 0; i < data.count; i++) {
        NSMutableArray *details = [NSMutableArray array];
        NSArray *array = data[i];
        if (i < data.count - 1) {
            for (NSInteger j = 0; j < array.count; j++) {
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = array[j];
                model.detail = array[j];
                model.param = array[j];
                model.key = params2[i];
                [details addObject:model];
            }
        } else {
            for (NSInteger j = 0; j < array.count; j++) {
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = array[j];
                model.detail = array[j];
                model.param = @"0";
                model.key = params3[j];
                [details addObject:model];
            }
        }
        [self.multiSelectModels addObject:details];
    }
    
    [self showConditionParamView];
}

- (void)showResultView {
    
    if (self.recommends.count == 0) {
        self.noneView.hidden = NO;
        __weak typeof(self) weakSelf = self;
        self.noneView.noneViewBlock = ^{
            // 先还原再清空搜索条件数组
            [weakSelf restSelectParamModels];
            [weakSelf.selectParams removeAllObjects];
            [weakSelf showConditionParamView];
            weakSelf.noneView.hidden = YES;
            [weakSelf loadData];
        };
    }
}

- (void)showConditionParamView {
    NSLog(@"%@", self.selectParams);
    if (self.selectParams.count > 0) { // 表示有选中的参数
        self.conditionParamView.frame = CGRectMake(0, CGRectGetMaxY(self.linkage.frame), YLScreenWidth, 50);
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.conditionParamView.frame), YLScreenWidth, YLScreenHeight - CGRectGetHeight(self.linkage.frame) - 50 - 64);
    } else {
        self.conditionParamView.frame = CGRectMake(-YLScreenWidth, CGRectGetMaxY(self.linkage.frame), YLScreenWidth, 50);
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.linkage.frame), YLScreenWidth, YLScreenHeight - CGRectGetHeight(self.linkage.frame) - 64);
    }
    self.conditionParamView.params = self.selectParams;
    
    // ------------------------
    // 设置网络请求参数
    // 网络请求参数清空，重新添加
    [self.selectParam removeAllObjects];
    
    for (YLBuyConditionModel *model in self.selectParams) {
        if ([model.key isEqualToString:@"isLocal"]) {
            [self.selectParam setObject:@"阳江" forKey:@"location"];
        }
        if ([[self.selectParam allKeys] containsObject:model.key]) {// 如果字典中包含有这个key，那么值需要拼接
            NSString *obj = [self.selectParam objectForKey:model.key];
            [self.selectParam setObject:[NSString stringWithFormat:@"%@fgf%@", obj, model.param] forKey:model.key];
        } else {
            [self.selectParam setObject:model.param forKey:model.key];
        }
    }
    NSLog(@"selectParam:%@", self.selectParam);
    [self loadData];
}

#pragma mark 还原选中的买车条件参数
- (void)restSelectParamModels {
    for (YLBuyConditionModel *model in self.selectParams) {
        model.isSelect = !model.isSelect;
    }
    [self.selectParams removeAllObjects];
}

#pragma mark 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.sortView] || [touch.view isDescendantOfView:self.customPrice] || [touch.view isDescendantOfView:self.selectView]) {
        return NO;
    }
    return YES;
}
// 移除蒙版
- (void)tap:(UITapGestureRecognizer *)tap {
    UIView *view = (UIView *)tap.view;
    [view removeFromSuperview];
    self.linkage.isRest = YES;
}

// 单选
- (void)removeContainModel:(YLBuyConditionModel *)model {
    for (YLBuyConditionModel *model1 in self.selectParams) {
        if ([model1.key isEqualToString:model.key]) {
            [self.selectParams removeObject:model1];
            NSLog(@"移除相同的条件");
            break;
        }
    }
}

// 多选
#pragma mark YLTitleLinkageView代理方法
- (void)linkageWithIndex:(NSInteger)index {
    
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    //    cover.backgroundColor = [UIColor clearColor];
    cover.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [cover addGestureRecognizer:tap];
    [keyWindow addSubview:cover];
    CGFloat viewY = 64 + 50;
    __weak typeof(self) weakSelf = self;
    
    if (index == 0) {
        self.linkage.isChange = YES;
        NSLog(@"-----------排序-----------");
        self.sortView = [[YLSortView alloc] initWithFrame:CGRectMake(0, viewY, YLScreenWidth, 230)];
        self.sortView.models = self.sortModels;
        self.sortView.sortViewBlock = ^(NSArray *sortModels) {
            [cover removeFromSuperview];
            weakSelf.sortModels = [NSMutableArray arrayWithArray:sortModels];
            weakSelf.linkage.isRest = YES;
            for (YLBuyConditionModel *model in weakSelf.sortModels) {
                if (model.isSelect) {
                    NSLog(@"weakSelf.model:%@", model.title);
                    [weakSelf removeContainModel:model];
                    [weakSelf.selectParams addObject:model];
                }
            }
            [weakSelf showConditionParamView];
        };
        [cover addSubview:self.sortView];
    } else if (index == 1) {
        [cover removeFromSuperview];
        NSLog(@"-----------品牌-----------");
        YLBrandController *brand = [[YLBrandController alloc] init];
        brand.buyBrandBlock = ^(NSString *brand, NSString *series) {
            YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
            model.title = brand;
            model.detail = brand;
            model.param = brand;
            model.isSelect = YES;
            model.key = @"brand";
            weakSelf.brandModel = model;
            
            YLBuyConditionModel *model1 = [[YLBuyConditionModel alloc] init];
            model1.title = series;
            model1.detail = series;
            model1.param = series;
            model1.isSelect = YES;
            model1.key = @"series";
            weakSelf.seriesModel = model1;
            
            
            [weakSelf removeContainModel:weakSelf.brandModel];
            [weakSelf removeContainModel:weakSelf.seriesModel];
            [weakSelf.selectParams addObject:weakSelf.brandModel];
            [weakSelf.selectParams addObject:weakSelf.seriesModel];
            
            NSLog(@"%@", model.title);
            NSLog(@"%@", model1.title);
            NSLog(@"%@", weakSelf.brandModel.title);
            NSLog(@"%@", weakSelf.seriesModel.title);
            [weakSelf showConditionParamView];
        };
        [weakSelf.navigationController pushViewController:brand animated:YES];
    } else if (index == 2) {
        self.linkage.isChange = YES;
        NSLog(@"-----------价格-----------");
        self.customPrice = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, viewY, YLScreenWidth, 130 + 95)];
        self.customPrice.models = self.priceModels;
        self.customPrice.customPriceBlock = ^(NSArray *priceModels) {
            [cover removeFromSuperview];
            weakSelf.linkage.isRest = YES;
            weakSelf.priceModels = [NSMutableArray arrayWithArray:priceModels];
            
            for (YLBuyConditionModel *model in weakSelf.priceModels) {
                if (model.isSelect) {
                    NSLog(@"%@", model.title);
                    [weakSelf removeContainModel:model];
                    [weakSelf.selectParams addObject:model];
                }
            }
            [weakSelf showConditionParamView];
        };
        self.customPrice.surePriceBlock = ^(NSString *lowPrice, NSString *highPrice) {
            [cover removeFromSuperview];
            weakSelf.linkage.isRest = YES;
            
//            // 判断最高价和最低价
//            if ([lowPrice integerValue] > [highPrice integerValue]) {
//                [NSString showMessage:@"最低价不能大于最高价"];
//            } else {
//
//            }
            if ([lowPrice isEqualToString:@""]) {
                lowPrice = @"0";
            }
            if ([highPrice isEqualToString:@""]) {
                highPrice = @"0";
            }
            
            // 将传回来价格改成模型
            NSString *title = [NSString stringWithFormat:@"%@-%@万", lowPrice, highPrice];
            NSString *param = [NSString stringWithFormat:@"%ldfgf%ld", [lowPrice integerValue] * 10000, [highPrice integerValue] * 10000];
            YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
            model.title = title;
            model.param = param;
            model.isSelect = YES;
            model.key = @"price";
            [weakSelf removeContainModel:model];
            [weakSelf.selectParams addObject:model];
            [weakSelf showConditionParamView];
        };
        [cover addSubview:self.customPrice];
    } else {
        self.linkage.isChange = YES;
        NSLog(@"-----------筛选-----------");
        NSArray *headerTitles = @[@"车型", @"车牌所在地", @"变速箱", @"车龄 (单位:年)", @"行驶里程 (单位:万公里)", @"排量 (单位:升)", @"排放标准", @"颜色", @"座位数", @"燃油类型", @"国别",  @"亮点配置"];
        CGFloat viewX = 0;
        CGFloat viewH = [UIScreen mainScreen].bounds.size.height;
        self.selectView = [[YLSelectView alloc] initWithFrame:CGRectMake(viewX, 0, YLScreenWidth - viewX, viewH)];
        self.selectView.headerTitles = headerTitles;
        self.selectView.multiSelectModels = self.multiSelectModels;
        // 重置筛选条件
        self.selectView.restAllConditionBlock = ^(NSArray *multiSelectModels) {
            // 替换原来的数组数据
            weakSelf.multiSelectModels = [NSMutableArray arrayWithArray:multiSelectModels];
            [cover removeFromSuperview];
            weakSelf.linkage.isRest = YES;
            NSLog(@"------------");
            NSMutableArray *temps = [NSMutableArray array];
            for (YLBuyConditionModel *model in weakSelf.selectParams) {
                if (!model.isSelect) {
                    [temps addObject:model];
                }
            }
            [weakSelf.selectParams removeObjectsInArray:temps];
            [weakSelf showConditionParamView];
        };
        // 确定筛选条件
        self.selectView.sureBlock = ^(NSArray *multiSelectModels) {
            // 替换原来的数组数据
            weakSelf.multiSelectModels = [NSMutableArray arrayWithArray:multiSelectModels];
            [cover removeFromSuperview];
            weakSelf.linkage.isRest = YES;
            
            // 先判断数组里面是否包含有已经取消的条件
            NSMutableArray *temps = [NSMutableArray array];
            for (YLBuyConditionModel *model in weakSelf.selectParams) {
                if (!model.isSelect) {
                    [temps addObject:model];
                }
            }
            [weakSelf.selectParams removeObjectsInArray:temps];
            NSLog(@"------------");
            for (NSInteger i = 0; i < weakSelf.multiSelectModels.count; i++) {
                NSArray *arr = multiSelectModels[i];
                for (YLBuyConditionModel *model in arr) {
                    if (model.isSelect) {
                        NSLog(@"%@", model.title);
                        if (![weakSelf.selectParams containsObject:model]) {
                            [weakSelf.selectParams addObject:model];
                        }
                    }
                }
            }
            [weakSelf showConditionParamView];
        };
        [cover addSubview:self.selectView];
    }
}

#pragma mark conditionParamView代理
- (void)paramViewRemoveWithIndex:(NSInteger)index {
    NSLog(@"%@", self.selectParams);
    // 将点击的条件删除
    [self.selectParams removeObjectAtIndex:index];
    [self showConditionParamView];
}

- (void)paramViewRemoveAllObject {
    [self.selectParams removeAllObjects];
    [self showConditionParamView];
}

#pragma mark tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommends.count;
}

- (YLBuyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyTableViewCell *cell = [YLBuyTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLBuyCellFrame *cellFrame = self.recommends[indexPath.row];
    cell.cellFrame = cellFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyCellFrame *cellFrame = self.recommends[indexPath.row];
    YLDetailController *detailVc = [[YLDetailController alloc] init];
    detailVc.model = cellFrame.model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyCellFrame *cell = self.recommends[indexPath.row];
    return cell.cellHeight;
}

#pragma mark setter
// 外部传来的参数
- (void)setParamModel:(YLBuyConditionModel *)paramModel {
    _paramModel = paramModel;
    NSLog(@"%@", paramModel);
    
    [self restSelectParamModels];
    if (paramModel.title) { // 传过来的模型有值才加入到数组中
        [self.selectParams addObject:paramModel];
    }
    [self showConditionParamView];
}

#pragma mark getter
- (NSMutableArray *)sortModels {
    if (!_sortModels) {
        _sortModels = [NSMutableArray array];
    }
    return _sortModels;
}

- (NSMutableArray *)priceModels {
    if (!_priceModels) {
        _priceModels = [NSMutableArray array];
    }
    return _priceModels;
}

- (NSMutableArray *)multiSelectModels {
    if (!_multiSelectModels) {
        _multiSelectModels = [NSMutableArray array];
    }
    return _multiSelectModels;
}

- (NSMutableArray *)selectParams {
    if (!_selectParams) {
        _selectParams = [NSMutableArray array];
    }
    return _selectParams;
}

- (NSMutableArray *)selectViewSelectParams {
    if (!_selectViewSelectParams) {
        _selectViewSelectParams = [NSMutableArray array];
    }
    return _selectViewSelectParams;
}

- (YLNoneView *)noneView {
    
    if (!_noneView) {
        _noneView = [[YLNoneView alloc] initWithFrame:CGRectMake(0, 50 + 50, YLScreenWidth, YLScreenHeight)];
        _noneView.title = @"暂无搜索记录";
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor whiteColor];
    }
    return _noneView;
}
- (NSMutableArray *)recommends {
    
    if (!_recommends) {
        _recommends = [NSMutableArray array];
    }
    return _recommends;
}

- (NSMutableDictionary *)selectParam {
    if (!_selectParam) {
        _selectParam = [NSMutableDictionary dictionary];
    }
    return _selectParam;
}
@end
