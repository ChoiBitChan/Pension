package reservation;

public class RoomBean {
	String rname = "";
	int rno,rsize,men,weekday,weekend,sweekday,sweekend,addman;
	
	public int getAddman() {
		return addman;
	}
	public void setAddman(int addman) {
		this.addman = addman;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getRsize() {
		return rsize;
	}
	public void setRsize(int rsize) {
		this.rsize = rsize;
	}
	public int getMen() {
		return men;
	}
	public void setMen(int men) {
		this.men = men;
	}
	public int getWeekday() {
		return weekday;
	}
	public void setWeekday(int weekday) {
		this.weekday = weekday;
	}
	public int getWeekend() {
		return weekend;
	}
	public void setWeekend(int weekend) {
		this.weekend = weekend;
	}
	public int getSweekday() {
		return sweekday;
	}
	public void setSweekday(int sweekday) {
		this.sweekday = sweekday;
	}
	public int getSweekend() {
		return sweekend;
	}
	public void setSweekend(int sweekend) {
		this.sweekend = sweekend;
	}
}
