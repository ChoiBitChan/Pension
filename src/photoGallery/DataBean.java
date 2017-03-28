package photoGallery;

import java.sql.Timestamp;

public class DataBean{

	private int num; 
    private String name;
    private String title;
    private String email;
    private String homepage;
    private String content;
    private String passwd;
    private Timestamp reg_date;
    private int readcount;
    private String ip;
    private int ref;
    private int re_step;
    private int re_level;
    private String uploadfile;

    

	public void setNum(int num){
    	this.num=num;
    }
    public void setName (String name) {
        this.name = name;
    }
    public void setTitle (String title) {
        this.title = title;
    }
    public void setEmail (String email) {
        this.email = email;
    }
    public void setHomepage (String homepage) {
        this.homepage = homepage;
    }
    
    public void setContent (String content) {
        this.content = content;
    }
    public void setPasswd (String passwd) {
        this.passwd = passwd;
    }
    public void setReg_date (Timestamp reg_date) {
        this.reg_date = reg_date;
    }
	public void setReadcount(int readcount){
	  	this.readcount=readcount;
	}
    public void setIp (String ip) {
        this.ip = ip;
    }
	public void setRef (int ref) {
        this.ref = ref;
    }
	public void setRe_level (int re_level) {
        this.re_level=re_level;
    }
	public void setRe_step (int re_step) {
        this.re_step=re_step;
    }
	
	public void setUploadfile (String uploadfile) {
        this.uploadfile=uploadfile;
    }
    
    public int getNum(){
    	return num;
    }
    public int getReadcount(){
   	    return readcount;
    }
    public String getName () {
        return name;
    }
    public String getTitle () {
        return title;
    }
    public String getEmail () {
        return email;
    }
    
    public String getHomepage () {
        return homepage;
    }
    
    public String getContent () {
        return content;
    }
    public String getPasswd () {
        return passwd;
    }
    public Timestamp getReg_date () {
        return reg_date;
    }
    public String getIp () {
        return ip;
    }
    public int getRef () {
        return ref;
    }
	public int getRe_level () {
        return re_level;
    }
	public int getRe_step () {
        return re_step;
    }
    
	public String getUploadfile () {
        return uploadfile;
    }
}