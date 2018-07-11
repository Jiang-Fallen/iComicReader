//
//  JFComicBookReaderController.m
//  ComicReader
//
//  Created by Mr_J on 16/5/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "JFComicBookReaderController.h"
#import "JFComicShowImageContentCell.h"
#import "JFComicReaderBookModel.h"

@interface JFComicBookReaderController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) JFComicReaderBookModel *contentModel;

@end

static NSString *cellIdentifier = @"JFComicShowImageContentCellIdentifier";
@implementation JFComicBookReaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initSubViews{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.contentCollectionView.collectionViewLayout;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"JFComicShowImageContentCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)requestData{
    if (!_bookID) {
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"未找到相关漫画!",
                                               KVNProgressViewParameterFullScreen: @(NO)}];
        return;
    }
    NSString *headerURLString = @"http://api.kuaikanmanhua.com/v1/comics/";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", headerURLString, _bookID];
    
    __unsafe_unretained typeof(self) p = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        p.contentModel = [[JFComicReaderBookModel alloc]initWithDictionary:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"网络不给力！",
                                               KVNProgressViewParameterFullScreen: @(NO)}];
    }];
}

- (void)setContentModel:(JFComicReaderBookModel *)contentModel{
    _contentModel = contentModel;
    [self.contentCollectionView reloadData];
}

#pragma mark - delegate
#pragma mark collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    [collectionView.collectionViewLayout invalidateLayout];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicShowImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    JFComicReaderBookContentModel *model = _contentModel.images[indexPath.row];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (image && !model.contentHeight) {
             model.contentHeight = @((kScreenWidth - 10)/ image.size.width * image.size.height);
             [CATransaction begin];
             [CATransaction setDisableActions:YES];
             @try{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
             }
             @catch (NSException *exception){
                 
             }
             [CATransaction commit];
         }
     }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    static CGFloat height = 250 * (320.0/ 375.0);
    JFComicReaderBookContentModel *model = _contentModel.images[indexPath.row];
    if (model.contentHeight) {
        height = model.contentHeight.floatValue;
    }
    return CGSizeMake(kScreenWidth - 10, floorf(height));
}

@end
