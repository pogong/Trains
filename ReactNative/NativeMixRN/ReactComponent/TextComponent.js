import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert
} from 'react-native'

import  TextHeader from './TextHeader'

import  TextNews from './TextNews'


export default class TextComponent extends  Component {
    render() {

        var news = [

            "1.习近平对政法工作作出重要指示10法工作作出重要指",
            "2.习近平对政法工作作出重要指示2",
            "3.习近平对政法工作作出重要指示3",
            "4.习近平对政法工作作出重要指示4",

        ];

        return (<View>
                <TextHeader/>
                <TextNews
                news={news}
                />
            </View>
        )

    }
}

const styles = StyleSheet.create({

    header:{
        flexDirection:"row",//横(row)排布,还是竖(column)排布
        height:44,
        marginTop:20,
        backgroundColor:"red",
    },
    news:{
        flex:1,//从左向右摆布
        backgroundColor:"blue",
    },

});