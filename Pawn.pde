public class Pawn extends Piece {
   public Pawn(Board board, PieceColour col, int row, int column) {
     super(board, col, "pawn", board.pieceSprites.get(col.colour + "_pawn"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
