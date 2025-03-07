
echo off
cls

pushd ..

set LUA_PATH=;;.\LBOT\?.lua;
:: Run the unit tests.
::  test_stringex.lua  test_utils.lua  test_class.lua  test_pnut.lua
lua LBOT\pnut_runner.lua  test_lua\test_utils.lua

popd
