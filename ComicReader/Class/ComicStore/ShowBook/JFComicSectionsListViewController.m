//
//  JFComicSectionsListViewController.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicSectionsListViewController.h"
#import "JFComicShowBookLayout.h"
#import "JFComicShowContentContentCell.h"
#import "JFShowContentCollectionViewCell.h"
#import "JFComicHeaderReusableView.h"
#import "JFComicSelectedReusableView.h"
#import "JFComicBookReaderController.h"
#import "ListContentModel.h"

@interface JFComicSectionsListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JFComicSelectedReusableViewDelegate>
{
    BOOL _sortUP;
    BOOL _isShowContent;
}
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) ListContentModel *contentModel;

@end

static NSString *cellIdentifier = @"JFComicShowContentContentCellIdentifier";
static NSString *contentIdentifier = @"JFShowContentCollectionViewCellIdentifier";
static NSString *headerIdentifier = @"JFComicHeaderReusableViewIdentifier";
static NSString *selectedIdentifier = @"JFComicSelectedReusableViewIdentifier";
@implementation JFComicSectionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self requestData];
}

- (void)initSubViews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    JFComicShowBookLayout *layout = [[JFComicShowBookLayout alloc]initWithAnimatedHeight:200 * kScreen320Scale];
    layout.itemSize = CGSizeMake(kScreenWidth, 90 * kScreen375Scale);
    layout.minimumLineSpacing = 0;
    self.contentCollectionView.collectionViewLayout = layout;
    
    self.contentCollectionView.alwaysBounceVertical = YES;
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicShowContentContentCell" bundle:nil]
                 forCellWithReuseIdentifier:cellIdentifier];
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFShowContentCollectionViewCell" bundle:nil]
                 forCellWithReuseIdentifier:contentIdentifier];
    
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicHeaderReusableView" bundle:nil]
                 forSupplementaryViewOfKind:JFHeaderKind
                        withReuseIdentifier:headerIdentifier];
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicSelectedReusableView" bundle:nil]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:selectedIdentifier];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)requestData{
    if (!_bookID) {
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"未找到相关漫画!",
                                              KVNProgressViewParameterFullScreen: @(NO)}];
        return;
    }
    NSString *headerURLString = @"http://api.kuaikanmanhua.com/v1/topics/";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", headerURLString, _bookID];
    
    NSDictionary *parameter = @{@"sort": @(_sortUP)};
    __unsafe_unretained typeof(self) p = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [KVNProgress dismiss];
        p.contentModel = [[ListContentModel alloc]initWithDictionary:responseObject[@"data"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _sortUP = !_sortUP;
        [KVNProgress dismiss];
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"网络不给力！",
                                               KVNProgressViewParameterFullScreen: @(NO)}];
    }];
}

- (void)setContentModel:(ListContentModel *)contentModel{
    _contentModel = contentModel;
    _contentModel.sortUP = _sortUP;
    [self.contentCollectionView reloadData];
}

#pragma mark - delegate
#pragma mark collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _isShowContent? 1: _contentModel.comics.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShowContent) {
        return CGSizeMake(kScreenWidth, kScreenHeight - 75);
    }else{
        return CGSizeMake(kScreenWidth, 90 * kScreen375Scale);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *returnCell = nil;
    if (_isShowContent) {
        JFShowContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentIdentifier forIndexPath:indexPath];
        cell.contentLabel.text = _contentModel.aDescription;
        returnCell = cell;
    }else{
        JFComicShowContentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.contentModel = _contentModel.comics[indexPath.row];
        cell.likeButton.hidden = NO;
        returnCell = cell;
    }
    return returnCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:JFHeaderKind]) {
        JFComicHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:headerIdentifier
                                                                                          forIndexPath:indexPath];
        headerView.contentModel = _contentModel;
        headerView.imageHeight = 200 * kScreen320Scale;
        reusableView = headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        JFComicSelectedReusableView *selectedView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                       withReuseIdentifier:selectedIdentifier
                                                                                              forIndexPath:indexPath];
        selectedView.delegate = self;
        selectedView.sortButton.selected = _sortUP;
        reusableView = selectedView;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 75);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShowContent) return;
    JFComicBookReaderController *controller = [[JFComicBookReaderController alloc]init];
    ListContentModel *model = _contentModel.comics[indexPath.row];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    controller.title = model.title;
    controller.bookID = model.aID;
    [[JFJumpToControllerManager shared].navigation pushViewController:controller animated:YES];
}

#pragma mark header
- (void)comicHeaderSelectedOfIndex:(NSInteger)index{
    _isShowContent = index == 0;
    [self.contentCollectionView reloadData];
}

- (void)comicHeaderSortAction:(UIButton *)sender{
    _sortUP = !_sortUP;
    [KVNProgress show];
    [self requestData];
}

@end
