/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';

import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';

// import PogongComponent from  './PogongComponent';

import LifecycleComponent from  './LifecycleComponent';

import EIComponent,{name,age,score,sum} from "./EIComponent";//类,变量,方法的导出全要写明

import RefTestComponent from  './RefTestComponent';
import Student from  './Student';
import Xiaoming from  './Xiaoming';
import TouchableTest from "./TouchableTest";

const instructions = Platform.select({
  ios: 'zc xxhh Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component<{}> {

    constructor(props) {
        super(props)
        this.state = ({
            remove: false,
            result:'',
            size:0
        })
        this.student = new Student('xh','女',16)
        this.ming=new Xiaoming()
    }

    render() {

        return (
                <View style=styles.pogong_style}>
                    <TouchableTest/>
                </View>
            )




        // return <View style={styles.pogong_style}>
        //
        //     <Text style={{fontSize: 20, backgroundColor: 'red'}}
        //           onPress={() => {
        //               var size = this.refs.reftest.getSize();//zc细心点好不好
        //               this.setState({
        //                   size: size
        //               })
        //           }}
        //     >{this.ming.getDescription()}</Text>
        //
        // </View>
    }

};

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
