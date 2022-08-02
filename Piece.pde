import java.util.List;
import java.util.ArrayList;

public abstract class Piece {
   public final String pieceName;
   public final PImage pieceImage;
   
   public Player player;
   public Board board;
   public Point screenPos;
   public Tile currentTile;
   
   protected List<Move> validMoves = new ArrayList<>();
   
   public Piece(Board board, Player player, String pieceName, PImage pieceImage, int row, int column) {
      this(board, player, pieceName, pieceImage, board.tiles[row][column]); 
   }
   
   
   protected boolean addMove(List<Move> moves, Tile tile) {
     Move move;
     
     if(tile == null) return false;
     if(tile.currentPiece != null) {
         if(tile.currentPiece.sameTeam(this)) return false;
     }
     
     move = createMove(tile, tile.currentPiece);
     return addMove(moves, move);
   }
   
   protected boolean addMove(List<Move> moves, Move move) {
     if(move == null) return false;
     moves.add(move);
     return true;
   }
   
   protected List<Move> getStraight(int x, int y) {
     List<Move> moves = new ArrayList<>();
     Tile nextTile = currentTile;
     
     // Top right direction
     while(nextTile != null) {
         // Decide if capture move or not
         if(nextTile.currentPiece != null) {
           if(!nextTile.currentPiece.equals(this)) {
             if(!nextTile.currentPiece.sameTeam(this)) {
               addMove(moves, createMove(nextTile, nextTile.currentPiece));
             }
               break;
           }
         } else {
           moves.add(createMove(nextTile, null));
         }
         Point nextPos = nextTile.boardPos.add(new Point(x, y));
         nextTile = board.getTileAt(nextPos);
     }
     
     return moves;
   }
   
   public Piece(Board board, Player player, String pieceName, PImage pieceImage, Tile currentTile) {
      this.pieceImage = pieceImage;
      this.board = board;
      this.player = player;
      this.pieceName = pieceName;
      
      this.currentTile = currentTile;
      this.currentTile.currentPiece = this;
      this.screenPos = currentTile.screenPos.clone();
   }
   
   protected abstract void calculateValidMoves(List<Tile> tiles);
   protected abstract void calculateCaptureMoves(List<Tile> tiles);
   
   public void calculateValidPieceMoves(List<Tile> tiles) {
     validMoves.clear();
      calculateValidMoves(tiles);
   }
   
   public void drawPiece() {
     if(this.currentTile != null) {
        this.screenPos.x = this.currentTile.screenPos.x;
        this.screenPos.y = this.currentTile.screenPos.y;
     }
     image(pieceImage, screenPos.x, screenPos.y);
   }
   
   public boolean sameTeam(Piece other) {
      return getColour() == other.getColour();
   }
   
   public void drawMoves() {
     for (Move move : validMoves) {
       move.to.highlightTile();
     }
   }
   
   public boolean moveIsValid(Move move) {
     if(move.from.equals(move.to)) return true;
     
     // if there is a piece on the to tile that is not the same colour and move is a capture move
     // capture it
     // otherwise don't bother checking if its a valid move
     if(move.to.currentPiece != null) {
        if(move.isCaptureMove()) {
          if(move.to.currentPiece.getColour() == move.movingPiece.getColour()) {
            System.out.println("Same colour!");
            return false;
          }
        } else {
          System.out.println("Not capture move!");
          return false;
        }
     }
     
      boolean isValid = validMoves.stream().anyMatch(validMove -> {
        return (validMove.equals(move));
      });
      
      if(!isValid) {
        System.out.println("Invalid move: " + move.toString());
      }
      return isValid;
   }
   
   public PieceColour getColour() {
     return player.pieceColour;
   }
   
   public Move createMove(Tile to, Piece capturePiece) {
     return new Move(this, currentTile, to, capturePiece);
   }
   
   public void postMove(Move move) {
     
   }
   
   public boolean canCapture(Piece other) {
    return false; 
   }
   
   public String toString() {
       return getColour().colour + " " + pieceName + (currentTile != null ? (" at " + currentTile.boardPos) : " on cursor");
   }
}
