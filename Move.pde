public class Move {
   public final Tile from, to;
   
   private boolean captureMove;
   private Piece movingPiece;
   
   public Move(Piece movingPiece, Tile from, Tile to) {
      this(movingPiece, from, to, false);
      captureMove = calcCaptureMove();
   }
   
   public Move(Piece movingPiece, Tile from, Tile to, boolean isCaptureMove) {
     this.movingPiece = movingPiece;
     this.from = from;
     this.to = to;
     this.captureMove = isCaptureMove;
     if(this.captureMove)
     System.out.println("Creating move: " + captureMove);
   }
   
   public boolean isCaptureMove() {
      return captureMove;
   }
   
   private boolean calcCaptureMove() {
     if(to.currentPiece != null) {
      if(movingPiece.getColour() != to.currentPiece.getColour()) {
         return movingPiece.validMoves.stream().anyMatch(move -> {
           if(move.isCaptureMove()) {
              return move.equals(this); 
           }
           return false;
         });
      }
     }
     return false;
   }
   
   public boolean equals(Move move) {
      if(!move.to.equals(to))
        return false;
      if(!move.from.equals(from))
        return false;
        
      return true;
   }
   
   public String toString() {
     return "Move: " + (from != null ? from.getCoordsString() : "null") + " to " + (to != null ? to.getCoordsString() : "null"); 
   }
}
