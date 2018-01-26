import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert
} from 'react-native'

export default class TextNews extends  Component {

    zc_show(subText){
        alert(subText)
    }

    render() {

        var news = [];

        for(var i in this.props.news){

            var text = (

                <Text
                    style={styles.news_item}
                    numberOfLines={2}
                    key={i}

                    onPress={this.zc_show.bind(this,this.props.news[i])}//需要bind

                >
                    {this.props.news[i]}
                </Text>

            );

            news.push(text)
        }

        return (
            <View style={styles.flex}>
                <Text style={styles.news_title}>今日要闻</Text>
                {news}
            </View>
        )

    }
}

const styles = StyleSheet.create({

    flex:{
        flex:1,
    },

    news_title:{
        fontSize:20,
        fontWeight:"bold",
        color:"#CD1D1C",
        marginLeft:10,
        marginTop:15
    },

    news_item:{
        marginTop:10,
        marginLeft:10,
        marginRight:10,
        fontSize:15,
        lineHeight:30
    },

});