ArrayList<ArrayList> columns = new ArrayList<ArrayList>();
ArrayList<ArrayList> rows = new ArrayList<ArrayList>();

int spacing= 40;
float max_distance;

void setup() {
  size(1280, 900, P3D);
  max_distance = dist(0, 0, width, height);

  for (int i = 0; i <= width; i += spacing) {
    var newColumn = new ArrayList<PVector>();
    for (int j = 0; j <= height; j += spacing) {
      newColumn.add(new PVector(i, j));
    }
    columns.add(newColumn);
  }
  
  for (int j = 0; j <= height; j += spacing) {
    var newRow = new ArrayList<PVector>();
    for (int i = 0; i <= width; i += spacing) {
      newRow.add(new PVector(i, j));
    }
    rows.add(newRow);
  }
}

void draw(ArrayList<PVector> vectors) {
  float prevX = vectors.get(0).x;
  float prevY = vectors.get(0).y;
  
  for (PVector v : vectors) {
      float dist = dist(v.x, v.y, mouseX, mouseY);
      float amt = map(dist, 0, width/2, 0.75, 0.0); 
      float x2 = lerp(v.x, mouseX, amt);
      float y2 = lerp(v.y, mouseY, amt);

      strokeWeight(2);
      stroke(255);

      if (v != vectors.get(0))
        line(prevX, prevY, x2, y2);

      prevX = x2;
      prevY = y2;
    }
}

void draw() {
  background(25);

  for (int i = 1; i < columns.size() - 1; i++) {
    ArrayList<PVector> thisColumn = columns.get(i);
    draw(thisColumn);
  }

  for (int i = 1; i < rows.size() - 1; i++) {
    ArrayList<PVector> thisRow = rows.get(i);
    draw(thisRow);
  }
}
