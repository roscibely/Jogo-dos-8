class Peca {
  int label = 0;
  int mX, mY, N;
  float x1, y1, x2, y2; 
  float x_length, y_length;
  boolean visible;

  public Peca(int label, int mX, int mY, int N, boolean visible) {
    this.label = label;
    this.mX = mX;
    this.mY = mY;
    this.x_length = width/N;
    this.y_length = height/N;
    this.x1 = mX * this.x_length;
    this.y1 = mY * this.y_length;
    this.x2 = x1 + this.x_length;
    this.y2 = y1 + this.y_length;
    this.visible = visible;
  }

  public Peca(int rotulo, int mX, int mY, int N) {
    this(rotulo, mX, mY, N, true);
  }

  void draw() {
    stroke(39, 81, 255);
    fill(262, 253, 252);
    if (this.mouse_isOver()) fill(125, 0, 255);
    rect(this.x1, this.y1, this.x_length, this.y_length);
    textSize(52);
    stroke(0, 0, 0);
    fill(72, 158, 255);
    text(label, x1+48, y1+86);
  }

  void setX(int x) {
    this.mX = x;
  }

  void setY(int y) {
    this.mY = y;
  }

  void setPos(int x, int y) {
    this.x1 = x * this.x_length;
    this.y1 = y * this.y_length;
    this.x2 = x1 + this.x_length;
    this.y2 = y1 + this.y_length;
  }

  boolean getVisibility() {
    return this.visible;
  }
  void setVisibility(boolean visible) {
    this.visible = visible;
  }
  boolean mouse_isOver() {
    if (mouseX>=this.x1 && mouseX<=this.x2 && mouseY>=this.y1 && mouseY<=this.y2) return true;
    return false;
  }

  public int getLabel() {
    return this.label;
  }
  public void setLabel(int label){
   this.label = label; 
  }

  public String toString() {
    return "Rotulo: " + this.label + " - Mouse está em cima: " + this.mouse_isOver();
  }
}