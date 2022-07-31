public class Bishop extends Piece {
   public Bishop(Board board, PieceColour col, int row, int column) {
     super(board, col, "bishop", board.pieceSprites.get(col.colour + "_bishop"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
