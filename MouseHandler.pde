public class MouseHandler {
  
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
    
    this.currentTile = board.getTileAt(pos);
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
    Move move = new Move(this.pickedUpTile, this.currentTile);
    if(this.currentPiece.moveIsValid(move)) {
          this.currentPiece.move(move);
          this.currentTile.currentPiece = currentPiece;
          this.currentPiece.currentTile = this.currentTile;
          
          this.currentPiece = null;
          if(movedPiece())
            this.board.endMove();
          this.pickedUpTile = null;
    } else {
       System.out.println("Invalid Move!"); 
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
    currentTile = board.getTileAt(x, y);
  }
  
  public void render() {
    fill(100, 100, 100, 100);
    ellipse(currentTile.screenPos.x + 32, currentTile.screenPos.y + 32, 24, 24);
     if(this.currentPiece != null) {
       currentPiece.validMoves.stream().forEach(move -> {
          move.to.highlightTile();
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
