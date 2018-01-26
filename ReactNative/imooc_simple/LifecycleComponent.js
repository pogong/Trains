import React,{Component} from 'react'

import {
    StyleSheet,
    Text,
    View
} from 'react-native'

export default class LifecycleComponent extends Component{

    constructor(props){
        super(props)
        console.log('---constructor---')
        this.state={
            count:0
        }
    }

    componentWillMount(){
        console.log('---componentWillMount---')
    }

    componentDidMount(){
        console.log('---componentDidMount---')
    }

    componentWillReceiveProps(nextProps){
        console.log('---componentWillReceiveProps---')
    }

    shouldComponentUpdate(nextProps,nextState){
        console.log('---shouldComponentUpdate---')
        return true
    }

    componentWillUpdate(nextProps,nextState){
        console.log('---componentWillUpdate---')
        return true
    }

    componentDidUpdate(nextProps,nextState){
        console.log('---componentDidUpdate---')
        return true
    }

    render(){
        console.log('---render---')

        // return <Text style={{fontSize:20,backgroundColor:'blue'}}>被打了</Text>

        return <View>

        <Text
            style={{fontSize:20,backgroundColor:"blue"}}
            onPress={()=>{

            this.setState({
                count:this.state.count+1
            })

            }
            }
        >有本事来打我呀.</Text>

        <Text style={{fontSize:20,backgroundColor:'red'}}>--被打了{this.state.count}</Text>

        </View>
    }

}