//Parent class for all the tabs and it implements IVisual interface 
public abstract class Visual implements IVisual {
  //This field is the year column name in CSV
  final String yearHeader = "Year";
  
  //Title for current tab
  String title;
  //Description for current tab
  String description;
  //Label for X-Axis
  String xLabel;
  //Label for Y-Axis
  String yLabel;
  
  //List of Countries for the current tab
  ArrayList<Country> countries;
  
  //Flag to capture if current tab is clicked or not
  boolean isClicked;
  //Flag to turn on/off grid for this tab
  boolean showGrid;
  
  //Checkmark shape
  PShape checkmark;
  
  //List to hold all checkboxs, 0th position is the grid checkbox and the rest are countries
  ArrayList<Checkbox> checkboxes;
  
  //Fonts and rollover point size
  final int descriptionSize = 20;
  final int axisLabelSize = 15;
  final int rolloverPointSize = 20;
    
  //Constructor
  public Visual(String t, String d, String labelX, String labelY, boolean clicked,  boolean gridFlag, PShape cm, ArrayList<Country> c){
    title = t;
    description = d;
    xLabel = labelX;
    yLabel = labelY;
    isClicked = clicked;
    countries = c;
    showGrid = gridFlag;
    checkmark = cm;
    checkboxes = new ArrayList<Checkbox>();
  }
    
  //Get title
  public String getTitle(){
    return title;
  }
  
  //Get description
  public String getDescription(){
    return description;
  }
  
  //Get xLabel
  public String getXLabel(){
    return xLabel;
  }
  
  //Get yLabel
  public String getYLabel(){
    return yLabel;
  }
  
  //Get isClicked flag
  public boolean getIsClicked(){
    return isClicked;
  }
  
  //Get showGrid flag
  public boolean getShowGrid(){
    return showGrid;
  }
  
  //Get checkMark shape
  public PShape getCheckMark(){
    return checkmark;
  }
  
  //Get checkboxes
  public ArrayList<Checkbox> getCheckboxes(){
    return checkboxes;
  }
  
  //Get countries
  public ArrayList<Country> getCountries(){
    return countries;
  }
  
  //Set isClicked flag
  public void setIsClicked(boolean clicked){
    isClicked = clicked;
  }
  
  //set showGrid flag
  public void setShowGrid(boolean gridFlag){
    showGrid = gridFlag;
  }
  
  public void setCountries(ArrayList<Country> cs) {
    countries = cs;
  }
}
