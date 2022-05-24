//Represents country object
class Country{
  
  //Name of the country
  String country;
  //flag to toggle the visibility
  boolean isVisible;
  //Color for this country
  color countryColor;
  
  //Constructor
  Country(String c, boolean flag, color cl){
    country = c;
    isVisible = flag;
    countryColor = cl;
  }
  
  //Get country name
  String getCountryName(){
    return country;
  }
  
  //Get country color  
  color getCountryColor(){
    return countryColor;
  }
  
  //Get IsVisible flag  
  boolean getIsVisible(){
    return isVisible;
  }
  
  //Set IsVisible flag
  void setIsVisible(boolean flag){
     isVisible = flag;
  }
}
