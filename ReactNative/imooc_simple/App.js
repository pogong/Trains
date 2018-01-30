

import React, { Component } from 'react';

import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';

//zc remain:导出
import {name,age,sum} from './EIComponent'
import ListViewTrain2 from "./ListViewTrain2";
import FlatListTrain from "./FlatListTrain";
import ScrollViewMovieList from "./ScrollViewMovieList";
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
    }

    render() {

        return (
            <View style={styles.pogong_style}>
                <ListViewTrain2/>
            </View>
            )

    }

};

const styles = StyleSheet.create({
    pogong_style: {
        flex: 1,
        backgroundColor: 'red',
        marginTop:0
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
