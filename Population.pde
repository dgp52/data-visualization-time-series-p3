// Population class/tab
class Population extends Visual {

  // Column name from CSV file
  // Using this we can find and loop through each country
  final String header = "Population_";

  // Year Interval for x-axis
  final int yearInterval = 10; 

  // Major tick internval (eg: 50, 100, 150...)
  final float yMajorIntervalTick = 50;
  // Minor tick interval (eg: 25, 75, 125...)
  final float yMinorIntervalTick = 25;

  // Holds the min and max value from overall Population columns
  float minYVal = 0; 
  //  float maxYVal = 320.0;
  float maxYVal = 0; 

  // Constructor
  Population(String t, String d, String labelX, String labelY, boolean clicked, boolean gridFlag, PShape cm, ArrayList<Country> c) {
    //Call super contructor. Bascially, call the contructor of class Visual because this class extends Visual class and it is also the parent class.
    super(t, d, labelX, labelY, clicked, gridFlag, cm, c);
  }

  // Overload the constructor because we want data in this class
  Population(String t, String d, String labelX, String labelY, boolean clicked, boolean gridFlag, Table data, PShape cm, ArrayList<Country> c) {
    // Call the above constructor
    this(t, d, labelX, labelY, clicked, gridFlag, cm, c);
    // Before drawing anything, we want to compute the min value and the max value to get the range for the Y-axis
    computeMinMaxYVal(data);
  }

  // Draw description based on the x, y position
  void drawDescription(float x, float y) {
    textSize(descriptionSize);
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    text(description, x, y);
  }

  // Draw label for x-axis based on the x, y position
  void drawXAxisLabel(float x, float y) {
    textSize(axisLabelSize);
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    text(xLabel, x, y);
  }

  // Draw label for y-axis based on the x, y position
  void drawYAxisLabel(float x, float y) {
    textSize(axisLabelSize);
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    pushMatrix();
    translate(x, y);
    // Rotate y-label vertically
    rotate(-PI/2);
    text(yLabel, 0, 0);
    popMatrix();
  }

  // Draw data label for x-axis (eg: 1960, 1970...)
  void drawXAxisDataLabel(Table data, float paneX, float paneY, float paneWidth, float paneHeight) {
    // Only draw the grid if the flag is true, this flag comes fom Visual class
    if (getShowGrid()) {
      stroke(224);
      strokeWeight(2);
    }

    // Get min and max year
    int minYear = data.getRow(0).getInt(yearHeader);
    int maxYear = data.getRow(data.getRowCount() - 1).getInt(yearHeader);
    for (int i = 0; i < data.getRowCount(); i++) {
      int year = data.getRow(i).getInt(yearHeader);
      //If the modulo is zero then draw year and the grid
      if (year % yearInterval == 0) {
        float mappedVal = map(year, minYear, maxYear, paneX, paneWidth);
        textAlign(CENTER, CENTER);
        //draw year
        text(year, mappedVal, paneY + paneHeight + 15);
        if (getShowGrid() && i != 0) {
          //Draw vertical line
          line(mappedVal, paneY, mappedVal, paneY + paneHeight + 15);
        }
      }
    }
  }

  // Draw data label for y-axis (eg: 25, 50, 75...)
  void drawYAxisDataLabel(Table data, float paneX, float paneY, float paneHeight) {
    stroke(0);
    strokeWeight(1);

    // Start from minYvalue, draw minor and major ticks until it reaches the maxYvalue
    for (float i = minYVal; i <= maxYVal; i+= yMinorIntervalTick) {
      if (i % yMinorIntervalTick == 0) {
        // Map value within the height of the pane
        float mappedVal = map(i, minYVal, maxYVal, paneY+paneHeight, paneY);
        if (i % yMajorIntervalTick == 0) {
          //Draw value and major tick
          text(floor(i), paneX - 25, mappedVal - 3);
          line(paneX - 6, mappedVal, paneX, mappedVal);
        } else {
          //Only draw minor tick
          line(paneX - 3, mappedVal, paneX, mappedVal);
        }
      }
    }
  }


  // Use this method to compute min and max value for y-axis
  void computeMinMaxYVal(Table data) {
    for (int i = 0; i < data.getRowCount(); i++) { 
      for (int j = 0; j < countries.size(); j++) {
        // Exclude the country column if it's not visible
        if (!countries.get(j).getIsVisible()) {
          continue;
        }
        if (data.getRow(i).getFloat(header + countries.get(j).getCountryName()) > maxYVal) {
          // Update the global Max value
          maxYVal = data.getRow(i).getFloat(header + countries.get(j).getCountryName());
        }
        if (minYVal == 0.0) {
          // Initially the min value starts at 0.0, therefore get the first value it finds
          minYVal = data.getRow(i).getFloat(header + countries.get(j).getCountryName());
        } else if (data.getRow(i).getFloat(header + countries.get(j).getCountryName()) < minYVal) {
          // Update the global min value
          minYVal = data.getRow(i).getFloat(header + countries.get(j).getCountryName());
        }
      }
    }

    // Since the major and minor ticks rely on modulo, increment the max value until it becomes zero
    maxYVal = round(maxYVal + yMajorIntervalTick); 
    while (maxYVal % yMajorIntervalTick != 0) {
      maxYVal += 1;
    }

    // Similarly, decrement the min value until it becomes zero
    minYVal = round(minYVal - yMajorIntervalTick);
    while (minYVal % yMajorIntervalTick != 0) {
      minYVal -= 1;
    }
    if (minYVal < 0 ) {
      minYVal = 0;
    }
  }

  // Draw dataline for each country
  void drawDataLine(Table data, float paneX, float paneY, float paneWidth, float paneHeight) {
    float minYear = data.getRow(0).getFloat(yearHeader);
    float maxYear = data.getRow(data.getRowCount() - 1).getFloat(yearHeader);

    for (int i = 0; i < countries.size(); i++) {

      // Only draw this country if this flag is true
      if (!countries.get(i).getIsVisible()) {
        continue;
      }

      // Get the color for the country
      stroke(countries.get(i).getCountryColor());
      noFill();
      strokeWeight(2);

      // Draw line using begin and end shape
      beginShape();
      for (int j = 0; j < data.getRowCount(); j++) {
        float countryVal = data.getRow(j).getFloat(header + countries.get(i).getCountryName());
        // Compute x (based on year) and y (based on country value)
        float x = map(data.getRow(j).getFloat(yearHeader), minYear, maxYear, paneX, paneWidth);
        float y = map(countryVal, minYVal, maxYVal, paneHeight + paneY, paneY);
        vertex(x, y);
      }
      endShape();
    }
  }

  // Draw rollovers for each country
  void drawRollovers(Table data, float paneX, float paneY, float paneWidth, float paneHeight) {
    float minYear = data.getRow(0).getFloat(yearHeader);
    float maxYear = data.getRow(data.getRowCount() - 1).getFloat(yearHeader);

    for (int i = 0; i < countries.size(); i++) {

      // Only show rollover if the country is visible
      if (!countries.get(i).getIsVisible()) {
        continue;
      }

      stroke(countries.get(i).getCountryColor());

      for (int j = 0; j < data.getRowCount(); j++) {
        float countryVal = data.getRow(j).getFloat(header + countries.get(i).getCountryName());
        //Compute x (based on year) and y (based on country value)
        float x = map(data.getRow(j).getFloat(yearHeader), minYear, maxYear, paneX, paneWidth);
        float y = map(countryVal, minYVal, maxYVal, paneHeight + paneY, paneY);
        if (dist(mouseX, mouseY, x, y) < 5) {
          //Draw circle if mouse x,y and line x,y distance is less than 5
          fill(countries.get(i).getCountryColor());
          circle(x, y, 10);
          textSize(rolloverPointSize);
          textAlign(CENTER);
          fill(0);
          text(nf(countryVal, 0, 2) + " (" + data.getRow(j).getInt(yearHeader) + ")", x, y - 10);
          textAlign(LEFT);
        }
      }
    }
  }

  void resetMinMaxYValue() {
    minYVal = 0.0;
    maxYVal = 0.0;
  }

  void drawLegend(float x, float y, float w, float h) {
    // Legend Container
    fill(255);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h, 10);

    // Check if checkbox grid object already exist, if not then add it
    float gridCheckboxX = x+10;
    float gridCheckboxY = y+10;
    float checkboxSize = 20.0;
    if (checkboxes.size() == 0) {
      Checkbox gridCheckbox = new Checkbox(1, "Gridlines", gridCheckboxX, gridCheckboxY, checkboxSize, checkboxSize, getCheckMark());
      checkboxes.add(gridCheckbox);
    }

    // Draw a divider
    line(x + 10, gridCheckboxY + checkboxSize + 10, (x+w) - 10, gridCheckboxY + checkboxSize + 10);

    float labelYPos = gridCheckboxY + checkboxSize + 40;

    // Countries checkboxes
    int counter = 0;
    // Starts from 2 because grid checkbox is already added with id = 1
    int id = 2;
    while (checkboxes.size() < countries.size()+1) {
      Checkbox countryCheckbox = new Checkbox(id, "", gridCheckboxX, labelYPos + 20 + (counter * 30), checkboxSize, checkboxSize, getCheckMark());
      checkboxes.add(countryCheckbox);      
      id++;
      counter++;
    }

    for (int i = 0; i < checkboxes.size(); i++) {
      // Draw all checkboxes
      checkboxes.get(i).drawCheckbox();

      // Draw colored box and countries label
      if (i > 0) {
        fill(countries.get(i-1).getCountryColor());
        stroke(141);
        strokeWeight(1);
        rect(gridCheckboxX + 30, labelYPos + 20 + ((i-1) * 30), checkboxSize, checkboxSize);

        textSize(20);
        fill(0);
        textAlign(LEFT, CENTER);
        text(countries.get(i-1).getCountryName(), gridCheckboxX + checkboxSize + 40, labelYPos + 30 + ((i-1) * 30));
      }
    }

    // Draw label and countries checkbox. Not sure why it wont render before the while loop?
    textSize(20);
    fill(0);
    textAlign(CENTER);
    text("Countries", x+(w/2), labelYPos);
  }
}
