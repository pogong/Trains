import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    ActivityIndicator
} from 'react-native'


export default class SearchBar extends  Component {
    render(){
        return (
            <View style={styles.container}>
                <View style={styles.inputContainer}>

                    <TextInput style={styles.input} placeholder={this.props.outpass_placeholder} onChangeText={this.props.outpass_onChangeText}>

                    </TextInput>

                </View>

                <TouchableOpacity style={styles.btn} onPress={this.props.outpass_onPress}>

                    <Text style={styles.search}>搜索</Text>

                </TouchableOpacity>

            </View>
        );
    }
}

const styles = StyleSheet.create({

    container:{
        flexDirection:"row",//横(row)排布,还是竖(column)排布
        height:44,
        marginTop:20,
    },
    inputContainer:{
        flex:1,//从左向右摆布
    },
    input:{
        height:44,
        marginLeft:5,//外边距
        paddingLeft:5,//内切
        borderColor:"#CCC",//边框颜色
        borderRadius:4,//圆角大小
        borderWidth:1,//边框宽度
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