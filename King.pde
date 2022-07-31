public class King extends Piece {
   public King(Board board, PieceColour col, int row, int column) {
     super(board, col, "king", board.pieceSprites.get(col.colour + "_king"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
