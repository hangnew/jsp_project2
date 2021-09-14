package com.project02.world42.DTO;

public class MainDTO {

	private int mIdx;
	private String memid;
	private String mTitle;
	private String mImg;
	private String mPro;
	private int mToday;
	private int mTotal;
	private String mName;
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	private String m1chon;
	private int m1chonSize;
	private int macorn;
	public int getmIdx() {
		return mIdx;
	}
	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}
	public String getmImg() {
		return mImg;
	}
	public void setmImg(String mImg) {
		this.mImg = mImg;
	}
	public String getmPro() {
		return mPro;
	}
	public void setmPro(String mPro) {
		this.mPro = mPro;
	}
	public int getmToday() {
		return mToday;
	}
	public void setmToday(int mToday) {
		this.mToday = mToday;
	}
	public int getmTotal() {
		return mTotal;
	}
	public void setmTotal(int mTotal) {
		this.mTotal = mTotal;
	}
	public String getM1chon() {
		return m1chon;
	}
	public void setM1chon(String m1chon) {
		this.m1chon = m1chon;
		this.m1chonSize = m1chon.split(",").length;
	}
	public int getM1chonSize() {
		return m1chonSize;
	}
	public int getMacorn() {
		return macorn;
	}
	public void setMacorn(int macorn) {
		this.macorn = macorn;
	}
}
