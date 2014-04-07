//
//  LKS_LoadData.h
//  LuaTest
//
//  Created by Sơn Lê Khắc on 4/4/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKS_LoadData : NSObject
{
    
}
@property(nonatomic,retain)NSString *urlRequest;
@property(nonatomic,retain)NSString *strnextFunc;
@property(nonatomic,retain)NSString *content_type;
@property(nonatomic,retain)NSString *bodyData;
@property(nonatomic,retain)NSString *UserAgent;
@property(nonatomic,assign)BOOL POST;
-(void)startLoadData;
@end
