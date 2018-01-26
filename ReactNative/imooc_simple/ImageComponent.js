import PropTypes from 'prop-types'

import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    Image
} from 'react-native'

export default class ImageComponent extends  Component{

    render(){
        return (
            <View style={styles.container}>

                <View style={styles.netImageView}>

                    <Image
                        style={styles.netImage}
                        source={{uri:"http://a.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059f550a1832334349b023bbae3.jpg"}}
                    />

                </View>

                <View style={styles.lcoalImageView}>

                    <Image
                        style={styles.lcoalImage}
                        source={require('./zc_need_show.jpg')}
                        resizeMode="stretch"//cover==>按比例撑开显示 contain==>按比例缩小显示 stretch==>填满
                    />

                </View>

            </View>
            )
    }

}

const styles = StyleSheet.create({

    container:{
        flex:1,//横(row)排布,还是竖(column)排布
        margin:25,
        alignItems:"center",
    },
    netImageView:{
        marginTop:50,//从左向右摆布
        width:300,
        height:240,
        justifyContent:"center",
        alignItems:"center",
        backgroundColor:"cyan"
    },
    netImage:{
        width:300,
        height:240,
        backgroundColor:"gray"
    },
    lcoalImageView:{
        marginTop:50,//从左向右摆布
        width:300,
        height:240,
        justifyContent:"center",
        alignItems:"center",
        backgroundColor:"yellow"
    },
    lcoalImage:{
        width:300,
        height:240,
        backgroundColor:"gray"
    },

});