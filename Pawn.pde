import java.util.List;

public class Pawn extends Piece {
    public boolean alreadyMoved = false;
  
   public Pawn(Board board, Player player, int row, int column) {
     super(board, player, "pawn", board.pieceSprites.get(player.pieceColour.colour + "_pawn"), row, column);
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.clear();
     Point boardPos = currentTile.boardPos.clone();
     Tile tile, tile2;
     switch(getColour()) {
        case WHITE:
          tile = board.tiles[(int)boardPos.y - 1][(int)boardPos.x];
          validMoves.add(createMove(tile));
          if(!alreadyMoved) {
            tile2 = board.tiles[(int)boardPos.y - 2][(int)boardPos.x];
            validMoves.add(createMove(tile2));
          }
        break;
        
        case BLACK:
        
          tile = board.tiles[(int)boardPos.y + 1][(int)boardPos.x];
          validMoves.add(createMove(tile));
          if(!alreadyMoved) {
            tile2 = board.tiles[(int)boardPos.y + 2][(int)boardPos.x];
            validMoves.add(createMove(tile2));
          }
        break;
     }
     // look at current tile
     // look at two spaces in front / behind (colour depending)
   }
   
   @Override
   public void move(Move move) {
     alreadyMoved = true;
     super.move(move);
   }
}
