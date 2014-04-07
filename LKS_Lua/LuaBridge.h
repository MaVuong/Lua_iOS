//
//  LuaBridge.h
//  LKS_Lua
//
//  Created by Sơn Lê Khắc on 4/6/14.
//  Copyright (c) 2014 Sơn Lê Khắc. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#define  df_pathLua @"/Users/lekhacson/GitHubSource/Lua_iOS/L_source/test1.lua"
#define fn_to_cString(s) ([s UTF8String])
@interface LuaBridge : NSObject{
    lua_State *L;
}
/**
 **Hàm hệ thống, không cần biết làm gì
 **/
-(void)LuaRunfunctionWithHTMLString:(NSString*)strhtml FunctionCall:(NSString*)functionName;
- (void)registerFunction:(lua_CFunction)function withName:(NSString *)name ;

/**
 **Cách sử dụng là để Object CutHTML này vào trong properties của Appdelegate và chỉ cần khởi tạo 1 lần
 **/
//+(LuaBridge*)ShareInstall;
@end
