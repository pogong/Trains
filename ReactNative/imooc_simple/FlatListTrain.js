import React, { Component } from 'react';

import {
    Platform,
    StyleSheet,
    Text,
    View,
    FlatList,
    TouchableOpacity,
    Image,
    Alert, ListView
} from 'react-native';


class Cell extends  Component  {

    render(){
        return (
            <TouchableOpacity style={styles.row}
                              {...this.props}
            >

                <Image source={{uri:this.props.movie.image_url}} style = {styles.image}>
                </Image>

                <View style={styles.rightContainer}>
                    <Text style={styles.name}>{this.props.movie.name}</Text>
                    <Text style={styles.time}>{this.props.movie.time}</Text>
                </View>

            </TouchableOpacity>
        )
    }
}

export default class FlatListTrain extends  Component  {
    constructor(props){
        super(props)

        this.state = {
            xx:6
        }
    }

    cellSelect(name){
        alert(name + "+" + this.state.xx)
    }

    //zc remain:({item,index,separators})与(item,index,separators)是不一样的,item是键不要轻易改
    zc_renderRow({item}){
        console.log(item)
        return (
            <Cell movie={item} onPress={this.cellSelect.bind(this,item.name)} />
        )
    }

    render(){

        var data = require('./data.json')

        var movies = data.broadcast

        return (

            <FlatList style={styles.listView}
                data={movies}
                renderItem={this.zc_renderRow.bind(this)}
                keyExtractor={(movie, index) => "index"+movie.time+index}
            />

        )
    }

}

const styles = StyleSheet.create({

    listView:{
        flex:1,
        marginTop:0,
        backgroundColor:"blue"
    },

    header:{
        height:64,
        backgroundColor:"cyan",
    },

    header_text:{

        flex:1,
        lineHeight:64,//字高
        textAlign:"center",
        fontSize:20,
        fontWeight:"bold",

    },

    row:{
        flexDirection:"row",
        padding:5,
        alignItems:"center",
        backgroundColor:"red"
    },

    separator:{

        height:1,
        backgroundColor:"#CCCCCC",

    },

    image:{
        width:53,
        height:81
    },

    rightContainer:{
        marginLeft:10,
        flex:1
    },

    name:{
        fontSize:18,
        marginTop:3,
        marginBottom:3,
        textAlign:"center",
        color:"cyan"
    },

    time:{
        textAlign:"center",
        marginBottom:3
    }

});
