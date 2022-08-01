public class Tile {
   public static final int TILE_SIZE = 64; // px
   public final Color COL_WHITE = new Color(255, 230, 238); // 255 230 238
   public final Color COL_BLACK = new Color(253, 177, 230);
   
   public final color col;
   public final Point boardPos;
   public final Point screenPos;
   
   public Piece currentPiece;
   
   public Tile(int x, int y, float xOffset, float yOffset) {
      this(new Point(x, y), new Point(xOffset, yOffset)); 
   }
   
   public Tile(Point boardPos, Point offset) {
     
     this.boardPos = boardPos;
     screenPos = new Point(boardPos.x * TILE_SIZE + offset.x, boardPos.y * TILE_SIZE + offset.y);
     Color currentColor = ((boardPos.x + boardPos.y) % 2 == 0) ? COL_WHITE : COL_BLACK;
     col = color(currentColor.red, currentColor.green, currentColor.blue);
     
     this.currentPiece = null;
   }
   
   public void drawTile() {
      fill(col);
      noStroke();
      rect(screenPos.x, screenPos.y, TILE_SIZE, TILE_SIZE);
   }
   
   public void highlightTile(Color col) {
      noFill();
      stroke(color(col.red, col.green, col.blue));
      rect(screenPos.x + TILE_SIZE / 4, screenPos.y + TILE_SIZE / 4, TILE_SIZE / 2, TILE_SIZE / 2);
   }
   
   public void highlightTile() {
      highlightTile(new Color(255, 0, 0)); 
   }
   
   public String getCoordsString() {
      return Float.toString(boardPos.x) + ", " + Float.toString(boardPos.y); 
   }
   
   public boolean hasPiece() {
     return this.currentPiece != null;
   }
   
   public boolean equals(Tile other) {
      return other.boardPos.equals(boardPos); 
   }
}
