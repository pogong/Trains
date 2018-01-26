import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    NavigatorIOS,
    ScrollView,
    TouchableHighlight
} from 'react-native';

//注意:不能有多个export default class
export default class Navigation extends  Component {
    _handleNavigationRequest() {
        this.refs.nav.push();
    }

    render() {
        return (
            <NavigatorIOS
                ref='nav'//注意ref
                initialRoute={{
                    component: this.props.component
                }}
                title="图书"
                style={{flex: 1}}
            />
        );
    }

}

const styles = StyleSheet.create({
    flex:{
        flex: 1,
    },
    list_item:{
        height:40,
        marginLeft:10,
        marginRight:10,
        borderBottomWidth:1,
        borderBottomColor: '#ddd',
        justifyContent: 'center'
    },
    list_item_font:{
        fontSize:16
    }
});