import PropTypes from 'prop-types'

import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback
} from 'react-native'

export default class TouchableTest extends  Component{

    render(){
        return <View>

            <TouchableWithoutFeedback
                onPress={()=> {
                    this.setState({count: this.state.count+1})
                }}
            >

                <View style={styles.pogong_style}>
                    <Text style={styles.pogong_style}>
                        我是TouchableWithoutFeedback,单击我
                    </Text>
                </View>
            </TouchableWithoutFeedback>
            <Text style={styles.pogong_style}>您单击了:{this.state.count}次</Text>
        </View>
    }
}

const styles = StyleSheet.create({
    pogong_style: {
        flex: 1,
        backgroundColor: '#ffffff',
        marginTop:20
    },
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#ffffff',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#000000',
        marginBottom: 5,
    },
});