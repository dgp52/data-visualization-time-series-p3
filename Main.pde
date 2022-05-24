// List to hold all Visual objects and buttons
ArrayList<Visual> visuals;
ArrayList<Button> buttons;

// Dataset
Table data;

// Width/height for the window
final int WIDTH = 1300;
final int HEIGHT = 800;

// Pane width and height (White pane on which the actual graph is drawn)
final float PANEWIDTH = WIDTH-(WIDTH*0.3);
final float PANEHEIGHT = HEIGHT-(HEIGHT*0.35);

// Overall title
final String TITLE = "Population Wellness and Growth over Time";

void setup() {
  
  // Unable to pass in global width and height so hard-coded instead
  size(1300, 800);

  // Initialize the list
  visuals = new ArrayList<Visual>();
  buttons = new ArrayList<Button>();
  
  // Import data
  data = loadTable("TimeSeries.csv", "header");
  
  // Import checkmark svg
  PShape checkmark = loadShape("checkmark.svg");

  // Add 3 attributes in this array
  // Add LifeExpectancy
  visuals.add(new LifeExpectancy(
    "Life Expectancy", //Tab title
    "The above plot shows the life expectancy rates of the selected countries for a particular year", //Tab description
    "Year", //Tab X axis label
    "Life expectancy at birth (Years)", //Tab Y axis label
    true, //Flag to capture tab click
    true, //Flag to toggle grid
    data, // dataset
    checkmark, 
    new ArrayList<Country>(getCountriesForTab("LifeExpectancy")) //Creates a new list of countries defined earlier
    )
    );

  // Add FertilityRate
  visuals.add(new FertilityRate(
    "Fertility Rate", 
    "The above plot shows the average fertility rates of the selected countries for a particular year", 
    "Year", 
    "Fertility rate (births per woman)", 
    false, 
    true, 
    data, // dataset
    checkmark, 
    new ArrayList<Country>(getCountriesForTab("FertilityRate"))
    )
    );

  // Add Population
  visuals.add(new Population(
    "Population", 
    "The above plot shows the populations of the selected countries for a particular year", 
    "Year", 
    "Population (per million people)", 
    false, 
    true, 
    data, 
    checkmark, 
    new ArrayList<Country>(getCountriesForTab("Population"))
    )
    );

  // Buttons/tabs
  for (int i = 0; i < visuals.size(); i++) {
    Visual currentVisual = visuals.get(i);
    int buttonWidth = 130;
    //Draw tab/button for each visual
    Button button = new Button(currentVisual.getTitle(), WIDTH-(WIDTH*0.93) + (buttonWidth * i), HEIGHT-(HEIGHT*0.89), buttonWidth, 50, currentVisual.getIsClicked() ? color(255) : color(224));
    buttons.add(button);
  }
}

void draw() {
  // Draw tabs and pane
  background(224);
  drawTabs();
  drawPane();

  // Draw Title
  textSize(30);
  fill(0, 0, 0);
  textAlign(CENTER, CENTER);
  
  // Position the title with respect to Pane width and global height
  text(TITLE, (buttons.get(0).getButtonXPos() + PANEWIDTH)/2, HEIGHT - (HEIGHT * 0.95));

  for (int i = 0; i < visuals.size(); i++) {    
    // Check if the current visual is clicked
    if (visuals.get(i).getIsClicked()) {
      // Use this button as an anchor point
      Button b = buttons.get(0);
      
      // Check the instance of current visual (Check if the current tab is lifeExpectancy)
      if (visuals.get(i) instanceof LifeExpectancy) {
        // Because each tab extends Visual class, we can use the idea of Java polymorphism. So simply downcast the object it gets.
        LifeExpectancy lifeExpectancy = (LifeExpectancy)visuals.get(i);
        // Call every interface method that is implemented in this class
        lifeExpectancy.drawDescription((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 70);
        lifeExpectancy.drawXAxisLabel((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 40);
        lifeExpectancy.drawYAxisLabel(b.getButtonXPos() - 60, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT)/2);
        lifeExpectancy.drawXAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        lifeExpectancy.drawYAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEHEIGHT);
        lifeExpectancy.drawDataLine(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        lifeExpectancy.drawRollovers(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        lifeExpectancy.drawLegend(b.getButtonXPos() + PANEWIDTH + 15, b.getButtonYPos() + b.getHeight(), WIDTH - (WIDTH* 0.8), HEIGHT - (HEIGHT * 0.69));
      } else if (visuals.get(i) instanceof FertilityRate) {
        // Current tab is Fertility rate
        FertilityRate fertilityRate = (FertilityRate)visuals.get(i);
        fertilityRate.drawDescription((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 70);
        fertilityRate.drawXAxisLabel((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 40);
        fertilityRate.drawYAxisLabel(b.getButtonXPos() - 60, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT)/2);
        fertilityRate.drawXAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        fertilityRate.drawYAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEHEIGHT);
        fertilityRate.drawDataLine(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        fertilityRate.drawRollovers(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        fertilityRate.drawLegend(b.getButtonXPos() + PANEWIDTH + 15, b.getButtonYPos() + b.getHeight(), WIDTH - (WIDTH* 0.8), HEIGHT - (HEIGHT * 0.69));
      } else {
        // Current tab is population
        Population population = (Population)visuals.get(i);
        // Call every interface method that is implemented in this class
        population.drawDescription((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 70);
        population.drawXAxisLabel((b.getButtonXPos() + PANEWIDTH)/2, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT) + 40);
        population.drawYAxisLabel(b.getButtonXPos() - 60, (b.getButtonYPos() + b.getHeight() + PANEHEIGHT)/2);
        population.drawXAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        population.drawYAxisDataLabel(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEHEIGHT);
        population.drawDataLine(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        population.drawRollovers(data, b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
        population.drawLegend(b.getButtonXPos() + PANEWIDTH + 15, b.getButtonYPos() + b.getHeight(), WIDTH - (WIDTH * 0.8), HEIGHT - (HEIGHT * 0.69));
      }
    }
  }
}

// On mouse pressed
void mousePressed() {

  // Check which button/tab is clicked
  for (int i = 0; i < buttons.size(); i++) {
    if (buttons.get(i).mouseIsOver()) {
      // If the mouse is within a tab/button, update color for the current tab and also update colors for other buttons
      buttons.get(i).setBackgroundColor(255);
      visuals.get(i).setIsClicked(true);
      updateAdditionalBtns(i);
    }
  }

  // Check which checbox is clicked
  for (int i = 0; i < visuals.size(); i++) {
    // Check which tab is currently visible/clicked
    if (visuals.get(i).getIsClicked()) {
      for (int j = 0; j < visuals.get(i).getCheckboxes().size(); j++) {
        // Check which checkbox is clicked in this tab
        if (visuals.get(i).getCheckboxes().get(j).mouseIsOver()) {
          // Found the checkbox
          Checkbox clickedCheckbox = visuals.get(i).getCheckboxes().get(j);
          if (clickedCheckbox.getCheckboxId() == 1) {
            // This is grid checkbox
            visuals.get(i).setShowGrid(clickedCheckbox.getCheckboxIsChecked() ? false : true);
          } else {
            // Countries checkboxes
            // Subtract one to exclude grid checkbox
            visuals.get(i).getCountries().get(j-1).setIsVisible(!clickedCheckbox.getCheckboxIsChecked());
            
            // Compute min and max for y-axis
            if(visuals.get(i) instanceof LifeExpectancy) {
              LifeExpectancy lifeExpectancy = (LifeExpectancy)visuals.get(i);
              lifeExpectancy.resetMinMaxYValue();
              lifeExpectancy.computeMinMaxYVal(data);
            } else if (visuals.get(i) instanceof FertilityRate) {
              FertilityRate fertilityRate = (FertilityRate)visuals.get(i);
              fertilityRate.resetMinMaxYValue();
              fertilityRate.computeMinMaxYVal(data);
            } else {
              Population population = (Population)visuals.get(i);
              population.resetMinMaxYValue();
              population.computeMinMaxYVal(data);
            }
          }
          visuals.get(i).getCheckboxes().get(j).setCheckboxIsChecked(!clickedCheckbox.getCheckboxIsChecked());
        }
      }
    }
  }
}

// Draw each button/tab
void drawTabs() {  
  for (int i = 0; i < buttons.size(); i++) {
    buttons.get(i).drawButton();
  }
}

// Draw white pane, this pane is where we actually draw datapoints
void drawPane() {
  Button b = buttons.get(0);
  fill(255);
  noStroke();
  rect(b.getButtonXPos(), b.getButtonYPos() + b.getHeight(), PANEWIDTH, PANEHEIGHT);
}

// Update color and IsClicked flag for each button to show that is it no longer clicked. Only exception is the current tab
void updateAdditionalBtns(int except) {
  for (int i = 0; i < buttons.size(); i++) {
    if (i != except) {
      buttons.get(i).setBackgroundColor(224);
      visuals.get(i).setIsClicked(false);
    }
  }
}

ArrayList<Country> getCountriesForTab(String tab){
  ArrayList<Country> result = new ArrayList<Country>();
  switch(tab){
    case "LifeExpectancy":
      // Add countries to this new list
      // Pass Country name, visibility flag and color
      result.add(new Country("Brazil", true, color(#82b74b)));
      result.add(new Country("Indonesia", true, color(#034f84)));
      result.add(new Country("Pakistan", true, color(#c94c4c)));
      result.add(new Country("Russian Federation", true, color(#ff8500)));
      result.add(new Country("United States", true, color(#6b5b95)));
    break;
    case "FertilityRate":
      // Pass Country name, visibility flag and color
      result.add(new Country("Brazil", true, color(#82b74b)));
      result.add(new Country("Indonesia", true, color(#034f84)));
      result.add(new Country("Pakistan", true, color(#c94c4c)));
      result.add(new Country("Russian Federation", true, color(#ff8500)));
      result.add(new Country("United States", true, color(#6b5b95)));
    break;
    case "Population":
      // Pass Country name, visibility flag and color
      result.add(new Country("Brazil", true, color(#82b74b)));
      result.add(new Country("Indonesia", true, color(#034f84)));
      result.add(new Country("Pakistan", true, color(#c94c4c)));
      result.add(new Country("Russian Federation", true, color(#ff8500)));
      result.add(new Country("United States", true, color(#6b5b95)));
    break;
  }
  return result;
}
