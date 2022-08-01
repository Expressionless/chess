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
       tile = board.tiles[(int)boardPos.y + direction][(int)boardPos.x + 1];
       if(tile.hasPiece(player.oppositeColour())) {
         validMoves.add(createMove(tile));
       }
     }
      
     if(boardPos.x > 0) {
       tile = board.tiles[(int)boardPos.y + direction][(int)boardPos.x - 1];
       if(tile.hasPiece(player.oppositeColour())) {
         validMoves.add(createMove(tile));
       }
     }
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.clear();
     Point boardPos = currentTile.boardPos.clone();
     Tile tile, tile2;
     
     int direction = getColour() == PieceColour.WHITE ? -1 : 1;
     tile = board.tiles[(int)boardPos.y + direction][(int)boardPos.x];
     validMoves.add(createMove(tile));
     
     if(!alreadyMoved) {
       tile2 = board.tiles[(int)boardPos.y + 2 * direction][(int)boardPos.x];
       validMoves.add(createMove(tile2));
     }
   }
   
   @Override
   public void move(Move move) {
     alreadyMoved = true;
     super.move(move);
   }
}
