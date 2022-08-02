
String[] COLUMN = {"A", "B", "C", "D", "E", "F", "G", "H"};

public class Point {
   public float x, y;
   
   public Point(float x, float y) {
      this.x = x;
      this.y = y;
   }
   
   public Point clone() {
      return new Point(x, y); 
   }
   
   public boolean equals(Point other) {
      return this.x == other.x && this.y == other.y; 
   }
   
   public String toString() {
     return toString(true);
   }
   
   public String toString(boolean chess) {
     //try {
     if(chess) {
       return COLUMN[(int)x] + Integer.toString((int)(8 - y));
     } else return Float.toString(x) + ", " + Float.toString(y);
     //} catch(ArrayIndexOutOfBoundsException e) {
     //   e.printStackTrace(); 
     //   return "";
     //}
   }
   
   public Point add(float x, float y) {
      return new Point(this.x + x, this.y + y); 
   }
   
   public Point add(Point p) {
      return add(p.x, p.y); 
   }
   
   public Point sub(float x, float y) {
      return add(-x, -y); 
   }
   
   public Point sub(Point p) {
      return sub(-p.x, -p.y); 
   }
}
