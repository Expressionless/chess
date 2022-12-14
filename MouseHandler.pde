public class MouseHandler {
  public final Color CURSOR_COLOR = new Color(100, 100, 100, 200);
  
  public Point screenPos;
  public Board board;
  public Tile pickedUpTile, currentTile;
  public Piece currentPiece;
  
  public MouseHandler(Board board, float x, float y) {
     this(board, new Point(x, y)); 
  }
  
  public MouseHandler(Board board, Point pos) {
    this.board = board;
    this.screenPos = pos;
    
    this.currentTile = board.getTileAtScreen(pos);
  }
  
  public MouseHandler(Board board) {
    this(board, new Point(0, 0));
  }
  
  public void placePiece() {
     if(!hasPiece())
       return;
       
     if(!this.currentTile.hasPiece()) {
       // place the piece
       placePieceHelper();
     } else {
       // Can't do
       if(this.currentTile.currentPiece.getColour() == board.currentPlayer.pieceColour)
         return;
       else {
          placePieceHelper();
          //TODO: implement capture logic
       }
     }
     
  }
  
  public boolean movedPiece() {
     return !this.currentTile.equals(this.pickedUpTile); 
  }
  
  private void placePieceHelper() {
    Move move = new Move(this.currentPiece, this.pickedUpTile, this.currentTile);
    if(this.currentPiece.moveIsValid(move)) {
          //Piece otherPiece = this.currentTile.currentPiece;
          Piece otherPiece = move.capturePiece;
          // capture other piece
          if(otherPiece != null) {
            this.board.removePiece(otherPiece);
          }
          this.currentTile.currentPiece = currentPiece;
          this.currentPiece.currentTile = this.currentTile;
          
          this.currentPiece.postMove(move);
          this.currentPiece = null;
          if(movedPiece()) {
            this.board.endMove();
          }
          this.pickedUpTile = null;
    }
  }
  
  public void updatePosition(float x, float y) {
     if(screenPos.x == x && screenPos.y == y)
       return;
    
    screenPos.x = x;
    screenPos.y = y;
    if(currentPiece != null) {
       currentPiece.screenPos.x = screenPos.x - 32;
       currentPiece.screenPos.y = screenPos.y - 32;
    }
    currentTile = board.getTileAtScreen(x, y);
  }
  
  public void render() {
    fill(CURSOR_COLOR.red, CURSOR_COLOR.green, CURSOR_COLOR.blue, CURSOR_COLOR.alpha);
    if(currentTile != null) ellipse(currentTile.screenPos.x + 32, currentTile.screenPos.y + 32, 24, 24);
     if(this.currentPiece != null) {
       currentPiece.validMoves.stream().forEach(move -> {
          move.to.highlightTile(new Color(100, 100, 100, 200));
       });
     }
  }
  
  public void pickupPieceFromTile() {
     pickupPieceFromTile(mouseHandler.currentTile); 
  }
  
  public void pickupPieceFromTile(Tile tile) {
     Piece piece = tile.currentPiece;
     pickupPiece(piece);
  }
  
  public void pickupPiece(Piece piece) {
   if(hasPiece())
      return;
   
   if(!board.currentPlayer.canMovePiece(piece))
       return;
       
    Tile tile = piece.currentTile;
    this.pickedUpTile = tile;
    tile.currentPiece = null;
    piece.currentTile = null;
    currentPiece = piece;
  }
  
  public boolean hasPiece() {
     return currentPiece != null; 
  }
}
