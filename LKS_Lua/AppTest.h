//
//  AppTest.h
//  LKS_Lua
//
//  Created by Sơn Lê Khắc on 4/6/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "LuaBridge.h"

@interface AppTest : LuaBridge
{
    
}
@property(nonatomic,strong)NSMutableDictionary *rootObject;
+(AppTest*)ShareInstall;


-(void)CallLuaFN:(NSString*)functionName;
-(void)CreateObjectWithClass:(NSString*)strClassName ObjectName:(NSString*)objName;
-(void)SetFMForObject:(NSString*)strObjectName FunctionName:(NSString*)strFunction andValue:(NSString*)strsend;
@end
