import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput
} from 'react-native'

function getData(url) {
    var opt = {
        method:"GET"
    }
    fetch(url,opt)
        .then((response) => {
            return response.text()
        })
        .then((responseText) => {
            alert(responseText)
        })
        .catch((error) => {
            alert(error)
        })
}

function postData(url) {

    let formData = new  FormData();
    formData.append("z","zz")
    formData.append("3","33")

    var opt = {
        method:"GET",
        body:formData
    }

    fetch(url,opt)
        .then((response) => {
            return response.text()
        })
        .then((responseText) => {
            alert(responseText)
        })
        .catch((error) => {
            alert(error)
        })

}

//zc remain:1个js文件不能有两个export default class
export default class NetworkTrain extends  Component {
    render(){
        return (
            <View style={styles.container}>
                <TouchableOpacity style={styles.btn} onPress={getData.bind(this,"http://127.0.0.1/")}>
                    <Text>Get</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.btn} onPress={postData.bind(this,"我没有url")}>
                    <Text>Post</Text>
                </TouchableOpacity>
            </View>
        );
    }
}

const styles = StyleSheet.create({

    container:{
        flexDirection:"row",
        flex:1,
        marginTop:0,
        backgroundColor:"cyan",
        alignItems:"center",
        justifyContent:"space-around"
    },
    btn:{
        width:60,
        height:30,
        borderRadius:3,
        borderWidth:1,
        borderColor:"#CCCCCC",
        backgroundColor:"yellow",
        justifyContent:"center",
        alignItems:"center"
    },

});