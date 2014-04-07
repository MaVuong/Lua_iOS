//
//  LKS_LoadData.m
//  LuaTest
//
//  Created by Sơn Lê Khắc on 4/4/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "LKS_LoadData.h"
#import "LuaBridge.h"
@implementation LKS_LoadData{
    NSMutableData *_mulData;
}


-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}


-(void)startLoadData{
    if (self.POST) {
        NSURL *url = [NSURL URLWithString:self.urlRequest];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        if (self.content_type.length>1) {
            [request setValue:self.content_type forHTTPHeaderField:@"Content-Type"];
        }
        if (self.UserAgent.length>1) {
            [request setValue:self.UserAgent forHTTPHeaderField:@"User-Agent"];
        }
        
        NSData *datapost=[self.bodyData dataUsingEncoding:NSUTF8StringEncoding];
        [request setValue:[NSString stringWithFormat:@"%d", datapost.length] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:datapost];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [connection start];
    }else{
        [self performSelectorInBackground:@selector(BeginLoad_GET) withObject:nil];
    }
}

-(void)BeginLoad_GET{
    NSString *strhtmlcontent=[NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlRequest] encoding:NSUTF8StringEncoding error:nil];
    [self performSelectorOnMainThread:@selector(FinishLoad:) withObject:strhtmlcontent waitUntilDone:YES];
}
-(void)FinishLoad:(NSString*)strfinish{
    //LuaBridge *lbrd=[LuaBridge ShareInstall];
    //[lbrd LuaRunfunctionWithHTMLString:strfinish FunctionCall:self.strnextFunc];
}



#pragma mark DelegateURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Did Receive Response %@", response);
    _mulData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // NSLog(@"Did Receive Data %@", data);
    [_mulData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"error:%@",[error userInfo]);
    [self FinishLoad:[error description]];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString * tmpStr=[[NSString alloc] initWithData:_mulData encoding:NSUTF8StringEncoding];
    [self FinishLoad:tmpStr];
}








@end
