import React,{Component} from 'react'

import {
    StyleSheet,
    Text,
    View
} from 'react-native'

/*
* 方式一:ES6
* 推荐使用
* */

export default class PogongComponent extends  Component{
    render(){
        return <Text style={{fontSize:20,backgroundColor:'blue'}}>加的{this.props.name}</Text>
    }
}


/*
* 方式二:ES5 我的webstStorm不支持ES5语法,so
* */
// var PogongComponent=React.createClass({
//
//     render(){
//         return <Text style={{fontSize:20,backgroundColor:'blue'}}>Pogong</Text>
//     }
//
// })
// module.exports=PogongComponent;

/*
* 方式三:函数式
* 无状态,无生命周期,不能使用this
* */
// function PogongComponent(props) {
//     return <Text style={{fontSize:20,backgroundColor:'blue'}}>{props.name}</Text>
// }
// module.exports=PogongComponent;