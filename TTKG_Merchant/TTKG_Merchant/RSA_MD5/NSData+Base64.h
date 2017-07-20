//
//  NSData+Base64.h
//  RAS签名
//
//  Created by user on 16/7/6.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64) 
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end
