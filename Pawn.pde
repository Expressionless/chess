import java.util.List;

public class Pawn extends Piece {
    public boolean alreadyMoved = false;
  
   public Pawn(Board board, Player player, int row, int column) {
     super(board, player, "pawn", board.pieceSprites.get(player.pieceColour.colour + "_pawn"), row, column);
   }
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     Point boardPos = currentTile.boardPos.clone();
     Tile tile;
     int direction = getColour() == PieceColour.WHITE ? -1 : 1;
     if(boardPos.x < 7) {
       tile = board.getTileAt((int)boardPos.x + 1, (int)boardPos.y + direction);
       if(tile != null) {
         if(tile.hasPiece(player.oppositeColour())) {
           validMoves.add(createMove(tile, true));
         }
       }
     }
      
     if(boardPos.x > 0) {
       tile = board.getTileAt((int)boardPos.x - 1, (int)boardPos.y + direction);
       if(tile != null) {
         if(tile.hasPiece(player.oppositeColour())) {
           validMoves.add(createMove(tile, true));
         }
       }
     } 
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.clear();
     Point boardPos = currentTile.boardPos.clone();
     Tile tile;
     
     int direction = getColour() == PieceColour.WHITE ? -1 : 1;
     tile = board.getTileAt((int)boardPos.x, (int)boardPos.y + direction);
     
     if(tile != null)
       validMoves.add(createMove(tile, false));
     
     if(!alreadyMoved) {
       tile = board.getTileAt((int)boardPos.x, (int)boardPos.y + 2 * direction);
       if(tile != null)
         validMoves.add(createMove(tile, false));
     }
   }
   
   @Override
   public void move(Move move) {
     alreadyMoved = true;
     super.move(move);
   }
}
