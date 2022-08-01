Board board;
String[] pieces = {"blk_pawn", "blk_bishop", "blk_knight", "blk_rook", "blk_queen", "blk_king"
                  ,"wht_pawn", "wht_bishop", "wht_knight", "wht_rook", "wht_queen", "wht_king"};
MouseHandler mouseHandler;
void setup() {
   size(600, 600);
   float diff = 600 - 64 * 8;
   board = new Board(diff / 2, diff / 2);
   for(String piece : pieces) {
     String[] parts = piece.split("_");
     board.loadImg(parts[0], parts[1]);
   }
   
   board.generateBoard();
   mouseHandler = new MouseHandler(board);
}

void draw() {
  background(100, 100, 100);
  mouseHandler.updatePosition(mouseX, mouseY);
  board.drawBoard();
  
  mouseHandler.render();
  
  Color COL_WHITE = new Color(255, 230, 238);
  fill(COL_WHITE.red, COL_WHITE.green, COL_WHITE.blue);
  textSize(32);
  text((board.currentPlayer.pieceColour == PieceColour.WHITE ? "White" : "Black") + " to move", 16, 32);
}

void mousePressed() {
  if(mouseHandler.currentTile != null) {
    if(!mouseHandler.hasPiece()) {
      if(mouseHandler.currentTile.hasPiece())
        mouseHandler.pickupPieceFromTile();
    }
    else
      mouseHandler.placePiece();
  }
}
