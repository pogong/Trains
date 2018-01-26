import React,{Component} from 'react'

import {
    StyleSheet,
    Text,
    View
} from 'react-native'

//导出变量
export var name = '小明';

var age = 23;
var score = 99;

export {age,score};

//导出方法
export function sum(a,b) {
    return a+b
}