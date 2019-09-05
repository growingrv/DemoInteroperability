//
//  UIImage+Category.h
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 02/08/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Category)
+ (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage degrees:(CGFloat)degrees;
@end

NS_ASSUME_NONNULL_END
