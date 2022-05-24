class Checkbox {
  String label;
  int id;
  float x;
  float y;
  float w;
  float h;
  PShape icon;
  boolean isChecked;
  
  Checkbox(int cId, String cLabel, float xPos, float yPos, float cWidth, float cHeight, PShape cIcon){
    label = cLabel;
    id = cId;
    x = xPos;
    y = yPos;
    w = cWidth;
    h = cHeight;
    icon = cIcon;
    isChecked = true;
  }
  
  //Draw Checkbox;
  void drawCheckbox() {
    //Draw checkbox
    fill(255);
    stroke(141);
    strokeWeight(1);
    rect(x, y, w, h, 1);
    
    //Draw label
    textAlign(TOP,LEFT);
    fill(0);
    textSize(20);
    text(label, x+w+10, y + h);

    
    if(isChecked){
      shape(icon, x+2, y+2, w-3, h-3);
    }
  }
  
  //Check if mouse is over this button
  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
  
  //Get checkbox id
  int getCheckboxId(){
    return id;
  }
  
  //Get checkbox label
  String getCheckboxLabel(){
    return label;
  }
  
  //Get checkbox isChecked flag
  boolean getCheckboxIsChecked(){
    return isChecked;
  }
  
  //Set checkbox isChecked flag
  void setCheckboxIsChecked(boolean val){
    isChecked = val;
  }
  
}
