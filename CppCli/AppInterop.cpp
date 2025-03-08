///// Warning - this file is created by gen_interop.lua - do not edit. 2025-03-06 17:23:01 /////

#include <windows.h>
#include "luainterop.h"
#include "AppInterop.h"

using namespace System;
using namespace System::Collections::Generic;
using namespace Interop;

//============= C# => C functions .cpp =============//

//--------------------------------------------------------//
int Interop::Setup(int opt)
{
    LOCK();
    int ret = luainterop_Setup(_l, opt);
    _EvalLuaInteropStatus(luainterop_Error(), "Setup()");
    return ret;
}

//--------------------------------------------------------//
String^ Interop::DoCommand(String^ cmd, String^ arg)
{
    LOCK();
    String^ ret = gcnew String(luainterop_DoCommand(_l, ToCString(cmd), ToCString(arg)));
    _EvalLuaInteropStatus(luainterop_Error(), "DoCommand()");
    return ret;
}


//============= C => C# callback functions .cpp =============//


//--------------------------------------------------------//

int luainteropcb_Log(lua_State* l, int level, const char* msg)
{
    LOCK();
    LogArgs^ args = gcnew LogArgs(level, msg);
    Interop::Notify(args);
    return 0;
}


//--------------------------------------------------------//

int luainteropcb_Notification(lua_State* l, int num, const char* text)
{
    LOCK();
    NotificationArgs^ args = gcnew NotificationArgs(num, text);
    Interop::Notify(args);
    return 0;
}


//============= Infrastructure .cpp =============//

//--------------------------------------------------------//
void Interop::Run(String^ scriptFn, List<String^>^ luaPath)
{
    InitLua(luaPath);
    // Load C host funcs into lua space.
    luainterop_Load(_l);
    // Clean up stack.
    lua_pop(_l, 1);
    OpenScript(scriptFn);
}
