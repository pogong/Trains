import React,{Component} from 'react'

import {
    StyleSheet,
    Text,
    View
} from 'react-native'

export default class FlexTrain extends  Component {
    render() {

        return (
            <View style={styles.container}>
                <View style={styles.subView1}>

                </View>
                <View style={styles.subView2}>

                </View>
            </View>
        )
    }


}

// const styles = StyleSheet.create({
//
//     container:{
//         margin:30,
//         width:300,
//         height:500,
//         backgroundColor:'yellow',
//         flexDirection:'row',//默认排布是column==>竖向
//         justifyContent:'center',//主轴方向(主轴方向由flexDirection确定)
//         alignItems:'center',//交叉轴方向
//     },
//     subView1:{
//         width:100,
//         height:100,
//         backgroundColor:'green'
//     },
//     subView2:{
//         width:100,
//         height:100,
//         backgroundColor:'blue'
//     }
//
// });


/*
flex:本组件期待撑满父组件的剩余空间的权重
[subView1(flex:2),subView2(flex:1)]==>显示效果就是subView1的大小会是subView2的两倍
*/

const styles = StyleSheet.create({

    container:{
        marginTop:30,
        flex:1,
        backgroundColor:'cyan'
    },
    subView1:{
        flex:2,
        backgroundColor:'green'
    },
    subView2:{
        flex:1,
        backgroundColor:'yellow'
    }

});