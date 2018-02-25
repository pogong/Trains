//
//  PGURLProtocol.m
//  DNS-Anti-Spoofing-Train
//
//  Created by Shendou on 2018/1/16.
//  Copyright © 2018年 Shendou. All rights reserved.
//

#import "PGURLProtocol.h"
#import <HappyDNS/HappyDNS.h>

static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface PGURLProtocol ()<NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (copy, nonatomic) NSString *hostname;

@end

@implementation PGURLProtocol

//step1
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
        return NO;
    }
    
    //http和https都会出现dns劫持情况，都需要处理//zc limit 1:scheme
    NSString *scheme = [[request URL] scheme];
    if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        // 判断请求是否为白名单//zc limit 2:domain name
        NSArray *whiteLists = @[@"baidu.com",@"qq.com",@"maps.googleapis.com",@"jianshu.com"];
        if (whiteLists && [whiteLists isKindOfClass:[NSArray class]]) {
            for (NSString *url in whiteLists) {
                if (request.URL.host && [request.URL.host hasSuffix:url]) {
                    return YES;
                }
            }
        }
    }
    
    return NO;//zc read:结果只代表PGURLProtocol处理request与否,与请求成功或是失败没有关系
}
//2
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}
//3
- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    self.hostname = self.request.URL.host;
    //打标签，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    // dns解析
    NSMutableURLRequest *request = [self.class replaceHostInRequset:mutableReqeust];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}
//4
+ (NSMutableURLRequest *)replaceHostInRequset:(NSMutableURLRequest *)request {
    if ([request.URL host].length == 0) {
        return request;
    }
    
    NSString *originUrlString = [request.URL absoluteString];
    NSString *originHostString = [request.URL host];
    NSRange hostRange = [originUrlString rangeOfString:originHostString];
    if (hostRange.location == NSNotFound) {//zc remain:这是无关细节,绝对地址匹配不到主机名,外围自然会报错,我们不用管
        return request;
    }
    
    //用HappyDNS 替换host
    NSMutableArray *array = [NSMutableArray array];
    /// 第一dns解析为114，第二解析才是系统dns
    [array addObject:[[QNResolver alloc] initWithAddress:@"114.114.115.115"]];
    [array addObject:[QNResolver systemResolver]];
    QNDnsManager *dnsManager = [[QNDnsManager alloc] init:array networkInfo:[QNNetworkInfo normal]];
    NSArray *queryArray = [dnsManager query:originHostString];
    if (queryArray && queryArray.count > 0) {
        NSString *ip = queryArray[0];
        if (ip && ip.length) {
            // 替换host
            NSString *urlString = [originUrlString stringByReplacingCharactersInRange:hostRange withString:ip];
            NSURL *url = [NSURL URLWithString:urlString];
            request.URL = url;
            
            [request setValue:originHostString forHTTPHeaderField:@"Host"];
        }
    }
    
    return request;
}

- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
    self.hostname = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

static inline SecTrustRef AFChangeHostForTrust(SecTrustRef trust, NSString * trustHostname)
{
    if ( ! trustHostname || [trustHostname isEqualToString:@""]) {
        return trust;
    }
    
    CFMutableArrayRef newTrustPolicies = CFArrayCreateMutable(
                                                              kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    
    SecPolicyRef sslPolicy = SecPolicyCreateSSL(true, (CFStringRef)trustHostname);
    
    CFArrayAppendValue(newTrustPolicies, sslPolicy);
    
    
#ifdef MAC_BACKWARDS_COMPATIBILITY
    /* This technique works in OS X (v10.5 and later) */
    
    SecTrustSetPolicies(trust, newTrustPolicies);
    CFRelease(oldTrustPolicies);
    
    return trust;
#else
    /* This technique works in iOS 2 and later, or
     OS X v10.7 and later */
    
    CFMutableArrayRef certificates = CFArrayCreateMutable(
                                                          kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    
    /* Copy the certificates from the original trust object */
    CFIndex count = SecTrustGetCertificateCount(trust);
    CFIndex i=0;
    for (i = 0; i < count; i++) {
        SecCertificateRef item = SecTrustGetCertificateAtIndex(trust, i);
        CFArrayAppendValue(certificates, item);
    }
    
    /* Create a new trust object */
    SecTrustRef newtrust = NULL;
    if (SecTrustCreateWithCertificates(certificates, newTrustPolicies, &newtrust) != errSecSuccess) {
        /* Probably a good spot to log something. */
        
        return NULL;
    }
    
    return newtrust;
#endif
}

//zc 根据https://github.com/AFNetworking/AFNetworking/issues/2954 改的
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;

        /* 添加可信任的域名,以支持:直接使用ip访问特定https服务器.
         Add trusted domain name to support: direct use of IP access specific HTTPS server.*/
        for (NSString * trustHostname  in @[@"baidu.com",@"qq.com",@"maps.googleapis.com",@"jianshu.com"]) {
            serverTrust =  AFChangeHostForTrust(serverTrust, trustHostname);
        }

        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        if ([challenge previousFailureCount] == 0) {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
}

@end

