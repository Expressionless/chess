import java.util.List;
import java.util.ArrayList;

public abstract class Piece {
   public final String pieceName;
   public final PImage pieceImage;
   
   public PieceColour col;
   public Board board;
   public Point screenPos;
   public Tile currentTile;
   
   public abstract List<Move> validMoves();
   
   public Piece(Board board, PieceColour col, String pieceName, PImage pieceImage, int row, int column) {
      this(board, col, pieceName, pieceImage, board.tiles[row][column]); 
   }
   
   public Piece(Board board, PieceColour col, String pieceName, PImage pieceImage, Tile currentTile) {
      this.pieceImage = pieceImage;
      this.board = board;
      this.col = col;
      this.pieceName = pieceName;
      
      this.currentTile = currentTile;
      this.currentTile.currentPiece = this;
      this.screenPos = currentTile.screenPos;
   }
   
   public void drawPiece() {
     image(pieceImage, screenPos.x, screenPos.y);
   }
   
   public void drawMoves() {
     List<Move> validMoves = validMoves();
     for (Move move : validMoves) {
       move.to.highlightTile();
     }
   }
}
