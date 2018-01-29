import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TabBarIOS
} from 'react-native'

import BookList from "../book/BookList";
import Navigation from "../common/Navigation";

export default class Root extends  Component{

    constructor(props){
        super(props)
        this.state={
            tab:"图书"
        }
    }

    select(tabName){
        this.setState({
            tab: tabName
        })
    }

    render(){
        return (
            <TabBarIOS
                tintColor='cyan' // 文字选中颜色
                unselectedTintColor = 'black' // 文字默认颜色
            >

                <TabBarIOS.Item
                    title="图书"
                    icon={require('./home.png')}
                    selectedIcon={require('./home_s.png')}
                    renderAsOriginal={true}
                    onPress = {this.select.bind(this,"图书")}
                    selected = {this.state.tab === "图书"}
                >

                    <Navigation
                        component={BookList}
                    />

                </TabBarIOS.Item>


                <TabBarIOS.Item
                    title="电影"
                    icon={require('./mine.png')}
                    selectedIcon={require('./mine_s.png')}
                    renderAsOriginal={true}
                    onPress = {this.select.bind(this,"电影")}
                    selected = {this.state.tab === "电影"}
                >

                    <View style={{flex:1,backgroundColor:"cyan"}}>
                    </View>

                </TabBarIOS.Item>

            </TabBarIOS>
        );
    }

}