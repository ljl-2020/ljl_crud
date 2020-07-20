/**
 * FileName: msg
 * Author: ljl
 * Date: 2020/7/18 21:32
 * Description: 通用返回的类
 * History:
 */


package com.ljl.crud.beans;

import java.util.HashMap;
import java.util.Map;

public class Msg {

    //100-成功，200-失败
    private  int codes;

    private  String msg;

    public int getCodes() {
        return codes;
    }

    public void setCodes(int codes) {
        this.codes = codes;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    private Map<String,Object> extend = new HashMap<>();

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public static Msg success(){
        Msg result = new Msg();
        result.setCodes(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCodes(200);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
