public class Estado {
  int N; //Tamanho do tabuleiro
  Peca M[][];
  int cost; 
  int f; //avaliaçao
  int mask[][];
  Estado parent;

  // CONSTRUTORES ===================================================================
  public Estado(int N, int cost) {
    this.N = N;
    this.M = new Peca[N][N];
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
        int label = (j*N+i)+1;
        this.M[i][j] = new Peca(label, i, j, N, true);
        if (this.M[i][j].getLabel() == this.N*this.N) this.M[i][j].setVisibility(false);
      }
    }

    //this.M[i][j].setVisibility(false);
    this.cost = cost;
  }

  public Estado(int N) {
    this(N, 1);
  }

  // END-CONSTRUTORES ================================================================

  public void draw() { // impressão de todas as peças
    for (int i=0; i<this.N; i++) { //<>//
      for (int j=0; j<this.N; j++) {
        if (M[i][j].getVisibility()) this.M[i][j].draw();
      }
    }
  }


  public boolean isObjective(int[][] mask) {    //verifica se o estado é objetivo
    
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
        if (this.M[i][j].getLabel() != mask[i][j]) return false;
      }
    }
    return true;
  }

  public float getH(int[][] mask) { //Get: Heurística: Cálculo da Distância Manhattan
    float heuristic = 0.0;
    if (this.M.length == mask.length) {
      int x1=0, y1=0;
      for (int i=0; i<this.N; i++) {
        for (int j=0; j<this.N; j++) {
          int x0 = i;
          int y0 = j;
          for (int k=0; k<this.N; k++) {
            for (int l=0; l<this.N; l++) {
              if (this.M[i][j].getLabel() == mask[k][l]) {
                x1 = k;
                y1 = l;
                heuristic += abs(x0-x1)+abs(y0-y1);
              }
            }
          }
        }
      }
    }
    return heuristic;
  }

  public Estado move(int sentido) {
    for (int i=0; i<this.N; i++) {
      for (int j=0; j<this.N; j++) {
        if (this.M[i][j].getVisibility() == false) {
          Peca tmp;
          int x=0, y=0;
          boolean fail=false;
          switch(sentido) {
          case 1: //cima
            x = i-1;
            if (x<0) { 
              fail=true;
              break;
            }
            y = j;
            break;
          case 2: //direita
            x = i;
            y = j+1;
            if (y>=this.N) { 
              fail=true;
              break;
            }
            break;
          case 3: //baixo
            x = i+1;
            if (x>=this.N) { 
              fail=true;
              break;
            }
            y = j;
            break;
          case 4: //esquerda
            x = i;
            y = j-1;
            if (y<0) { 
              fail=true;
              break;
            }
            break;
          }
          if (fail==false) {
            Estado novo = this.clone();
            tmp = novo.M[x][y];
            novo.M[x][y] = novo.M[i][j];
            novo.M[x][y].setPos(i,j);
            novo.M[i][j] = tmp;
            novo.M[i][j].setPos(x,y);
            return novo;
          }
        }
      }
    }
    return null;
  }

  //public float getAvaliacao(int x0, int y0, int x1, int y1) {
  //  return this.getH(x0, y0, x1, y1) + this.getCost();
  //}

  //public String toString() {
  //  return " Posição: \n +  Custo: " + this.getCusto()  + "\nHeurística: " + this.getH() + "\nAvaliação: " + this.getAvaliacao();
  //}

  public int[][] getMask() {
    int N = this.N;
    int mask[][] = new int[N][N];
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
        mask[i][j] = this.M[i][j].getLabel();
      }
    }
    return mask;
  }

  public void setMask(int[][] mask) { //Configura todos as peças de acordo com uma matrix pré-definida.
    this.mask = mask;
    if (this.N == mask.length) {
      for (int i=0; i<this.N; i++) {
        for (int j=0; j<this.N; j++) {
          this.M[i][j].setLabel(mask[i][j]);
          this.M[i][j].setVisibility(true);
          if (this.M[i][j].getLabel() == this.N*this.N) this.M[i][j].setVisibility(false);
        }
      }
      println("Mask's setted.");
      println("State's length: " + this.M.length);
      println("Mask's length: " + mask.length);
    } else {
      println("Mask can't be setted.");
      println("State's length: " + this.M.length);
      println("Mask's length: " + mask.length);
    }
  }



  public Peca[][] getM() {
    return this.M;
  }

  public void setM(Peca[][] M) {
    this.M = M;
  }

  public int getCost() {
    return cost;
  }

  public void setCost(int custo) {
    this.cost = custo;
  }

  public float getEval(){
   return this.getH(this.mask) + this.getCost(); 
  }

  public Estado getPai() {
    return parent;
  }

  public void setPai(Estado pai) {
    this.parent = pai;
  }

  public Estado getParent() {
    return this.parent;
  }
  public void setParent(Estado parent) {
    this.parent = parent;
  }

  public Estado clone() {
    Estado clone = new Estado(this.N, this.cost);
    clone.setMask(this.getMask());
    return clone;
  }
}