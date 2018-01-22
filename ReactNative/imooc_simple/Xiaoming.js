import Student from './Student'

export default class Xiaoming extends Student{
    constructor(){
        super('xiaoming','男',22)
    }
    getDescription(){
        return 'zc头'+super.getDescription()
    }
}