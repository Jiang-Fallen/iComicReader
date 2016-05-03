//
//  ComicBookInfoContextModel.h
//  ComicReader
//
//  Created by Jiang on 5/22/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ComicBookInfoContextModel : NSManagedObject

@property (nonatomic, retain) NSNumber * bookID;
@property (nonatomic, retain) NSNumber * bookState;
@property (nonatomic, retain) NSString * bookIconOtherURL;
@property (nonatomic, retain) NSString * bookUpdateSection;
@property (nonatomic, retain) NSString * bookName;

@end
