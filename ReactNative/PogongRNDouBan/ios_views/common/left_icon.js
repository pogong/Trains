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


export default class left_icon extends  Component {
    render(){
        return (
            <View>
                <View style={styles.back}>

                </View>
            </View>
        );
    }
}


const styles = StyleSheet.create({

    back:{
       width:5,
        height:15,
        borderLeftWidth:2,
        borderBottomWidth:2,
        borderColor:"#fff",
        marginLeft:10,
        transform:[{rotate:"45deg"}]
    }

});