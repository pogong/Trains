//
//  AppDelegate.h
//  ServerAsncSocket
//
//  Created by 涂耀辉 on 17/1/19.
//  Copyright © 2017年 涂耀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


/*
 2017-12-06 13:32:57.682336+0800 ServerAsncSocket[4888:848072] zc func call-->source_handler trigger datalength = 44
 2017-12-06 13:32:57.682492+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.682640+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM SOCKET -->preBuffer从socket读入44个字节
 2017-12-06 13:32:57.682920+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入38个字节
 2017-12-06 13:32:57.683191+0800 ServerAsncSocket[4888:847993] 读头成功,包长:6
 
 2017-12-06 13:32:57.683339+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.683408+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.683535+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 13:32:57.683629+0800 ServerAsncSocket[4888:847993] 收到消息:你好
 
 2017-12-06 13:32:57.683736+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.683812+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.683867+0800 ServerAsncSocket[4888:848072] zc func call -- socket与preBuffer都没有可读数据
 
 2017-12-06 13:32:57.723393+0800 ServerAsncSocket[4888:848072] zc func call-->source_handler trigger datalength = 193
 2017-12-06 13:32:57.723511+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.723619+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM SOCKET -->preBuffer从socket读入193个字节
 2017-12-06 13:32:57.723898+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入38个字节
 2017-12-06 13:32:57.724124+0800 ServerAsncSocket[4888:847993] 读头成功,包长:6
 
 2017-12-06 13:32:57.724241+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.724318+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.724483+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 13:32:57.724654+0800 ServerAsncSocket[4888:847993] 收到消息:猪头
 
 2017-12-06 13:32:57.724792+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.724868+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.724943+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入38个字节
 2017-12-06 13:32:57.725068+0800 ServerAsncSocket[4888:847993] 读头成功,包长:6
 
 2017-12-06 13:32:57.725182+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.725289+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.725425+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 13:32:57.725577+0800 ServerAsncSocket[4888:847993] 收到消息:先生
 
 2017-12-06 13:32:57.725702+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.725802+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.725859+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入39个字节
 2017-12-06 13:32:57.725966+0800 ServerAsncSocket[4888:847993] 读头成功,包长:15
 
 2017-12-06 13:32:57.726162+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.726224+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.726338+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入15个字节
 2017-12-06 13:32:57.726416+0800 ServerAsncSocket[4888:847993] 收到消息:今天天气好
 
 2017-12-06 13:32:57.726527+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.726779+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.726845+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入39个字节
 2017-12-06 13:32:57.726971+0800 ServerAsncSocket[4888:847993] 读头成功,包长:12
 
 2017-12-06 13:32:57.727073+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.727206+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.727342+0800 ServerAsncSocket[4888:848072] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入12个字节
 2017-12-06 13:32:57.727560+0800 ServerAsncSocket[4888:847993] 收到消息:吃饭了吗
 
 2017-12-06 13:32:57.727721+0800 ServerAsncSocket[4888:848072] zc func call -- 新建packet再次读取
 2017-12-06 13:32:57.727859+0800 ServerAsncSocket[4888:848072] zc func call-->doReadData
 2017-12-06 13:32:57.728005+0800 ServerAsncSocket[4888:848072] zc func call -- socket与preBuffer都没有可读数据
 */

/*
 2017-12-06 14:48:14.512660+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 44
 2017-12-06 14:48:14.512855+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.513034+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->preBuffer从socket读入44个字节
 2017-12-06 14:48:14.513376+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入38个字节
 2017-12-06 14:48:14.513723+0800 ServerAsncSocket[5148:888958] 读头成功,包长:6
 2017-12-06 14:48:14.513879+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.513942+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.514031+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 14:48:14.514139+0800 ServerAsncSocket[5148:888958] 收到消息:你好
 2017-12-06 14:48:14.514286+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.514454+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.514665+0800 ServerAsncSocket[5148:889071] zc func call -- socket与preBuffer都没有可读数据
 2017-12-06 14:48:14.518947+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 193
 2017-12-06 14:48:14.519118+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.519202+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->preBuffer从socket读入193个字节
 2017-12-06 14:48:14.519445+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入38个字节
 2017-12-06 14:48:14.519651+0800 ServerAsncSocket[5148:888958] 读头成功,包长:6
 2017-12-06 14:48:14.519784+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.519874+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.519950+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 14:48:14.520035+0800 ServerAsncSocket[5148:888958] 收到消息:猪头
 2017-12-06 14:48:14.520159+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.520263+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.520378+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入38个字节
 2017-12-06 14:48:14.520628+0800 ServerAsncSocket[5148:888958] 读头成功,包长:6
 2017-12-06 14:48:14.520754+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.520809+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.520858+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入6个字节
 2017-12-06 14:48:14.521022+0800 ServerAsncSocket[5148:888958] 收到消息:先生
 2017-12-06 14:48:14.521179+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.521390+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.521552+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入39个字节
 2017-12-06 14:48:14.521814+0800 ServerAsncSocket[5148:888958] 读头成功,包长:15
 2017-12-06 14:48:14.522011+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.522232+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.522334+0800 ServerAsncSocket[5148:891324] zc func call-->dispatch_suspend(readSource)
 2017-12-06 14:48:14.522647+0800 ServerAsncSocket[5148:891324] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.522845+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.522938+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入15个字节
 2017-12-06 14:48:14.523062+0800 ServerAsncSocket[5148:888958] 收到消息:今天天气好
 2017-12-06 14:48:14.523287+0800 ServerAsncSocket[5148:891324] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.523389+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.523588+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入39个字节
 2017-12-06 14:48:14.523924+0800 ServerAsncSocket[5148:888958] 读头成功,包长:12
 2017-12-06 14:48:14.524030+0800 ServerAsncSocket[5148:891324] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.524117+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.524305+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入12个字节
 2017-12-06 14:48:14.524497+0800 ServerAsncSocket[5148:888958] 收到消息:吃饭了吗
 2017-12-06 14:48:14.524683+0800 ServerAsncSocket[5148:891324] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.524831+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.525071+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->preBuffer从socket读入1448个字节
 2017-12-06 14:48:14.525197+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入44个字节
 2017-12-06 14:48:14.525336+0800 ServerAsncSocket[5148:891324] zc func call-->恢复对source的监听
 2017-12-06 14:48:14.525356+0800 ServerAsncSocket[5148:888958] 读头成功,包长:1109832
 2017-12-06 14:48:14.525566+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 8688
 2017-12-06 14:48:14.525863+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.526042+0800 ServerAsncSocket[5148:889071] zc func call-->dispatch_suspend(readSource)
 2017-12-06 14:48:14.526234+0800 ServerAsncSocket[5148:889071] zc func call -- 新建packet再次读取
 2017-12-06 14:48:14.526404+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.526536+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入1404个字节
 2017-12-06 14:48:14.526701+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入8688个字节
 2017-12-06 14:48:14.526855+0800 ServerAsncSocket[5148:889071] zc func call-->恢复对source的监听
 2017-12-06 14:48:14.527880+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.528012+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.528104+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.528372+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.528542+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.528767+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.528933+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.529093+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.529233+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.544852+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.545118+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.545420+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.545574+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 5792
 2017-12-06 14:48:14.545941+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.546072+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入5792个字节
 2017-12-06 14:48:14.546212+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.546500+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.546738+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.551720+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.551925+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.552211+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.552321+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.552498+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.552715+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.556588+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.556969+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.557176+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.557316+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.557448+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.557729+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.572212+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.572465+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.573085+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.573699+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.573859+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.574012+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.603172+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.603619+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.604017+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.604174+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 10136
 2017-12-06 14:48:14.604571+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.604718+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入10136个字节
 2017-12-06 14:48:14.606191+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.606292+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.606682+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.607019+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 13032
 2017-12-06 14:48:14.607111+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.607373+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入13032个字节
 2017-12-06 14:48:14.609855+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.609966+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.610173+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.616190+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.616398+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.616551+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.616648+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.616705+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.616842+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.618131+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.618258+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.618381+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.618497+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.734180+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.734631+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.735175+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 172312
 2017-12-06 14:48:14.736607+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.737079+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入172312个字节
 2017-12-06 14:48:14.748398+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.749203+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.749518+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.749852+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 15928
 2017-12-06 14:48:14.749995+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.750338+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入15928个字节
 2017-12-06 14:48:14.750603+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 8688
 2017-12-06 14:48:14.750765+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.751000+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入8688个字节
 2017-12-06 14:48:14.782520+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 146248
 2017-12-06 14:48:14.783237+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.783510+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入146248个字节
 2017-12-06 14:48:14.783901+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 11584
 2017-12-06 14:48:14.784083+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.784180+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入11584个字节
 2017-12-06 14:48:14.787070+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.787201+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.787305+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.787513+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.787696+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.787911+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.788420+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 8688
 2017-12-06 14:48:14.788560+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.788735+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入8688个字节
 2017-12-06 14:48:14.788906+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 7240
 2017-12-06 14:48:14.789028+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.789200+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入7240个字节
 2017-12-06 14:48:14.789382+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 7240
 2017-12-06 14:48:14.789625+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.793108+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入7240个字节
 2017-12-06 14:48:14.793227+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 15928
 2017-12-06 14:48:14.793473+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.793685+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入15928个字节
 2017-12-06 14:48:14.808711+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 1448
 2017-12-06 14:48:14.808989+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.809297+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入1448个字节
 2017-12-06 14:48:14.809662+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 11584
 2017-12-06 14:48:14.809754+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.809950+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入11584个字节
 2017-12-06 14:48:14.829375+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 4344
 2017-12-06 14:48:14.829946+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.830347+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入4344个字节
 2017-12-06 14:48:14.830544+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 13032
 2017-12-06 14:48:14.830968+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.831227+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入13032个字节
 2017-12-06 14:48:14.831339+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 5792
 2017-12-06 14:48:14.831597+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.832091+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入5792个字节
 2017-12-06 14:48:14.832310+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 15928
 2017-12-06 14:48:14.832513+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.832911+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入15928个字节
 2017-12-06 14:48:14.833204+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 10136
 2017-12-06 14:48:14.833440+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.833760+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入10136个字节
 2017-12-06 14:48:14.833877+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 10136
 2017-12-06 14:48:14.834078+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.834424+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入10136个字节
 2017-12-06 14:48:14.834574+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 11584
 2017-12-06 14:48:14.834774+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.834927+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入11584个字节
 2017-12-06 14:48:14.967429+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 441896
 2017-12-06 14:48:14.967664+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.968289+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入441896个字节
 2017-12-06 14:48:14.982728+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 2896
 2017-12-06 14:48:14.982976+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.983196+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入2896个字节
 2017-12-06 14:48:14.983342+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 11584
 2017-12-06 14:48:14.983479+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:14.983684+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入11584个字节
 2017-12-06 14:48:14.983875+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 8688
 2017-12-06 14:48:14.984197+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:14.984387+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入8688个字节
 2017-12-06 14:48:14.984519+0800 ServerAsncSocket[5148:889071] zc func call-->source_handler trigger datalength = 8688
 2017-12-06 14:48:15.020738+0800 ServerAsncSocket[5148:889071] zc func call-->doReadData
 2017-12-06 14:48:15.021098+0800 ServerAsncSocket[5148:889071] zc func call -- READ FROM SOCKET -->currentRead从socket读入8688个字节
 2017-12-06 14:48:15.021307+0800 ServerAsncSocket[5148:891324] zc func call-->source_handler trigger datalength = 56924
 2017-12-06 14:48:15.021377+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:15.021544+0800 ServerAsncSocket[5148:891324] zc func call -- READ FROM SOCKET -->currentRead从socket读入56924个字节
 2017-12-06 14:48:15.021776+0800 ServerAsncSocket[5148:888958] 图片设置成功
 2017-12-06 14:48:15.320556+0800 ServerAsncSocket[5148:891324] zc func call -- 新建packet再次读取
 2017-12-06 14:48:15.320836+0800 ServerAsncSocket[5148:891324] zc func call-->doReadData
 2017-12-06 14:48:15.327784+0800 ServerAsncSocket[5148:891324] zc func call -- socket与preBuffer都没有可读数据
 */
