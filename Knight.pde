public class Knight extends Piece {
   public Knight(Board board, Player player, int row, int column) {
     super(board, player, "knight", board.pieceSprites.get(player.pieceColour.colour + "_knight"), row, column);
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
   
   }
}
