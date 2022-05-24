public interface IVisual {
  //Method to draw description at the bottom
  void drawDescription(float x, float y);
  
  //Method to draw label for XAxis (eg: Year)
  void drawXAxisLabel(float x, float y);
  
  //Method to draw label for YAxis (eg: Life Expectancy at birth (Years))
  void drawYAxisLabel(float x, float y);
  
  //Method to draw data label for X axis (eg: 1960 , 1970 ...). In addition, it also takes care of drawing the grid
  void drawXAxisDataLabel(Table data, float x, float y, float w, float h);
  
  //Method to draw data label for Y axis (eg: 30 40). In addition, it also takes care of drawing major and minor ticks
  void drawYAxisDataLabel(Table data, float x, float y, float h);
  
  //Method to draw dataline for each country. Also, checks Country.IsVisble flag for cases where the country is not currently visible
  void drawDataLine(Table data, float x, float y, float w, float h);
  
  //Method to draw rollovers for each country
  void drawRollovers(Table data, float x, float y, float w, float h);
  
  //Method to draw country legend
  void drawLegend(float x, float y, float w, float h);
}
