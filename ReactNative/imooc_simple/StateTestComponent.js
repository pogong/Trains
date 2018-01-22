import React,{Component} from 'react'

import {
    StyleSheet,
    Text,
    View,
    Image
} from 'react-native'

export default class StateTestComponent extends Component{

    state={
        size:80
    }

    constructor(props){
        super(props)
    }

    render(){
        return <View>
            <Text style={{fontSize:20,backgroundColor:'red'}}
                  onPress={()=>{
                      this.setState({
                      size:this.state.size+20
                      })
                  }}
            >放大</Text>
            <Text style={{fontSize:20,backgroundColor:'red'}}
                  onPress={()=>{
                      this.setState({
                          size:this.state.size-20
                      })
                  }}
            >缩小</Text>

            <Image
                style={{width:this.state.size,height:this.state.size}}
                source={require('./zc_need_show.jpg')}
            />

        </View>
    }
}