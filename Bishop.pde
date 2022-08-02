import java.util.ArrayList;

public class Bishop extends Piece {
   public Bishop(Board board, Player player, int row, int column) {
     super(board, player, "bishop", board.pieceSprites.get(player.pieceColour.colour + "_bishop"), row, column);
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.clear();
     validMoves.addAll(getStraight(1, 1));
     validMoves.addAll(getStraight(1, -1));
     validMoves.addAll(getStraight(-1, -1));
     validMoves.addAll(getStraight(-1, 1));
   }
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     
   }
}
