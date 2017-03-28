package photoGallery;

import java.sql.Timestamp;

	public class DB {
	
		private String name;
		private String passwd;
	    private String email;
	    private String homepage;
	    private String title;
	    private String content;
	    private String uploadfile;
	    private Timestamp reg_date;
		
	    public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getPasswd() {
			return passwd;
		}
		public void setPasswd(String passwd) {
			this.passwd = passwd;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getHomepage() {
			return homepage;
		}
		public void setHomepage(String homepage) {
			this.homepage = homepage;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getUploadfile() {
			return uploadfile;
		}
		public void setUploadfile(String uploadfile) {
			this.uploadfile = uploadfile;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
	       
	    
}
