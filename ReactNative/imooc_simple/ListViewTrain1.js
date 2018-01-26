import React,{Component} from 'react' //

import {
    StyleSheet,
    Text,
    View,
    TouchableWithoutFeedback,
    TouchableOpacity,
    Alert,
    TextInput,
    ListView
} from 'react-native'

export default class ListViewTrain1 extends  Component {
    //ListView最重要的是每行cell的设置

    constructor(props){
        super(props)

        var data = [

            "1.习近平对政法工作作出重要指示1",
            "2.习近平对政法工作作出重要指示2",
            "3.习近平对政法工作作出重要指示3",
            "4.习近平对政法工作作出重要指示4",
            "5.习近平对政法工作作出重要指示5",
            "6.习近平对政法工作作出重要指示6",
            "7.习近平对政法工作作出重要指示7",
            "8.习近平对政法工作作出重要指示8",
            "9.习近平对政法工作作出重要指示9",

        ]

        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

        //zc (与{没分清楚 zc注意方法后会带(),其他地方多为{}
        this.state = {
            dataSource:ds.cloneWithRows(data)
        }
    }

    //渲染行组件,参数为行显示的数据
    zc_renderRow(rowdata:string){

        return (
            <View style={styles.row}>
                <Text style={styles.content}>{rowdata}</Text>
            </View>
        )
    }

    render(){
        return (

            <ListView style={styles.container}
                      dataSource={this.state.dataSource}
                      renderRow={this.zc_renderRow}//参数笔直传递,不用写出来
            ></ListView>

        )
    }

}


const styles = StyleSheet.create({

    container:{
        flex:1,
        marginTop:25
    },
    row:{
        justifyContent:"center",
        alignItems:"center",
        padding:5,
        height:100,
        borderBottomWidth:1,
        borderColor:"#CCCCCC"
    },
    content:{
        flex:1,
        fontSize:20,
        color:"blue",
        lineHeight:100
    }

});