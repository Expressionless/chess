public class Queen extends Piece {
   public Queen(Board board, PieceColour col, int row, int column) {
     super(board, col, "queen", board.pieceSprites.get(col.colour + "_queen"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
