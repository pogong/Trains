import PropTypes from 'prop-types'

import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    TabBarIOS
} from 'react-native'

import TextInputComponent from "./TextInputComponent"
import ImageComponent from "./ImageComponent"
import ListViewTrain2 from "./ListViewTrain2"

export default class TabBarTrain extends  Component{

    constructor(props){
        super(props)
        this.state={
            tab:"1"
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
                    title="1"
                    icon={{uri:'tab_home_unselect_icon',scale:2}}
                    selectedIcon={{uri:'tab_home_selected_icon',scale:2}}
                    //zc remian:selectedIcon在用命令行运行工程时,没有效果;而直接用Xcode跑是好的,很疑惑,打包在看
                    renderAsOriginal={true}
                    onPress = {this.select.bind(this,"1")}
                    selected = {this.state.tab === "1"}
                >

                    <TextInputComponent></TextInputComponent>

                </TabBarIOS.Item>


                <TabBarIOS.Item
                    title="2"
                    icon={{uri: 'tab_daily_unselect_icon',scale:2}}
                    selectedIcon={{uri: 'tab_daily_selected_icon',scale:2}}
                    renderAsOriginal={true}
                    onPress = {this.select.bind(this,"2")}
                    selected = {this.state.tab === "2"}
                >

                    <ImageComponent></ImageComponent>

                </TabBarIOS.Item>

                <TabBarIOS.Item
                    title="3"
                    icon={{uri: 'tab_landstutas_unselect_icon',scale:2}}
                    selectedIcon={{uri: 'tab_landstutas_selected_icon',scale:2}}
                    renderAsOriginal={true}
                    onPress = {this.select.bind(this,"3")}
                    selected = {this.state.tab === "3"}
                >

                    <ListViewTrain2></ListViewTrain2>

                </TabBarIOS.Item>

    </TabBarIOS>
        );
    }

}