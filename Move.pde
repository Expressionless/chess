public class Move {
   public final Tile from, to;
   
   public Move(Tile from, Tile to) {
     this.from = from;
     this.to = to;
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
