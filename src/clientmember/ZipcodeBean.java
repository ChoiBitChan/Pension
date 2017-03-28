package clientmember;

public class ZipcodeBean {

	private String zipcode;	
	private String sido;
	private String gugun; 
	private String dong;
	private String ri;

	public void setZipcode(String zipcode){
		this.zipcode=zipcode; 
	}

	public void setSido(String sido){
		this.sido=sido; 
	}

	public void setGugun(String gugun){
		this.gugun=gugun; 
	}

	public void setDong(String dong){
		this.dong=dong; 
	}

	public void setRi(String ri){
		this.ri=ri; 
	}


    public String getZipcode(){
 		return zipcode; 
 	}

    public String getSido(){
 		return sido; 
 	}
	 public String getGugun(){
 		return gugun; 
 	}
	 public String getDong(){
 		return dong; 
 	}
	 public String getRi(){
 		return ri; 
 	}
}