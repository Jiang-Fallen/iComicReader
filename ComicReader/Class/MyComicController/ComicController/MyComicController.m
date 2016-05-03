//
//  MyComicController.m
//  ComicReader
//
//  Created by Jiang on 14/12/9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "MyComicController.h"
#import "ComicBookInfoContextModel.h"
#import "AppDelegate.h"
#import "KVNProgress.h"

@interface MyComicController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) NSArray *modelArray;

@end

static NSString *cellIdentifier = @"ComicListContentCellIdentifier";
@implementation MyComicController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back_day.png"]];
    self.contentCollectionView.backgroundColor = color;
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"ComicStoreListRowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    self.contentCollectionView.alwaysBounceVertical = YES;
    self.contentCollectionView.contentInset = UIEdgeInsetsMake(5.0, 15, 0, 15);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
    self.tabBarController.tabBar.hidden = NO;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ComicBookInfoContextModel"];
    self.modelArray = [context executeFetchRequest:request error:nil];
    if (!_modelArray || _modelArray.count == 0) {
        [KVNProgress showErrorWithParameters:@{KVNProgressViewParameterStatus: @"你还没有收藏过漫画哦！",
                                               KVNProgressViewParameterFullScreen: @(NO)}];
    }
}

- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [self.contentCollectionView reloadData];
}

#pragma mark - 代理数据源方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    ComicStoreListRowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ComicBookInfoContextModel *model = self.modelArray[indexPath.row];
//    NewStoreContentListModel *bookModel = [[NewStoreContentListModel alloc]init];
//    bookModel.BookID = model.bookID;
//    bookModel.BookIconOtherURL = model.bookIconOtherURL;
//    bookModel.BookState = model.bookState;
//    bookModel.BookName = model.bookName;
//    bookModel.BookUpdateSection = model.bookUpdateSection;
//    cell.listRowContentModel = bookModel;
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 30)/3;
    return CGSizeMake(width, 175 * width/130.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

@end
