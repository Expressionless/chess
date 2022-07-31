public class Player {
  
   public final PieceColour pieceColour;
    
   public List<Piece> pieces = new ArrayList<>();
   public Board board;
   
   public Player(Board board, PieceColour pieceColour) {
     this.pieceColour = pieceColour;
     this.board = board;
   }
   
   public void addPiece(Piece piece) {
     if(piece.col != pieceColour)
       return;
     pieces.add(piece);
   }
   
   public void generatePieces() {
      // generate pawns
      int row = (pieceColour == PieceColour.WHITE) ? 6 : 1;
      
      for(int column = 0; column < 8; column++) {
         this.addPiece(new Pawn(board, pieceColour, row, column));
      }
      row = (pieceColour == PieceColour.WHITE) ? 7 : 0;
      this.addPiece(new Rook(board, pieceColour, row, 0));
      this.addPiece(new Knight(board, pieceColour, row, 1));
      this.addPiece(new Bishop(board, pieceColour, row, 2));
      this.addPiece(new Queen(board, pieceColour, row, 3));
      this.addPiece(new King(board, pieceColour, row, 4));
      this.addPiece(new Knight(board, pieceColour, row, 5));
      this.addPiece(new Knight(board, pieceColour, row, 6));
      this.addPiece(new Rook(board, pieceColour, row, 7));
   }
   
   public boolean canMovePiece(Piece piece) {
     if(piece == null) return false;
     
      return this.pieceColour == piece.col
          && board.currentPlayer.equals(this); 
   }
}
