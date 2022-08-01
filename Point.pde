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
}
