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


export default class BookDetail extends  Component {
    render(){
        return (
            <View style={styles.container}>

                <Text style={styles.text}>{this.props.putInside}</Text>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    container:{
        flex:1,
        marginTop:0,
        backgroundColor:"green"
    },
    text:{
        marginTop:200,
        backgroundColor:"cyan",
        fontSize:20,
        height:64,
        marginLeft:30
    }
});