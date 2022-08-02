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
       text((row + 1), xOffset / 2, yOffset / 4 + (TILE_COUNT_Y - row) * TILE_SIZE);
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
   
   public boolean removePiece(Piece piece) {
       piece.currentTile.currentPiece = null;
       return piece.player.removePiece(piece);
   }
   
   public Tile getTileAt(int x, int y) {
      if(x < 0) return null;
      if(y < 0) return null;
      if(x >= 8) return null;
      if(y >= 8) return null;
      return tiles[y][x];
   }
   
   public Tile getTileAtScreen(float fX, float fY) {
      fX -= xOffset;
      fY -= yOffset;
      int x = floor((fX / 64) % 64);
      int y = floor((fY / 64) % 64);
      return getTileAt(x, y);
   }
   
   public Tile getTileAtScreen(Point pos) {
     return getTileAtScreen(pos.x, pos.y);
   }
   
   public Tile getTileAt(Point boardPos) {
     return getTileAt((int)boardPos.x, (int)boardPos.y);
   }
   
   public void updatePieceMoves() {
     playerWhite.updatePieces(tileList);
     playerBlack.updatePieces(tileList);
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
     
     boolean blackInCheck = kingInCheck(PieceColour.BLACK);
     boolean whiteInCheck = kingInCheck(PieceColour.WHITE);
     if(blackInCheck) System.out.println("BLACK IN CHECK");
     if(whiteInCheck) System.out.println("WHITE IN CHECK");
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
   
   public Player getOppositePlayer(PieceColour colour) {
      switch (colour) {
         case WHITE:
         return playerBlack;
         case BLACK:
         return playerWhite;
         default:
         return null;
      }
   }
   
   public boolean kingInCheck(PieceColour pColour) {
     // Check all valid moves to see if any "to" tiles contain a king piece. Return that colour if so
     boolean check = getOppositePlayer(pColour).pieces.stream().anyMatch(piece -> {
         return piece.validMoves.stream().anyMatch(move -> {
           if(move.to.currentPiece == null) return false;
           if(move.to.currentPiece.getColour() == pColour) {
               return (move.to.currentPiece instanceof King);
           }
           
           return false;
         });
     });
     
     return check;
   }
}
