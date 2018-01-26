import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    ListView,
    Image
} from 'react-native'

export default class ListViewTrain2 extends  Component  {

    constructor(props){
        super(props)

        var data = require('./data.json')

        var movies = data.broadcast

        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

        //zc (与{没分清楚 zc注意方法后会带(),其他地方多为{}
        this.state = {
            dataSource:ds.cloneWithRows(movies),
            xx:6
        }
    }

    //渲染行组件,参数为行显示的数据
    zc_renderRow(movie, sectionID, rowID, highlightRow){

        return (
            <View style={styles.row}>

                <Image source={{uri:movie.image_url}} style = {styles.image}>
                </Image>

                <View style={styles.rightContainer}>
                    <Text style={styles.name}>{movie.name}</Text>
                    <Text style={styles.time}>{movie.time}</Text>
                </View>

            </View>
        )
    }

    zc_renderSeparator(sectionID,rowID){
        return (
            //设置key
            <View style={styles.separator} key={sectionID+rowID}>

            </View>
        );
    }

    zc_renderHeader(sectionData, sectionID){
        return (
            <View style={styles.header}>
                <Text style={styles.header_text}>zc</Text>
                <View style={styles.separator}>
                </View>
            </View>
        );
    }

    render(){
        return (

            <ListView style={styles.listView}
                      dataSource={this.state.dataSource}
                      renderRow={this.zc_renderRow}//参数笔直传递,不用写出来
                      renderSeparator={this.zc_renderSeparator}
                      renderHeader={this.zc_renderHeader}
            ></ListView>

        )
    }

}


const styles = StyleSheet.create({

    listView:{
        flex:1,
        marginTop:0
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
        backgroundColor:"#F5FCFF"
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
        textAlign:"center"
    },

    time:{
        textAlign:"center",
        marginBottom:3
    }

});