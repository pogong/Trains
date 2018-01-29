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

export default class TouchableTest extends  Component{

    constructor(props){
        super(props)
        this.state={
            count:0,
            text:'zc',
            waiting:false,
            startTime:0,
            endTime:0
        }
    }

    pressAct1(){
        alert("xxx")
    }

    pressAct2(passText){
        alert(passText)
    }

    pressAct3() {
        alert(this.state.text)
        this.setState({text: "zc2"})
    }

    render(){
        return <View style={styles.container}>

            <TouchableOpacity style={styles.btn}
                              onPress={() => this.pressAct1()}
            >
                <Text style={styles.search}>搜索1</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.btn}
                              onPress={() => this.pressAct2("pass in")}
            >
                <Text style={styles.search}>搜索2</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.btn}
                              onPress={() => this.pressAct3()}
            >
                <Text style={styles.search}>搜索3</Text>
            </TouchableOpacity>

        </View>
    }

    // render(){
    //     return <View style={styles.container}>
    //
    //         <TouchableOpacity style={styles.btn}
    //                           onPress={this.pressAct1}
    //         >
    //             <Text style={styles.search}>搜索1</Text>
    //         </TouchableOpacity>
    //
    //         <TouchableOpacity style={styles.btn}
    //                           // onPress={this.pressAct2("zc2")}//只参数:错误,会直接调用
    //         >
    //             <Text style={styles.search}>搜索2</Text>
    //         </TouchableOpacity>
    //
    //         <TouchableOpacity style={styles.btn}
    //                           onPress={this.pressAct2.bind(this,"xx")}//只参数:对
    //         >
    //             <Text style={styles.search}>搜索3</Text>
    //         </TouchableOpacity>
    //
    //         <TouchableOpacity style={styles.btn}
    //                           onPress={this.pressAct3.bind(this)}
    //         >
    //             <Text style={styles.search}>搜索4</Text>
    //         </TouchableOpacity>
    //
    //     </View>
    // }

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
    }

});