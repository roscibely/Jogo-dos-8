int N = 3; //Tamanho do tabuleiro
int flag=0; //???
Estado EI = new Estado(N);                 
Estado EF = new Estado(N);

int[][] m = {{1, 5, 7}, {6, 9, 4}, {3, 8, 2}};
int[][] m_ideal = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};


Estado e = EI;
Estado e2;
void setup() {
  size(600, 600);
  background(255, 255, 255);
  e = new Estado(N);
  e.setMask(m);
  //EF.setMask(m_ideal);
}
boolean solucao = false;
void draw() {

  //background(255, 255, 255);
  if (mousePressed) {
    //e.move();
  }
  if (!solucao) {
    ArrayList<Estado> queue = new ArrayList<Estado>();
    queue.add(e);
    while (!queue.isEmpty()) {
      Estado estado = queue_dropMenor(queue);
      if (estado.isObjective(m_ideal)) {
        estado.draw();
        solucao = true;
      }
      estado.draw(); //<>//
      ArrayList<Estado> filhos = expande(estado);
      for (int i=0; i<filhos.size(); i++) {
        queue.add(filhos.get(i));
      }
    }
  }
  //e.draw();
  //println(e.getH(m_ideal));
}


ArrayList<Estado> expande(Estado parent) { //Expansão dos estados
  ArrayList<Estado> filhos = new ArrayList<Estado>();
  for (int i=1; i<5; i++) {
    Estado test = parent.move(i);
    if (test!=null) {
      test.setCost(parent.getCost()+1);
      test.setParent(parent);
      filhos.add(test);
    }
  }
  return filhos;
}

public Estado queue_dropMenor(ArrayList<Estado> queue) {
  float menorAvaliacao = queue.get(0).getEval();
  int p = 0;
  for (int i=1; i<queue.size(); i++) {
    if (queue.get(i).getEval()<menorAvaliacao) {
      menorAvaliacao = queue.get(i).getEval();
      p = i;
    }
  }

  Estado estado = queue.get(p);
  queue.remove(p);
  return estado;
}



//void draw() {
//  background(255, 255, 255);
//  if (mousePressed) {
//    //println("*"+mp[0][1].x1);
//    mp[j][i].x1 = mouseX-(width/N)*0.5;
//    mp[j][i].y1 = mouseY-(height/N)*0.5;
//    if ((i != mouseX/(width/N) || j != mouseY/(height/N)) && c == 0) {
//      Peca temp = mp[mouseY/(height/N)][mouseX/(width/N)];
//      mp[mouseY/(height/N)][mouseX/(width/N)] = mp[j][i];
//      mp[j][i]=temp;
//      c=1;
//    }
//  } else {
//    c = 0;
//    println("" + i + "-" + j);
//    i = mouseX/(width/N);
//    j = mouseY/(height/N);
//  }

//  e.draw();
//}


//Move a peça para esquerda, direita, cima, baixo
//Estado move(int x, int y, Estado e) {
//  int[][]M = e.getM(); 
//  if (M[x+1][y]==0 && (x+1)<N) {
//    int aux = M[x][y];
//    M[x][y]=0;
//    M[x+1][y]=aux;
//    flag=1;
//  } else if (M[x-1][y]==0 && (x-1)>0) {
//    int aux = M[x][y];
//    M[x][y]=0;
//    M[x-1][y]=aux;
//    flag=1;
//  } else if (M[x][y+1]==0 && (y+1)<N) {
//    int aux = M[x][y];
//    M[x][y]=0;
//    M[x][y+1]=aux;
//    flag=1;
//  } else if (M[x][y-1]==0 && (y-1)>0) {
//    int aux = M[x][y];
//    M[x][y]=0;
//    M[x][y-1]=aux;
//    flag=1;
//  }
//  e.setM(M);
//  e.setCusto(e.getPai().getCusto()+1);
//  return e;
//}

//ArrayList<Estado> expande(Estado e) { //Expansão dos estados
//  ArrayList<Estado> filhos = new ArrayList<Estado>();
//  String est = "";
//  Estado temp = new Estado(N);
//  for (int i=0; i<N; i++) {
//    for (int j=0; j<N; j++) {
//      temp = move(i, j, temp);
//      if (flag==1) {
//        filhos.add(temp);
//      }
//      flag=0;
//    }
//  }
//  return filhos;
//}