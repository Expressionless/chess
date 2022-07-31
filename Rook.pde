public class Rook extends Piece {
   public Rook(Board board, PieceColour col, int row, int column) {
     super(board, col, "rook", board.pieceSprites.get(col.colour + "_rook"), row, column);
   }
   
   public List<Move> validMoves() {
     return null;
   }
}
