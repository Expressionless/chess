public class Knight extends Piece {
   public Knight(Board board, Player player, int row, int column) {
     super(board, player, "knight", board.pieceSprites.get(player.pieceColour.colour + "_knight"), row, column);
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     // L shapes
     Point boardPos = this.currentTile.boardPos;
     
     // Top right
     addMove(validMoves, board.getTileAt(boardPos.add(2, 1)));
     addMove(validMoves, board.getTileAt(boardPos.add(1, 2)));
     
     // Top Left
     addMove(validMoves, board.getTileAt(boardPos.add(-2, 1)));
     addMove(validMoves, board.getTileAt(boardPos.add(-1, 2)));
     
     // Bottom Left
     addMove(validMoves, board.getTileAt(boardPos.add(-2, -1)));
     addMove(validMoves, board.getTileAt(boardPos.add(-1, -2)));
     
     // Bottom Right
     addMove(validMoves, board.getTileAt(boardPos.add(2, -1)));
     addMove(validMoves, board.getTileAt(boardPos.add(1, -2)));
   }
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     
   }
}
