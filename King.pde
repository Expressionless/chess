public class King extends Piece {
   public King(Board board, Player player, int row, int column) {
     super(board, player, "king", board.pieceSprites.get(player.pieceColour.colour + "_king"), row, column);
   }
     
   public void calculateValidMoves(List<Tile> tiles) {
       Point boardPos = this.currentTile.boardPos;
       
       addMove(validMoves, board.getTileAt(boardPos.add(1, 1)));
       addMove(validMoves, board.getTileAt(boardPos.add(0, 1)));
       addMove(validMoves, board.getTileAt(boardPos.add(-1, 1)));
       
       addMove(validMoves, board.getTileAt(boardPos.add(1, 0)));
       addMove(validMoves, board.getTileAt(boardPos.add(-1, 0)));
       
       addMove(validMoves, board.getTileAt(boardPos.add(1, -1)));
       addMove(validMoves, board.getTileAt(boardPos.add(0, -1)));
       addMove(validMoves, board.getTileAt(boardPos.add(-1, -1)));
       
   }
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     
   }
}
