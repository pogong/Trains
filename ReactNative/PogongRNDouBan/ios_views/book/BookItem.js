import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    Image
} from 'react-native'

import BookDetail from "./BookDetail"

export default class BookItem extends  Component {

    render(){

        var book = this.props.book;

        return (

            <TouchableOpacity style={styles.item} {...this.props} >

                <View style={styles.imageContainer}>
                    <Image style={styles.image} source={{url:book.image}}></Image>
                </View>

                <View style={styles.allTextContainer} >
                    <View style={styles.textContainer}>
                        <Text style={styles.title}>{book.title}</Text>
                    </View>
                    <View style={styles.textContainer}>
                        <Text style={styles.publisher}>{book.publisher}</Text>
                    </View>
                    <View style={styles.textContainer}>
                        <Text style={styles.authour}>{book.authour}</Text>
                    </View>
                    <View style={{flexDirection:"row",flex:1,alignItems:"center"}}>
                        <Text style={styles.price}>{book.price}</Text>
                        <Text style={styles.pages}>{book.pages}</Text>
                    </View>
                </View>

            </TouchableOpacity>


        );

    }
}

const styles = StyleSheet.create({
    item:{
        flexDirection: "row",
        height:120,
        padding:10
    },
    imageContainer:{
        justifyContent:"center",
        alignItems:"center"
    },

    image:{
        width:80,
        height:100
    },
    allTextContainer:{
        flex:1,
        marginLeft:15
    },
    textContainer:{
        flex:1,
        justifyContent:"center"
    },
    publisher:{
        color:"#A3A3A3",
        fontSize:13
    },
    authour:{
        color:"#A3A3A3",
        fontSize:13
    },
    price:{
        color:"#2bb2a3",
        fontSize:16
    },
    pages:{
        marginLeft:10,
        color:"#a7a0a0"
    }

});