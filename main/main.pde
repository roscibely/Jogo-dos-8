
void setup(){
  size(400,400); //<>//
  background(128,128,128);
}

int N=3;
int[][] a = {{1,2,3},{4,5,6},{7,8,9}};
int[][] a1 = {{5,2,8},{4,1,6},{7,3,9}};

Estado e = new Estado(a);

Estado queue_dropMenor(ArrayList<Estado> queue) {
  float menorAvaliacao = queue.get(0).f;
  int p = 0;
  for (int i=1; i<queue.size(); i++) {
    if (queue.get(i).f<menorAvaliacao) {
      menorAvaliacao = queue.get(i).f;
      p = i;
    }
  }
  Estado estado = queue.get(p);
  queue.remove(p);
  return estado;
}

boolean igual(Estado a, Estado b){
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      if(a.M[i][j]!=b.M[i][j]){
        return false;
      }
    }
  }
  return true;
}

boolean existe(ArrayList<Estado> list, Estado a){
  for(Estado e: list){
    if(igual(e,a))
      return true;
  }
  return false;
}

ArrayList<Estado> solucao = new ArrayList<Estado>();

void A(){
  ArrayList<Estado> queue = new ArrayList<Estado>();
  ArrayList<Estado> temp = new ArrayList<Estado>();
  ArrayList<Estado> visitados = new ArrayList<Estado>();
  solucao.add(e);
  queue.add(e);
  while (!queue.isEmpty()) {
    Estado estado = queue_dropMenor(queue);
    visitados.add(estado);
    estado.imprime();
    if (estado.isObjective()) {
       temp.add(estado);    
      while(estado.pai!=null){     
        estado = estado.pai;
        if(!existe(temp, estado))
        temp.add(estado); 
      }
      for(int i=temp.size();i>0;i--){
        solucao.add(temp.get(i-1));
      }
      print("Estado objetivo");
      return;
    }
    ArrayList<Estado> filhos = estado.expande();
    for (int i=0; i<filhos.size(); i++) {
      if(!existe(queue,filhos.get(i)) && !existe(visitados,filhos.get(i)))
        queue.add(filhos.get(i));
        filhos.get(i).imprime();
    }
  }
}

//TABULEIRO

void criar(int[][] m) {
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      Peca p = new Peca(m[j][i], j*width/N, i*height/N, width/N, height/N);
    }
  }
}

void embaralha(){
  for(int i=0;i<20;i++){
    ArrayList<Estado> filhos = e.expande(); 
    e = filhos.get((int)random(0,filhos.size()));
  }
}

int s = 0;
int i = 0;
void draw(){
  if(s==0) {
    embaralha(); //<>//
    A();
  }
  s=1;  
  criar(solucao.get(i).M);
  i++;
  if(i==solucao.size()) i=solucao.size()-1;
  delay(500);

}