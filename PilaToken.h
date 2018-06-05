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

        PilaToken(){
            
        };

        void setPosicionInicial(int posI){
            posicionInicial = posI;
        }

        int getPosicionInicial(){
            return posicionInicial;
        }

        void setPosicionFinal(int posF){
            posicionFinal = posF;
        }

        int getPosicionFinal(){
            return posicionFinal;
        }

        void setTipo(list<T> t){
            tipo = t;
        }

        list<T> getTipo(){
            return tipo;
        }

};
