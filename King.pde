public class King extends Piece {
   public King(Board board, Player player, int row, int column) {
     super(board, player, "king", board.pieceSprites.get(player.pieceColour.colour + "_king"), row, column);
   }
     
   public void calculateValidMoves(List<Tile> tiles) {
   
   }
}
