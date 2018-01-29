import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    Image,
    ScrollView,
    RefreshControl
} from 'react-native'

export default class ScrollViewMovieList extends  Component {


    render(){

        //获取外围数据
        var data = require('./data.json')

        var movies = data.broadcast

        var movieRows = [];

        for(var i in movies){

            //不要写在cell的括号内
            var movie = movies[i]

            var cell = (

            <View key={i} style={styles.row}>

                <Image source={{uri:movie.image_url}} style = {styles.image}>
                </Image>

                <View style={styles.rightContainer}>
                    <Text style={styles.name}>{movie.name}</Text>
                    <Text style={styles.time}>{movie.time}</Text>
                </View>

            </View>

            )

            movieRows.push(cell)
        }

        return (
            <View
                style={styles.container}
            >
                <ScrollView
                    style={styles.scrollView}
                >
                    {movieRows}
                </ScrollView>
            </View>
        );
    }

}

const styles = StyleSheet.create({

    container:{
        flex:1
    },

    scrollView:{
        flex:1,
        marginTop:25,
        backgroundColor:"#F5FCFF"
    },

    row:{
        flexDirection:"row",
        padding:5,
        alignItems:"center",
        backgroundColor:"#F5FCFF"
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
        textAlign:"center"
    },

    time:{
        textAlign:"center",
        marginBottom:3
    }
});