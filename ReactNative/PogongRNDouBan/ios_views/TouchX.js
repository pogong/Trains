import PropTypes from 'prop-types'

import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert
} from 'react-native'

export default class TouchX extends  Component{

    constructor(props){
        super(props)
        this.state={
            count:0,
            text:'搜索',
            waiting:false,
            startTime:0,
            endTime:0
        }
    }

    zc_Press(){
        alert('zz')
    }

    render(){
        return <View style={styles.container}>

            <View style={styles.flex}>

                <View style={styles.input}>


                </View>

            </View>


            <TouchableOpacity style={styles.btn}

                              onPress={this.zc_Press}


            >
                <Text style={styles.search}>{this.state.text}</Text>
            </TouchableOpacity>

        </View>
    }

}

const styles = StyleSheet.create({

    container:{
        flexDirection:"row",//横排布,还是竖()排布
        height:44,
        marginTop:20,
        backgroundColor:"red",
    },
    flex:{
        flex:1,//从左向右摆布
        backgroundColor:"blue",
    },
    input:{
        height:44,
        marginLeft:5,//外边距
        paddingLeft:5,//内切
        borderColor:"#CCC",//边框颜色
        borderRadius:4,//圆角大小
        borderWidth:1,//边框宽度
        backgroundColor:"orange",
    },
    btn:{
        width:60,
        marginLeft:5,
        marginRight:5,
        backgroundColor:"#238EFF",
        height:44,
        justifyContent:"center",//竖向居中
        alignItems:"center"//横向居中
    },
    search:{
        color:"#FFF",
        fontSize:15,
        fontWeight:"bold",//粗体,斜体之类
        backgroundColor:"yellow",
    }

});