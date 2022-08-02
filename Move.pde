public class Move {
   public final Tile from, to;
   
   private Piece movingPiece;
   private Piece capturePiece = null;
   private boolean captureMove = false;
   
   public Move(Piece movingPiece, Tile from, Tile to) {
      this(movingPiece, from, to, null);
      capturePiece = calcCaptureMove();
      captureMove = capturePiece != null;
   }
   
   public Move(Piece movingPiece, Tile from, Tile to, Piece capturePiece) {
     if(from == null) throw new NullPointerException("From is null");
     if(to == null) throw new NullPointerException("To is null");
     this.movingPiece = movingPiece;
     this.from = from;
     this.to = to;
     this.capturePiece = capturePiece;
     this.captureMove = capturePiece != null;
   }
   
   public boolean isCaptureMove() {
      return captureMove;
   }
   
   private Piece calcCaptureMove() {
     if(to.currentPiece != null) {
      if(!movingPiece.sameTeam(to.currentPiece)) {
         boolean capMove = movingPiece.validMoves.stream().anyMatch(move -> {
           if(move.isCaptureMove()) {
              return move.equals(this); 
           }
           return false;
         });
         
         if(capMove) {
            return to.currentPiece;           
         }
         
       }
      } else {
         // en passant
         if(movingPiece instanceof Pawn) {
           // Check tiles below
           Point toTilePos = to.boardPos;
           int direction = ((Pawn)movingPiece).getDirection();
           
           Tile captureTile = board.getTileAt((int)toTilePos.x, (int)toTilePos.y - direction);
           if(captureTile.currentPiece != null) {
             if(captureTile.currentPiece instanceof Pawn) {
               if(!captureTile.currentPiece.sameTeam(movingPiece)) {
                 return captureTile.currentPiece;
               }
             }
           }
         }
      }
     return null;
   }
   
   public boolean equals(Move move) {
      if(!move.to.equals(to))
        return false;
      if(!move.from.equals(from))
        return false;
        
      return true;
   }
   
   public Point getMoveDistance() {
      float dX = to.boardPos.x - from.boardPos.x;
      float dY = to.boardPos.y - from.boardPos.y;
      return new Point(abs(dX), abs(dY));
   }
   
   public String toString() {
     return "Move: " + (from != null ? from.getCoordsString() : "null") + " to " + (to != null ? to.getCoordsString() : "null"); 
   }
}
