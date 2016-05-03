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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        p.contentModel = [[JFComicReaderBookModel alloc]initWithDictionary:responseObject[@"data"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFComicShowImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    JFComicReaderBookContentModel *model = _contentModel.images[indexPath.row];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (image) {
            model.contentHeight = @((kScreenWidth - 10)/ image.size.width * image.size.height);
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 193;
    JFComicReaderBookContentModel *model = _contentModel.images[indexPath.row];
    if (model.contentHeight) {
        height = model.contentHeight.floatValue;
    }
    return CGSizeMake(kScreenWidth - 10, height * kScreen375Scale);
}

@end
