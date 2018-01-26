import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert
} from 'react-native'

export default class TextHeader extends  Component {
    render() {

        return (
            <View style={styles.flex}>

                <Text style={styles.font}>
                    <Text style={styles.font1}>网易</Text>
                    <Text style={styles.font2}>新闻</Text>
                    <Text >有态度</Text>
                </Text>

            </View>
        )

    }
}

const styles = StyleSheet.create({

    flex:{
        marginTop:20,
        height:44,
        borderBottomWidth:1,
        borderBottomColor:"#EF2D36",
        alignItems:"center",
    },

    font:{
        marginTop:10,
        fontSize:25,
        fontWeight:"bold",
        textAlign:"center",
    },

    font1:{
        color:"#CD1D1C",
    },

    font2:{
        color:"#fff",
        backgroundColor:"#CD1D1C",
    },

});