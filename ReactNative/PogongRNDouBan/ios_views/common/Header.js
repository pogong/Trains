import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    TouchableOpacity,
    ActivityIndicator
} from 'react-native'

import left from "./left_icon"

export default class Header extends  Component {

    zc_pop(){
        this.props.navigator.pop();
    }

    render(){

        var headerContent = this.props.headerContent;

        return (
            <View style={styles.header}>
                <TouchableOpacity style={styles.left_btn} onPress={this.zc_pop}>
                    <left_icon/>
                    <Text style={styles.btn_text}>{headerContent.backName}</Text>
                </TouchableOpacity>
                <View style={styles.title_container}>
                    <Text style={styles.title}>{headerContent.title}</Text>
                </View>
            </View>
        );
    }
}


const styles = StyleSheet.create({

    header:{
        height:44,
        backgroundColor:"#3497FF",
        flexDirection:"row",
        justifyContent:"center",
        alignItems:"center"
    },
    left_btn:{
        flexDirection:"row",
        justifyContent:"center",
        alignItems:"center"
    },
    btn_text:{
        color:"#fff",
        fontSize:17,
        fontWeight:"bold"
    },
    title_container:{
        flex:1,
        justifyContent:"center",
        alignItems:"center"
    },
    title:{
        color:"#fff",
        fontSize:18,
        fontWeight:"bold",
        lineHeight:18,
        width:200
    },

});