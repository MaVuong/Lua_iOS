//
//  LuaBridge.m
//  LKS_Lua
//
//  Created by Sơn Lê Khắc on 4/6/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import "LuaBridge.h"
#import "LKS_LoadData.h"

int lks_HTTPRequest_GET(lua_State *L_input){
    NSString *strurl_=[NSString stringWithUTF8String:lua_tostring(L_input, 1)];
    NSString *strnextFunc_=[NSString stringWithUTF8String:lua_tostring(L_input, 2)];
    LKS_LoadData *loaddata=[[LKS_LoadData alloc] init];
    loaddata.urlRequest=strurl_;
    loaddata.strnextFunc=strnextFunc_;
    loaddata.POST=NO;
    [loaddata startLoadData];
    return 0;
}
int lks_HTTPRequest_POST(lua_State *L_input){
    NSString *strurl_=[NSString stringWithUTF8String:lua_tostring(L_input, 1)];
    NSString *strnextFunc_=[NSString stringWithUTF8String:lua_tostring(L_input, 2)];
    NSString *strBodyData_=[NSString stringWithUTF8String:lua_tostring(L_input, 3)];
    NSString *strContentType_=[NSString stringWithUTF8String:lua_tostring(L_input, 4)];
    
    LKS_LoadData *loaddata=[[LKS_LoadData alloc] init];
    loaddata.urlRequest=strurl_;
    loaddata.strnextFunc=strnextFunc_;
    loaddata.bodyData=strBodyData_;
    loaddata.content_type=strContentType_;
    loaddata.POST=YES;
    [loaddata startLoadData];
    return 0;
    
    
    return 0;
}

@implementation LuaBridge



//LuaBridge *lbridge;
//+(LuaBridge*)ShareInstall{
//    if (lbridge==nil) {
//        lbridge=[[LuaBridge alloc] init];
//        NSLog(@"Khoi tao ham cat html");
//    }
//    return lbridge;
//}
-(void)LoadCodeGlobal{
    
    [self performSelectorInBackground:@selector(runCodeFromFileWithPath) withObject:nil];
    
}
- (void)runCodeFromFileWithPath {
    NSString *strcontentfile=[NSString stringWithContentsOfFile:df_pathLua encoding:NSUTF8StringEncoding error:nil];
    BOOL test=YES;
    if (!test) {
        strcontentfile=[NSString stringWithContentsOfURL:[NSURL URLWithString:df_pathLua] encoding:NSUTF8StringEncoding error:nil];
    }
    [self performSelectorOnMainThread:@selector(updateToMain:) withObject:strcontentfile waitUntilDone:YES];
    //NSLog(@"strcontentfile:%@",strcontentfile);
    
    
}
-(void)ShowError:(NSString*)strmessage{
    UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Script Compile Error" message:strmessage delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
    [alertview show];
}
-(void)updateToMain:(NSString *)strSend{
    if (strSend.length<10) {
        return;
    }
    int error = luaL_loadstring(L, [strSend UTF8String]);
    if (error) {
        [self ShowError:[NSString stringWithFormat:@"Cannot compile Lua file: %s", lua_tostring(L, -1)]];
        return;
    }
    error = lua_pcall(L, 0, 0, 0);
    if (error) {
        [self ShowError:[NSString stringWithFormat:@"Cannot run Lua code: %s", lua_tostring(L, -1)]];
        return;
    }
    NSLog(@"Finish Update code Online");
    
    
   // [self registerFunction:lks_finishCut withName:@"lks_ketquacut"];
    [self registerFunction:lks_HTTPRequest_GET withName:@"lks_fnGetHTTP"]; //lks_fnPostHTTP
    [self registerFunction:lks_HTTPRequest_POST withName:@"lks_fnPostHTTP"];
    
    {
        lua_getglobal(L,[@"LKS_DidFinishLoad" UTF8String]);
        lua_pushstring(L, [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] UTF8String]);
        int error = lua_pcall(L, 1, 0, 0);
        if (0!=error) {
            NSLog(@"Error Load LKS_DidFinishLoad");
        }
        
    }
}
- (void)registerFunction:(lua_CFunction)function withName:(NSString *)name {
    lua_register(L, [name UTF8String], function);
}
-(id)init{
    if (self=[super init]) {
         L = luaL_newstate();
        luaL_openlibs(L);
        lua_settop(L, 0);
        [self LoadCodeGlobal];
    }
    return self;
}

#pragma mark ---doFunctionLua

-(void)LuaRunfunctionWithHTMLString:(NSString*)strhtml FunctionCall:(NSString*)functionName{
    if (functionName.length==0||[functionName isEqualToString:@"khonglamgica"]) {
        NSLog(@"khonglamgica");
        return;
    }
    lua_getglobal(L,[functionName UTF8String]);//LKS_F_L
    lua_pushstring(L, [strhtml UTF8String]);
    int error = lua_pcall(L, 1, 0, 0);
    
    if (0!=error) {
        [self ShowError:[NSString stringWithFormat:@"Error Syntax:%@",functionName]];
        return;
    }
}





@end
