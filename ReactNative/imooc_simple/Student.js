
export default class Student{
    constructor(name,sex,age){
        this.name = name;
        this.age = age;
        this.sex = sex;
    }
    getDescription(){
        return '名字:'+this.name+' 年龄:'+this.age+' 性别:'+this.sex
    }
}