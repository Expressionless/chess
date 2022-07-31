import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class Board {
  
   public static final int TILE_SIZE = 64; // px
   
   public final static int TILE_COUNT_X = 8;
   public final static int TILE_COUNT_Y = 8;
   
   public Map<String, PImage> pieceSprites = new HashMap<>();
   
   public Tile[][] tiles = new Tile[TILE_COUNT_Y][TILE_COUNT_X]; // rows of columns
   
   public Player playerWhite, playerBlack;
   
   public Player currentPlayer;
   
   public final float xOffset, yOffset;
   
   public Board(float xOffset, float yOffset) {
     this.xOffset = xOffset;
     this.yOffset = yOffset;
     
     this.playerWhite = new Player(this, PieceColour.WHITE);
     this.playerBlack = new Player(this, PieceColour.BLACK);
     
     currentPlayer = playerWhite;
     
   }
   
   public void generateBoard() {
     
     for(int row = 0; row < TILE_COUNT_Y; row++) {
        for(int column = 0; column < TILE_COUNT_X; column++) {
           tiles[column][row] = new Tile(row, column, xOffset, yOffset); 
        }
     }
   
     playerWhite.generatePieces();
     playerBlack.generatePieces();
   }
   
   public void drawBoard() {
     for(int row = 0; row < TILE_COUNT_Y; row++) {
        for(int column = 0; column < TILE_COUNT_X; column++) {
           tiles[column][row].drawTile();
        }
     }
     
     playerWhite.pieces.stream().forEach((piece) -> piece.drawPiece());     
     playerBlack.pieces.stream().forEach((piece) -> piece.drawPiece());
   }
   
   public void loadImg(String colour, String name) {
       pieceSprites.put(colour + "_" + name, loadImage(colour + "/" + name + ".png"));
   }
   
   public Tile getTileAt(float xx, float yy) {
      int x = ceil((xx - xOffset) / TILE_SIZE) - 1;
      int y = ceil((yy - yOffset) / TILE_SIZE) - 1;
      if(x <= 0) x = 0;
      if(y <= 0) y = 0;
      if(x >= 8) x = 7;
      if(y >= 8) y = 7;
      return tiles[y][x];
   }
   
   public Tile getTileAt(Point pos) {
     return getTileAt(pos.x, pos.y);
   }
   
   public void placePiece(Piece piece, Tile tile) {
     if(tile.currentPiece != null) return;
     
       tile.currentPiece = piece;
       piece.currentTile = tile;
   }
}
