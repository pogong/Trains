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
    ListView
} from 'react-native'

import {utill} from './../common/utill'

import {Douban_APIs} from './../common/service'

import Searcher from './../common/SearchBar'

import  BookItem from "./BookItem"
import SearchBar from "../common/SearchBar";
import BookDetail from "./BookDetail";

export default class BookList extends  Component  {

    constructor(props){
        super(props)

        this.state = {
            loaded:false
        }

    }

    pushAct(bookid){

        console.log("pushAct")

        const nextRoute = {
            component: BookDetail,
            title: 'BookDetail',
            passProps: { putInside: bookid }
        };

        this.props.navigator.push(nextRoute);
    }

    //渲染行组件,参数为行显示的数据
    zc_renderRow(book){
        return (
            <BookItem book={book} onPress={this.pushAct.bind(this,book.id)}/>
        // {/*<BookItem book={book} onPress={this.pushAct.bind(this,book.id)}/>*/} //不用了,要注释两遍
        )
    }

    zc_renderSeparator(sectionID,rowID){
        return (
            //设置key
            <View style={styles.separator} key={sectionID+rowID}>

            </View>
        );
    }

    componentDidMount(){
        var that = this;
        var url = Douban_APIs.book_search + "?count=20&q=react"
        utill.getNetData(url,function (data) {
            var books = data.books;

            if(!data.books || data.books.length == 0){
                return alert("未找到匹配书籍")
            }

            var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

            that.setState({
                dataSource:ds.cloneWithRows(books),
                loaded:true
            })
        },function (error) {
            alert(error)
        })
    }

    getData(){
        var that = this;
        var url = Douban_APIs.book_search + "?count=20&q=" + this.state.keywrods

        console.log(url)

        utill.getNetData(url,function (data) {
            var books = data.books;

            if(!data.books || data.books.length == 0){
                return alert("未找到匹配书籍")
            }

            var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

            that.setState({
                dataSource:ds.cloneWithRows(books),
                loaded:true
            })
        },function (error) {
            alert(error)
        })
    }

    zc_changText(text){
        this.setState({
            keywrods:text//JS放入数据,立刻打印是不会有效果的
        });
    }

    zc_searchPress(){
        this.getData()
    }

    render(){

        if (!this.state.loaded){
            return utill.loading;
        }else {

            return (

                <ScrollView style={styles.container}>
                    <SearchBar

                        outpass_placeholder="请输入图书名称"
                        outpass_onPress={() => this.zc_searchPress()}
                        outpass_onChangeText={this.zc_changText.bind(this)}

                    />
                    <ListView style={styles.listView}
                              dataSource={this.state.dataSource}
                              renderRow={this.zc_renderRow.bind(this)}//参数笔直传递,不用写出来
                              renderSeparator={this.zc_renderSeparator}
                    ></ListView>
                </ScrollView>

            )

        }

    }

}

const styles = StyleSheet.create({

    container:{
        flex:1,
        marginTop:60,
        marginBottom:49
    },

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