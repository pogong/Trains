import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    Dimensions,
    ActivityIndicator
} from 'react-native'

//导出变量
export var utill = {
    windowSize:{
        width:Dimensions.get("window").width,
        height:Dimensions.get("window").height
    },
    getNetData(url,successCallBack,failCallback){

        console.log({url})

        var opt = {
            method:"GET"
        }
        fetch(url,opt)
            .then((response) => {
                return response.json()
            })
            .then((responseText) => {
                successCallBack(responseText)
            })
            .catch((error) => {
                failCallback(error)
            })
    },
    loading:<ActivityIndicator style={{marginTop:200}}/>
};
