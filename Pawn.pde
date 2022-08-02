import java.util.List;

public class Pawn extends Piece {
    public boolean alreadyMoved = false;
    public int passable = 0;
  
   public Pawn(Board board, Player player, int row, int column) {
     super(board, player, "pawn", board.pieceSprites.get(player.pieceColour.colour + "_pawn"), row, column);
   }
   
   private Move canEnPassant(Point boardPos, Tile targetTile, int direction) {
      if(targetTile == null) return null;
      
      if(targetTile.hasPiece(player.oppositeColour())) {
         Piece oppositePiece = targetTile.currentPiece;
         if(oppositePiece instanceof Pawn) {
             Pawn pawn = (Pawn)oppositePiece;
             if(pawn.passable > 0) {
               Tile passTile = board.getTileAt((int)targetTile.boardPos.x, (int)boardPos.y + direction);
                return createMove(passTile, oppositePiece);
             }
         }
      }
      return null;
   }
   
   private List<Move> calculateEnPassant(Point boardPos, int direction) {
       List<Move> moves = new ArrayList<>();
       
       Tile tile = board.getTileAt((int)boardPos.x + 1, (int)boardPos.y);
       Move move = canEnPassant(boardPos, tile, direction);
       if(move != null) moves.add(move);
       
       tile = board.getTileAt((int)boardPos.x - 1, (int)boardPos.y);
       move = canEnPassant(boardPos, tile, direction);
       if(move != null) moves.add(move);
       
       return moves;
   }
   
   protected void calculateCaptureMoves(List<Tile> tiles) {
     Point boardPos = currentTile.boardPos.clone();
     Tile tile;
     int direction = getDirection();
     calculateEnPassant(boardPos, direction).stream().forEach(move -> addMove(validMoves, move));
     
     if(boardPos.x < 7) {
       // En passant
       
       // Standard Captures
       tile = board.getTileAt((int)boardPos.x + 1, (int)boardPos.y + direction);
       if(tile != null) {
         if(tile.hasPiece(player.oppositeColour())) {
           addMove(validMoves, createMove(tile, tile.currentPiece));
         }
       }
     }
      
     if(boardPos.x > 0) {
       tile = board.getTileAt((int)boardPos.x - 1, (int)boardPos.y + direction);
       if(tile != null) {
         if(tile.hasPiece(player.oppositeColour())) {
           addMove(validMoves, createMove(tile, tile.currentPiece));
         }
       }
     } 
   }
   
   public void drawPiece() {
     super.drawPiece();
     if(passable > 0 && currentTile != null) {
        fill(255, 0, 0);
        ellipse(currentTile.screenPos.x + 32, currentTile.screenPos.y + 32, 24, 24);
     }
   }
  
   public void calculateValidMoves(List<Tile> tiles) {
     validMoves.clear();
     Point boardPos = currentTile.boardPos.clone();
     Tile tile;
     
     int direction = getColour() == PieceColour.WHITE ? -1 : 1;
     tile = board.getTileAt((int)boardPos.x, (int)boardPos.y + direction);
     
     if(tile != null) {
       if(tile.currentPiece == null) {
           addMove(validMoves, createMove(tile, null));
       } else return;
     }
     
     if(!alreadyMoved) {
       tile = board.getTileAt((int)boardPos.x, (int)boardPos.y + 2 * direction);
       if(tile != null) {
         if(tile.currentPiece == null) {
           addMove(validMoves, createMove(tile, null));
         }
       }
     }
   }
   
   @Override
   public void postMove(Move move) {
     alreadyMoved = true;
     Point moveDist = move.getMoveDistance();
     if(moveDist.y == 2.0) {
        passable = 2;
     }
     super.postMove(move);
   }
   
   public int getDirection() {
     return getColour() == PieceColour.WHITE ? -1 : 1;
   }
}
