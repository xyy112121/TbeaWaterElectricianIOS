//
//  AddInterface.h
//  Ccwbnewclient
//
//  Created by 谢 毅 on 13-10-23.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <UIKit/UIKit.h>
@interface AddInterface : NSObject
{
    
}
+(BOOL)judgeislogin;
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
+(NSString*)DataTOjsonString:(id)object;
+ (NSString *) md5:(NSString *)str;
+(NSString *)intervalSinceNow: (NSString *) theDate;
+(NSString *)returnnowdate;
+(NSString *)returnnowdatefromstr:(NSString *)str;
+ (BOOL) IsEnable3G;
+ (BOOL) IsEnableWIFI;
+(NSString *)RandomId:(int)numwei;
+(BOOL)isValidateEmail:(NSString *)email;
+ (NSInteger)OSVersion;
+(NSString *)timeformat:(NSString *)datatime;
+(NSString *)returnnowdate3:(NSString *)strdate;
+(BOOL)timechar: (NSString *)theDate;
+(BOOL) isValidateMobile:(NSString *)mobile;
+ (UIImage *)clipImageWithScaleWithsize:(CGSize)asize Image:(UIImage *)image;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+(float)folderSizeAtPath:(NSString *)path;
+(void)clearCache:(NSString *)path;
+(BOOL) isValidatenumber:(NSString *)mobile;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSMutableAttributedString *)getlabelspage:(NSString *)str Space:(float)space;
//获取str的size
+(CGSize) getlablesize:(NSString *)str Fwidth:(float)fwidth Fheight:(float)fheight Sfont:(UIFont *)sfont;
@end
