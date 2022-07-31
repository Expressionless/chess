public class Knight extends Piece {
   public Knight(Board board, PieceColour col, int row, int column) {
     super(board, col, "knight", board.pieceSprites.get(col.colour + "_knight"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
