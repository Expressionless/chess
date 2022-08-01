import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class Board {
   public final String[] COLUMN = {"A", "B", "C", "D", "E", "F", "G", "H"};
   public final Color COL_WHITE = new Color(255, 230, 238);
   
   public static final int TILE_SIZE = 64; // px
   
   public final static int TILE_COUNT_X = 8;
   public final static int TILE_COUNT_Y = 8;
   
   public Map<String, PImage> pieceSprites = new HashMap<>();
   
   public Tile[][] tiles = new Tile[TILE_COUNT_Y][TILE_COUNT_X]; // rows of columns
   public List<Tile> tileList = new ArrayList<>();
   
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
           tileList.add(tiles[column][row]);
        }
     }
   
     playerWhite.generatePieces();
     playerBlack.generatePieces();
     
     updatePieceMoves();
   }
   
   public void drawBoard() {
     textSize(24);
     for(int row = 0; row < TILE_COUNT_Y; row++) {
       fill(COL_WHITE.red, COL_WHITE.green, COL_WHITE.blue);
       text(row, xOffset / 2, yOffset / 4 + (row + 1) * TILE_SIZE);
        for(int column = 0; column < TILE_COUNT_X; column++) {
           tiles[column][row].drawTile();
        }
     }
     
     for(int column = 0; column < TILE_COUNT_X; column++) {
        
       fill(COL_WHITE.red, COL_WHITE.green, COL_WHITE.blue); 
       text(COLUMN[column], (column + 1) * TILE_SIZE, TILE_SIZE * (TILE_COUNT_Y + 1) + yOffset / 4);
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
   
   public void updatePieceMoves() {
     
      // Calculate all valid moves for pieces
      for(Piece piece : playerWhite.pieces) {
         piece.calculateValidMoves(tileList); 
      }
      
      for(Piece piece : playerBlack.pieces) {
         piece.calculateValidMoves(tileList); 
      }
   }
   
   public void endMove() { 
     updatePieceMoves();
      
      switch(this.currentPlayer.pieceColour) {
         case WHITE:
           this.currentPlayer = this.playerBlack;
         break;
         case BLACK:
           this.currentPlayer = this.playerWhite;
         break;
      }
   }
   
   public Player getPlayer(PieceColour colour) {
      switch (colour) {
         case WHITE:
         return playerWhite;
         case BLACK:
         return playerBlack;
         default:
         return null;
      }
   }
}
