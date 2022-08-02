public class Rook extends Piece {
   public Rook(Board board, Player player, int row, int column) {
     super(board, player, "rook", board.pieceSprites.get(player.pieceColour.colour + "_rook"), row, column);
   }
   
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.addAll(getStraight(1, 0));
     validMoves.addAll(getStraight(0, 1));
     validMoves.addAll(getStraight(-1, 0));
     validMoves.addAll(getStraight(0, -1));
   }
   
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     
   }
}
