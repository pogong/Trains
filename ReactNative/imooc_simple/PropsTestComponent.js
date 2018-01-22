import PropTypes from 'prop-types'

import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View
} from 'react-native'


export default class PropsTestComponent extends  Component{
    static defaultProps = {
        name:'xh',
        age:13
    }

    static propTypes = {
        name:PropTypes.string,
        age:PropTypes.number,
        sex:PropTypes.string.isRequired,
    }

    render(){
        return <View>
                   <Text style={{fontSize:20,backgroundColor:'blue'}}>{this.props.name}</Text>
                   <Text style={{fontSize:20,backgroundColor:'blue'}}>{this.props.age}</Text>
                   <Text style={{fontSize:20,backgroundColor:'blue'}}>{this.props.sex}</Text>
              </View>
    }
}
