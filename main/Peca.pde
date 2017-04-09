/**
 * Classe usada somente para o processamento das imagens.
 */
class Peca {
  int num = 0;
  float x1, y1, x2, y2; 

  public Peca(int n, float x1, float y1, float x2, float y2) {
    this.num = n;
    this.x1=x1;
    this.y1=y1;
    this.x2=x2;
    this.y2=y2;
    drawPeca();
  }

  void drawPeca() {
    if (this.num==9) {
      stroke(255, 255, 255);
      fill(255, 255, 255);
      rect(x1, y1, x2, y2);
    } else {
      stroke(255, 255, 255);
      fill(0, 0, 0);
      rect(x1, y1, x2, y2);
      textSize(52);
      stroke(0, 0, 0);
      fill(255, 0, 0);
      text(num, x1+48, y1+86);
    }
  }
}