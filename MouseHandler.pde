public class MouseHandler {
  
  public Point screenPos;
  public Board board;
  public Tile currentTile;
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
       this.currentTile.currentPiece = currentPiece;
       this.currentPiece = null;
     } else {
       // Can't do
       if(this.currentTile.currentPiece.col == board.currentPlayer.pieceColour)
         return;
       else {
          this.currentTile.currentPiece = currentPiece;
          this.currentPiece = null;
          
          //TODO: implement capture logic
       }
     }
  }
  
  public void updatePosition(float x, float y) {
     if(screenPos.x == x && screenPos.y == y)
       return;
    
    screenPos.x = x;
    screenPos.y = y;
    if(currentPiece != null) {
       currentPiece.screenPos.x = screenPos.x;
       currentPiece.screenPos.y = screenPos.y;
    }
    currentTile = board.getTileAt(x, y);
  }
  
  public void render() {
    fill(255, 0, 0);
    ellipse(currentTile.screenPos.x + 32, currentTile.screenPos.y + 32, 24, 24);
  }
  
  public void pickupPieceFromTile() {
    System.out.println("Tile: " + mouseHandler.currentTile.getCoordsString());
    System.out.println("Piece: " + mouseHandler.currentTile.currentPiece.pieceName);
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
    tile.currentPiece = null;
    piece.currentTile = null;
    currentPiece = piece;
  }
  
  public boolean hasPiece() {
     return currentPiece != null; 
  }
}
