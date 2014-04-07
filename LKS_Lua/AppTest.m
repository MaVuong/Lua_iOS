//
//  AppTest.m
//  LKS_Lua
//
//  Created by Sơn Lê Khắc on 4/6/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "AppTest.h"


int LKS_CreateObject(lua_State *L_input){
    NSString *clName=[NSString stringWithUTF8String:lua_tostring(L_input, 1)];
    NSString *objname=[NSString stringWithUTF8String:lua_tostring(L_input, 2)];
    [[AppTest ShareInstall] CreateObjectWithClass:clName ObjectName:objname];
    return 0;
}

int LKS_SetParameters(lua_State *L_input){
    NSString *objName=[NSString stringWithUTF8String:lua_tostring(L_input, 1)];
    NSString *fnName=[NSString stringWithUTF8String:lua_tostring(L_input, 2)];
    NSString *valuesend;
    if (lua_tostring(L_input, 3)) {
        valuesend=[NSString stringWithUTF8String:lua_tostring(L_input, 3)];
    }
    [[AppTest ShareInstall] SetFMForObject:objName FunctionName:fnName andValue:valuesend];
    
    return 0;
}

@implementation AppTest

AppTest *apptest;
+(AppTest*)ShareInstall{
    if (apptest==nil) {
        apptest=[[AppTest alloc] init];
        NSLog(@"Khoi tao ham cat apptest");
    }
    return apptest;
}


-(id)init{
    if (self=[super init]) {
        self.rootObject=[[NSMutableDictionary alloc] init];
        [self registerFunction:LKS_CreateObject withName:@"LKS_CreateObj"];
        [self registerFunction:LKS_SetParameters withName:@"LKS_SetPRM"];
        
        
                
    }
    return self;
}


-(void)CallLuaFN:(NSString*)functionName{
    
//    UIAlertView *alertview;
//    [alertview setTitle:@"AAC"];
//    [alertview setMessage:@"AA"];
//    [alertview addButtonWithTitle:@"Close"];
    
    lua_getglobal(L,[functionName UTF8String]);
    lua_pushnil(L);
    int error = lua_pcall(L, 1, 0, 0);
    
    if (0!=error) {
        NSLog(@"erorro");
        return;
    }
}

-(void)TestApp{
    [[UIApplication sharedApplication] delegate];
}

#pragma mark ---LUADELEGATE



-(void)CreateObjectWithClass:(NSString*)strClassName ObjectName:(NSString*)objName{
    id obj_=[[NSClassFromString(strClassName) alloc] init];
    [self.rootObject setObject:obj_ forKey:objName];
    
    
}

-(void)SetFMForObject:(NSString*)strObjectName FunctionName:(NSString*)strFunction andValue:(NSString*)strsend{
    id obj_=[self.rootObject objectForKey:strObjectName];
    SEL sl=NSSelectorFromString(strFunction);
    [obj_ performSelector:sl withObject:strsend];
}












@end













