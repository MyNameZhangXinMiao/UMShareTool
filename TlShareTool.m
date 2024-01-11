//
//  TlShareTool.m
//  TlProject
//
//  Created by Tl on 2024/1/6.
//

#import "TlShareTool.h"

@implementation TlShareTool

+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType withText:(NSString *)text withCompletion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     */
}

+ (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title Descr:(NSString *)descr ThumImage:(UIImage *)thumImage WebpageUrl:(NSString *)webpageUrl UserName:(NSString *)userName Path:(NSString *)path HdImageData:(NSData *)hdImageData Completion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    shareObject.webpageUrl = webpageUrl;
    shareObject.userName = userName;
    shareObject.path = path;
    shareObject.hdImageData = hdImageData;
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     */
}

+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType Thumb:(id)thumb Image:(id)image Completion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = thumb;
    
    [shareObject setShareImage:image];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     [self alertWithError:error];
     */
}


+ (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}

+ (void)shareMultiImageToPlatformType:(UMSocialPlatformType)platformType Text:(NSString *)text ShareImageArray:(NSArray *)shareImageArray Completion:(nonnull TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = text;

    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    
    // @[UIImagePNGRepresentation([UIImage imageNamed:@"logo"]), UIImagePNGRepresentation([UIImage imageNamed:@"icon"]), UIImagePNGRepresentation([UIImage imageNamed:@"logo"]), [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"], [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"], [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"]]
    shareObject.shareImageArray = shareImageArray;;

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    
    /**
     if (error) {
         UMSocialLogInfo(@"************分享失败 %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     [self alertWithError:error];
     */
}

+ (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType Thumb:(id)thumb Image:(id)image Completion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = thumb;
    
    [shareObject setShareImage:image];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     [self alertWithError:error];
     */
}

+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title Thumb:(UIImage *)thumb ShareImage:(UIImage *)shareImage Completion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = title;
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    if (platformType == UMSocialPlatformType_Linkedin) {
        // linkedin仅支持URL图片
        shareObject.thumbImage = @"";
        [shareObject setShareImage:@""];
    } else {
        shareObject.thumbImage = thumb;
        shareObject.shareImage = thumb;
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     [self alertWithError:error];
     */
}

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title Descr:(NSString *)descr Url:(NSString *)url Thumb:(id)thumb Completion:(TlShareCompletionHandler)completion {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  thumb;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:completion];
    
    /**
     if (error) {
         UMSocialLogInfo(@"************Share fail with error %@*********",error);
     }else{
         if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
         }else{
             UMSocialLogInfo(@"response data is %@",data);
         }
     }
     [self alertWithError:error];
     */
}

@end
