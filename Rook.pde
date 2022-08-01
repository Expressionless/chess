public class Rook extends Piece {
   public Rook(Board board, Player player, int row, int column) {
     super(board, player, "rook", board.pieceSprites.get(player.pieceColour.colour + "_rook"), row, column);
   }
   
   public void calculateValidMoves(List<Tile> tiles) {
     
   }
   
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     
   }
}
