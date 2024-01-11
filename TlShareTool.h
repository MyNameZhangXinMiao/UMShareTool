//
//  TlShareTool.h
//  TlProject
//
//  Created by Tl on 2024/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 回调
 *
 *  @param result 表示回调的结果
 *  @param error  表示回调的错误码
 */
typedef void (^TlShareCompletionHandler)(id result, NSError *error);
@interface TlShareTool : NSObject


#pragma mark - 分享文本
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
                       withText:(NSString *)text
                 withCompletion:(TlShareCompletionHandler)completion;

#pragma mark - 分享小程序
+ (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType
                                 Title:(NSString *)title
                                 Descr:(NSString *)descr
                             ThumImage:(UIImage *)thumImage
                            WebpageUrl:(NSString *)webpageUrl
                              UserName:(NSString *)userName
                                  Path:(NSString *)path
                           HdImageData:(NSData *)hdImageData
                            Completion:(TlShareCompletionHandler)completion;

#pragma mark - 分享图片
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
                           Thumb:(id)thumb
                           Image:(id)image
                      Completion:(TlShareCompletionHandler)completion;

#pragma mark - 分享多张图片
+ (void)shareMultiImageToPlatformType:(UMSocialPlatformType)platformType
                                 Text:(NSString *)text
                      ShareImageArray:(NSArray *)shareImageArray
                           Completion:(TlShareCompletionHandler)completion;

#pragma mark - 分享网络图片
+ (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
                              Thumb:(id)thumb
                              Image:(id)image
                         Completion:(TlShareCompletionHandler)completion;

#pragma mark - 分享图片和文字
+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
                                  Title:(NSString *)title
                                  Thumb:(UIImage *)thumb
                             ShareImage:(UIImage *)shareImage
                             Completion:(TlShareCompletionHandler)completion;

#pragma mark - 网页分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             Title:(NSString *)title
                             Descr:(NSString *)descr
                               Url:(NSString *)url
                             Thumb:(id)thumb
                        Completion:(TlShareCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
