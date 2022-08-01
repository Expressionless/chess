public class Color {
   public final float red, green, blue, alpha;
  
    public Color(int red, int green, int blue) {
       this(red, green, blue, 255);
    }
  
   public Color(int red, int green, int blue, int alpha) {
     this.red = red;
     this.green = green;
     this.blue = blue;
     
     this.alpha = alpha;
   }
   
   public Color(float red, float green, float blue) {
      this(red, green, blue, 100.0); 
   }
   
   public Color(float red, float green, float blue, float alpha) {
     this.red = red;
     this.green = green;
     this.blue = blue;
     this.alpha = alpha;
   }
   
   
}
