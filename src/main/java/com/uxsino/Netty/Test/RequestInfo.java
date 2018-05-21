package com.uxsino.Netty.Test;

import java.util.Arrays;
/**
 * 发送消息对象
 * @author admin
 *
 */

public class RequestInfo {

    //数据包序号
    private char[] fragNO = new char[4];

    //总数据包
    private char[] totalFrag  = new char[4];

    //数据包发包序号
    private char[] seq  = new char[4];

    //协议命令
    private char orderType;

    //数据长度
    private char[] dateLength  = new char[4];

    //消息内容
    public char[] dateInfo = new char[1019];

    public RequestInfo(long fragNO, long totalFrag, long seq, char orderType, long dateLength, char[] dateInfo) {
        super();
        setFragNO(fragNO);
        setTotalFrag(totalFrag);
        setSeq(seq);
        this.orderType = orderType;
        setDateLength(dateLength);
        this.dateInfo = dateInfo;
    }


    public void setFragNO(long fragNO) {
        this.fragNO[0] = (char) (fragNO&0x000F);
        this.fragNO[1] = (char) ((fragNO>>8)&0x000F);
        this.fragNO[2] = (char) ((fragNO>>16)&0x000F);
        this.fragNO[3] = (char) ((fragNO>>24)&0x000F);
    }

    public void setTotalFrag(long totalFrag) {
        this.totalFrag[0] = (char) (totalFrag&0x000F);
        this.totalFrag[1] = (char) ((totalFrag>>8)&0x000F);
        this.totalFrag[2] = (char) ((totalFrag>>16)&0x000F);
        this.totalFrag[3] = (char) ((totalFrag>>24)&0x000F);
    }

    public void setSeq(long seq) {
        this.seq[0] = (char) (seq&0x000F);
        this.seq[1] = (char) ((seq>>8)&0x000F);
        this.seq[2] = (char) ((seq>>16)&0x000F);
        this.seq[3] = (char) ((seq>>24)&0x000F);
    }

    public char getOrderType() {
        return orderType;
    }

    public void setOrderType(char orderType) {
        this.orderType = orderType;
    }


    public void setDateLength(long dateLength) {
        this.dateLength[0] = (char) (dateLength&0x000F);
        this.dateLength[1] = (char) ((dateLength>>8)&0x000F);
        this.dateLength[2] = (char) ((dateLength>>16)&0x000F);
        this.dateLength[3] = (char) ((dateLength>>24)&0x000F);
    }

    public char[] getDateInfo() {
        return dateInfo;
    }

    public void setDateInfo(char[] dateInfo) {
        this.dateInfo = dateInfo;
    }

    public void setDateInfo(String str) {
        for(int i=0;i<str.length();i++)
        {
            this.dateInfo[i]=str.charAt(i);
        }
    }

    @Override
    public String toString() {
        return "RequestInfo [fragNO=" + Arrays.toString(fragNO) + ", totalFrag=" + Arrays.toString(totalFrag) + ", seq="
                + Arrays.toString(seq) + ", orderType=" + orderType + ", dateLength=" + Arrays.toString(dateLength)
                + ", dateInfo=" + Arrays.toString(dateInfo) + "]";
    }

    public RequestInfo() {
        super();
    }

}