import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    TouchableOpacity,
    WebView
} from 'react-native'


import Header from "./Header"

export default class CommonWebview extends  Component {
    render(){

        return (
            <View style={styles.header}>
                <Header

                    navigator={this.props.navigator}

                    headerContent=({
                        backName:this.props.backName,
                        title:this.props.title,
                    })

                />
                <WebView

                    startInLoadingState={true}
                    contentInset={{top:44,bottom:-120}}
                    source={{url:this.props.url}}

                />
            </View>
        );
    }
}