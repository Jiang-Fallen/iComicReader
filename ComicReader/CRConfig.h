//
//  CRConfig.h
//  ComicReader
//
//  Created by M Jiang on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#ifndef CRConfig_h
#define CRConfig_h

#define kWindow [(AppDelegate *)[[UIApplication sharedApplication] delegate] window]

#define IOS11_OR_LATER_SPACE(par) \
({\
float space = 0.0;\
if (@available(iOS 11.0, *))\
space = par;\
(space);\
})

#define DD_TOP_SPACE IOS11_OR_LATER_SPACE(kWindow.safeAreaInsets.top)
#define DD_TOP_ACTIVE_SPACE IOS11_OR_LATER_SPACE(MAX(0, kWindow.safeAreaInsets.top-20))
#define DD_BOTTOM_SPACE IOS11_OR_LATER_SPACE(kWindow.safeAreaInsets.bottom)

#endif /* CRConfig_h */
