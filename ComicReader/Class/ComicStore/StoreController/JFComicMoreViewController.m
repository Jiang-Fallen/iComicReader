//
//  JFComicMoreViewController.m
//  ComicReader
//
//  Created by Mr_J on 16/5/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicMoreViewController.h"
#import "UIScrollView+UzysAnimatedGifLoadMore.h"
#import "JFComicShowContentContentCell.h"
#import "JFComicSectionsListViewController.h"
#import "ListContentModel.h"

@interface JFComicMoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _pageIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) NSMutableArray *contentModelArray;

@end

static NSString *showContentCellIdentifier = @"JFComicShowContentContentCellIdentifier";
@implementation JFComicMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (instancetype)initWithRequestSearch:(BOOL)isSearch
{
    self = [super init];
    if (self) {
        _isSearch = isSearch;
    }
    return self;
}

- (void)initSubViews{
    [_contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicShowContentContentCell" bundle:nil]
             forCellWithReuseIdentifier:showContentCellIdentifier];
    
    __unsafe_unretained typeof(self) p = self;
    [_contentCollectionView addLoadMoreActionHandler:^{
         [p refreshAddAction];
     } ProgressImagesGifName:@"farmtruck@2x.gif"
     LoadingImagesGifName:@"nevertoolate@2x.gif"
     ProgressScrollThreshold:30
     LoadingImageFrameRate:30];
}

- (void)refreshAddAction{
    _pageIndex = _contentModelArray.count;
    [self requestData];
}

- (void)requestData{
    NSString *urlString = nil;
    NSDictionary *parameter = nil;
    if (_isSearch) {
        urlString = @"http://api.kuaikanmanhua.com/v1/topics/search";
        parameter = @{@"limit": @20,
                      @"offset": @(_pageIndex),
                      @"keyword": _requestType};
    }else{
        urlString = @"http://api.kuaikanmanhua.com/v1/topics";
        parameter = @{@"limit": @20,
                      @"offset": @(_pageIndex),
                      @"tag": _requestType};
    }
    
    if (_pageIndex == 0) [KVNProgress show];
    __unsafe_unretained typeof(self) p = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [p.contentCollectionView stopLoadMoreAnimation];
        [KVNProgress dismiss];
        NSMutableArray *array = [ListContentModel modelArrayForDataArray:responseObject[@"data"][@"topics"]];
        if (_pageIndex == 0) {
            if (array.count == 0 && _isSearch) {
                [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"没有搜到内容",
                                                       KVNProgressViewParameterFullScreen: @(NO)}];
            }
            p.contentModelArray = array;
        }else{
            [p.contentModelArray addObjectsFromArray:array];
            [p.contentCollectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KVNProgress dismiss];
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"网络不给力！",
                                               KVNProgressViewParameterFullScreen: @(NO)}];
    }];
}

- (void)setContentModelArray:(NSMutableArray *)contentModelArray{
    _contentModelArray = contentModelArray;
    [self.contentCollectionView reloadData];
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth, 90 * kScreen375Scale);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicShowContentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:showContentCellIdentifier forIndexPath:indexPath];
    cell.contentModel = _contentModelArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ListContentModel *model = self.contentModelArray[indexPath.row];
    JFComicSectionsListViewController *controller = [[JFComicSectionsListViewController alloc]init];
    controller.bookID = model.aID;
    [[JFJumpToControllerManager shared].navigation pushViewController:controller animated:YES];
}

@end
