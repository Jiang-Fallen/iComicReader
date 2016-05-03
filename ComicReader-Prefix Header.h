

#define kMyComicCell @"comicCell"
#define kMyComicImageWidth  138.0
#define kMyComicCellHeight 186.0

#define kSpace 5.0

#define kScreen320Scale kScreenWidth/320.0
#define kScreen375Scale kScreenWidth/375.0

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kHeaderHeight  kScreenWidth/375.0 * 235.0
#define kTitleListWidth kScreen320Scale * 190.0
#define kListLiftBar kScreen320Scale * 30
#define kListLiftBarTitle kScreen320Scale * 17.0

#define kHeaderScrollLabelHeight kScreen320Scale * 27.0
#define kHeaderScrollLabelWidth kScreen320Scale * 250.0

#define kNavicationBarHeigth 44.0
#define kStatusBarHeight 20.0
#define kToolBarHeight 49.0
#define kNavicationBarAndStatusBar 64.0

#define kMoveScale 0.4

#define kCellMinHeight kScreen320Scale * 55.0
#define kCellMaxHeight kScreen320Scale * 160.0

#define kRequestURL @"http://mhjk.1391.com/comic"
#define kGetProad @"getproad"
#define kGetalbumlist @"getalbumlist"
#define kComicslist_v2 @"comicslist_v2"
#define kAppVersionName @"appVersionName=2.4.7"
#define kPlatformtype @"platformtype=2"
#define kChannelId @"channelId=appstore"
#define kChannelid @"channelid=appstore"
#define kMobileModel @"mobileModel"
#define kAdgroupid @"adgroupid=4"
#define kMobileModel @"mobileModel"
#define kOsVersionCode @"osVersionCode"
#define kDeviceInfo

//http://112.124.96.190:9090/manhuakong4yuansen0520/ComicHandle.ashx?method=catalogs
//new  URL
#define kNewRequestURL @"http://112.124.96.190:9090/manhuakong4yuansen0520/ComicHandle.ashx"
#define kNewTitleMethod @"catalogs"
#define kNewListContentDayMethod @"dailyupdate"
#define kNewListContentHotMethod @"recommend"
#define kNewListContentMethod @"booklist"

//http://mhjk.1391.com/comic/getproad?appVersionName=2.4.7&mobileModel=iPhone4,1&osVersionCode=7.1.1&channelid=appstore&channelId=appstore&platformtype=2&adgroupid=4
//platformtype=2&channelId=tongbu&appVersionName=2.4.0&mobileModel=iPod5,1&osVersionCode=7.1.1&channelid=tongbu
//appVersionName=2.4.0&mobileModel=iPod5,1&osVersionCode=7.1.1&channelid=tongbu&channelId=tongbu&platformtype=2&adgroupid=4
//http://mhjk.1391.com/comic/comicslist_v2?channelId=manhuadao&appVersionName=2.4.2&mobileModel=iPod5,1&osVersionCode=7.1.1

#define kHeaderModelIdentifier @"headerModelIdentifier"
#define kListModelIdentifier @"listModelIdentifier"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#import "Masonry.h"
#import "UIView+JFFrame.h"
#import "UIImageView+WebCache.h"
#import "AFNetWorking.h"
#import "KVNProgress.h"
#import "JFJumpToControllerManager.h"

