class Button {
  //Label for this button
  String label;
  
  //Position and width/height
  float x;
  float y;
  float w;
  float h;
  
  //Background color
  color backgroundColor;
  
  //Constructor
  Button(String labelB, float xpos, float ypos, float widthBtn, float heightBtn, color backColor) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthBtn;
    h = heightBtn;
    backgroundColor = backColor;
  }
  
  //Draw the button
  void drawButton() {
    fill(backgroundColor);
    stroke(backgroundColor);
    rect(x, y, w, h, 0);
    textSize(15);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x+(w/2), y+(h/2));
  }
  
  //Return true if Mouse is within button area, otherwise false
  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
  
  //Set a background color for this button
  void setBackgroundColor(color c){
    backgroundColor = c;
    fill(backgroundColor);
  }
  
  //Get button X position
  float getButtonXPos(){
    return x;
  }
  
  //Get button Y position
  float getButtonYPos(){
    return y;
  }
  
  //Get button height
  float getHeight(){
    return h;
  }
}
