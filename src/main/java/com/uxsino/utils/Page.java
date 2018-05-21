package com.uxsino.utils;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Page<T> {

	// 总记录数
	private int total=0;

	// 每页记录数
	private int record=20;

	// 总页数
	private int totalPage=1;

	// 当前页数
	private int currentPage=1;

	// 开始记录数
	private int start;

	// 结束记录数
	private int end;
	
	private List<T> list;
	
	/*public Page(int record, int total) {
		this.record = record;
		this.total = total;
		// 计算总页数
		totalPage = total % record == 0 ? total / record : total / record + 1;
	}*/

	public void computeByCurrentPage(int cPage) {
		if(cPage<=0){
			currentPage=1;
		}else if(cPage>totalPage){
			currentPage=totalPage;
		}else{
			currentPage=cPage;
		}
		start = (currentPage - 1) * record + 1;
		
		end = currentPage * record;
		if(end>total){
			end=total;
		}
	}
	
	public void computeByPrivous(){
		currentPage=currentPage-1;
		if(currentPage<1){
			currentPage=1;
		}
		computeByCurrentPage(currentPage);
	}
	public void computeByNext(){
		currentPage=currentPage+1;
		if(currentPage>totalPage){
			currentPage=totalPage;
		}
		computeByCurrentPage(currentPage);
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecord() {
		return record;
	}

	public void setRecord(int record) {
		this.record = record;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
}
