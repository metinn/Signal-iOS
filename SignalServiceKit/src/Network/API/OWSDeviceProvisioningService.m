//
//  Copyright (c) 2021 Open Whisper Systems. All rights reserved.
//

#import <SignalServiceKit/OWSDeviceProvisioningService.h>
#import <SignalServiceKit/OWSRequestFactory.h>
#import <SignalServiceKit/SignalServiceKit-Swift.h>
#import <SignalServiceKit/TSNetworkManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface OWSDeviceProvisioningService ()

@property (nonatomic, readonly) TSNetworkManager *networkManager;

@end

@implementation OWSDeviceProvisioningService

- (instancetype)initWithNetworkManager:(TSNetworkManager *)networkManager
{
    self = [super init];
    if (!self) {
        return self;
    }

    _networkManager = networkManager;

    return self;
}

- (instancetype)init
{
    return [self initWithNetworkManager:[TSNetworkManager shared]];
}

- (void)provisionWithMessageBody:(NSData *)messageBody
               ephemeralDeviceId:(NSString *)deviceId
                         success:(void (^)(void))successCallback
                         failure:(void (^)(NSError *))failureCallback
{
    TSRequest *request =
        [OWSRequestFactory deviceProvisioningRequestWithMessageBody:messageBody ephemeralDeviceId:deviceId];
    [self.networkManager makeRequest:request
        success:^(NSURLSessionDataTask *task, id responseObject) {
            OWSLogVerbose(@"Provisioning request succeeded");
            successCallback();
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (!IsNetworkConnectivityFailure(error)) {
                OWSProdError([OWSAnalyticsEvents errorProvisioningRequestFailed]);
            }
            OWSLogVerbose(@"Provisioning request failed with error: %@", error);
            failureCallback(error);
        }];
}

@end

NS_ASSUME_NONNULL_END
