import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    NavigatorIOS
} from 'react-native'

class PageA extends  Component{

    pushAct(){

        const nextRoute = {
            component: PageB,
            title: 'PageB',
            passProps: { putInside: "zc" }
        };

        this.props.navigator.push(nextRoute);
    }

    render(){
        //zc remain:样式并用
        return <View style={[styles.container, {backgroundColor:"cyan"}]}>
            <TouchableOpacity style={styles.btn}
                              onPress={() => this.pushAct()}

            >
                <Text style={styles.search}>push</Text>
            </TouchableOpacity>
        </View>
    }

}

class PageB extends  Component{

    pop(){
        this.props.navigator.pop();
    }

    render(){
        return (
            <View style={[styles.container, {backgroundColor:"red"}]}>

                <TouchableOpacity style={styles.btn}
                                  onPress={() => this.pop()}

                >
                    <Text style={styles.search}>pop+{this.props.putInside}</Text>
                </TouchableOpacity>
            </View>
        );
    }

}

export default class NavigatorTrain extends  Component{

    pushAct(){

        const nextRoute = {
            component: PageB,
            title: 'PageB',
            passProps: { putInside: "zc" }
        };

        this.refs.nav.push(nextRoute);//注意ref

    }

    render(){
        return (

            <NavigatorIOS
                ref='nav'//注意ref
                initialRoute={{
                    component: PageA
                }}
                title="图书"
                style={{flex: 1}}
                onRightButtonPress={() => this.pushAct()}
                rightButtonTitle="push"
            />

        );
    }

}

const styles = StyleSheet.create({

    container:{
        flex:1,
        alignItems:"center",
        justifyContent:"center",
    },
    btn:{
        alignItems:"center",
        justifyContent:"center",
        height:33,
        width:60,
        backgroundColor:"blue"
    }

});