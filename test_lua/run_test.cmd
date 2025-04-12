
echo off
cls

pushd ..

set TERM=1

set LUA_PATH=;;.\LBOT\?.lua;
:: Run the unit tests.
::  test_stringex  test_utils  test_types  test_class  test_pnut  test_list  test_tableex
lua LBOT\pnut_runner.lua  test_lua\test_utils.lua  test_lua\test_types.lua  test_lua\test_tableex.lua  test_lua\test_list.lua

popd
