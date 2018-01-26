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

export default class ScrollViewComponent extends  Component {

    link_onScrollBeginDrag(){
        console.log("link_onScrollBeginDrag");
    }

    link_onScrollEndDrag(){
        console.log("link_onScrollEndDrag");
    }

    link_onRefresh(){
        console.log("link_onRefresh");
    }

    render(){
        return(
            <View style={styles.container}>
                <ScrollView style={styles.scrollView}
                            showsVerticalScrollIndicator={true}
                            onScrollBeginDrag={this.link_onScrollBeginDrag}
                            onScrollEndDrag={this.link_onScrollEndDrag}
                            refreshControl={
                                <RefreshControl
                                refreshing={false}
                                title={"zc"}
                                onRefresh={this.link_onRefresh}
                                />
                            }
                >
                    <View style={styles.subView1}></View>
                    <View style={styles.subView2}></View>
                    <View style={styles.subView3}></View>
                </ScrollView>
            </View>
        )
    }
}

const styles = StyleSheet.create({

    container:{
        flex:1,
        backgroundColor:"cyan",
    },
    scrollView:{
        marginTop:25,
        backgroundColor:"#CCCCCC",
    },
    subView1:{
        margin:15,
        flex:1,
        height:300,
        backgroundColor:"red"
    },
    subView2:{
        margin:15,
        flex:1,
        height:300,
        backgroundColor:"yellow"
    },
    subView3:{
        margin:15,
        flex:1,
        height:300,
        backgroundColor:"blue"
    },

});