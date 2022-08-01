public class Queen extends Piece {
   public Queen(Board board, Player player, int row, int column) {
     super(board, player, "queen", board.pieceSprites.get(player.pieceColour.colour + "_queen"), row, column);
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
   
   }
}
