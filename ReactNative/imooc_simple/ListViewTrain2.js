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

    pushAct(name){
        alert(name + "+" + this.state.xx)
    }

    //渲染行组件,参数为行显示的数据
    zc_renderRow(movie, sectionID, rowID, highlightRow){
        console.log(this.state.xx)
        return (
            <Cell movie={movie} onPress={this.pushAct.bind(this,movie.name)} />
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
                      renderRow={this.zc_renderRow.bind(this)}//zc remain:非常重要==>cell的点击用到this,所以这里就需要bind
                      //renderRow={() => this.zc_renderRow}//zc remain:这种写法虽然不用刻意做bind,但没法传递renderRow传入的参数
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