#include <list>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

template <typename T>

class PilaToken
{
    public:
        int posicionInicial;
        int posicionFinal;
        list<T> tipo;

        PilaToken(int posI, int posF, list<T> tipoItem){
            posicionInicial = posI;
            posicionFinal = posF;
            tipo = tipoItem;
        }; 

        public void setPosicionInicial(int posI){
            this.posicionInicial = posI;
        }

        public int getPosicionInicial(){
            return this.posicionInicial;
        }

        public void setPosicionFinal(int posF){
            this.posicionFinal = posF;
        }

        public int getPosicionFinal(){
            return this.posicionFinal;
        }

        public void setTipo(list<T> t){
            this.tipo = t;
        }

        public list<T> getTipo(){
            return this.tipo;
        }

};