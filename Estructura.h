#ifndef ESTRUCTURA_CLASS
#define ESTRUCTURA_CLASS
#include <list>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <queue>
#include <algorithm>
using namespace std;

struct PilaToken //objeto con información para la pila
{
    int posicionInicial; //donde empieza una regla
    int posicionFinal; //donde termina una regla
    int tipo; //para cada regla(lista)
};

struct tokenLista //token que será insertado en una lista(regla)
{
    string * tok; //token recibido desde bison
    string tipo; //sublista a la que pertenece el token
};

void imprimirObjeto(tokenLista &obj) //imprime el objeto de un tokenLista
{
    cout << obj.tipo << endl;
    cout << *(obj.tok) << endl;
}

string gettoken(tokenLista &obj)
{
    return *(obj.tok);
}

string getsublista(tokenLista &obj)
{
    return obj.tipo;
}

struct simbolos //información para la tabla de símbolos
{
    string token;
    string regla;
    int linea_inicio;
    int linea_fin;
};
void actualizarSimbolos(simbolos &s, tokenLista &obj, int li, int lf) //set de los símbolos
{
    s.token = gettoken(obj);
    s.regla = getsublista(obj);
    s.linea_inicio = li;
    s.linea_fin = lf;
}

class Estructura
{
public:
    int numEntradas; // Nœmero de entradas en el arreglo

    vector<list<tokenLista> > arreglo; // El arreglo es un vector de listas de STL que contienen objetos tokenLista

    queue<PilaToken> pila; //cola que funciona como pila FIFO

    string reglas [15] = {"Asignacion", "Devuelva","Declaracion","Iteracion","Comparacion","Imprimir",
                          "Haga","Mientras","Si","Funcion","BloqueCodigo","BloqueMain","Main","Bloque","Meraki"
                         }; //conjunto de posibles reglas en el arreglo (posiciones)

    list<simbolos> tablaSimbolos; //lista de símbolos que contienen información de los símbolos

    //contadores para saber la cantidad de tokens insertados por instancia de la regla
    int Asignacion = 0;
    int Devuelva  = 0;
    int Declaracion  = 0;
    int Iteracion = 0;
    int Comparacion = 0;
    int Imprimir  = 0;
    int Haga = 0;
    int Mientras = 0;
    int Si = 0;
    int Funcion = 0;
    int BloqueCodigo = 0;
    int BloqueMain = 0;
    int Main = 0;
    int Bloque = 0;
    int Meraki = 0;

    Estructura()
    {
        numEntradas = 15; //15 posibles reglas en la gramática
        arreglo.resize(numEntradas);
    };
    // Especifica número de reglas en la gramática y las coloca en el arreglo

    ~Estructura()// Destructor
    {
        for(int i=0; i<numEntradas; i++) arreglo[i].clear();
        arreglo.clear(); //limpia el vector
    };

    /* NOTA: como es un vector de listas, C++ no permite realizar estas inserciones
    (los nombres de las reglas) en el vector como tal, sin embargo, como nosotros vamos
    a insertar los tokens manualmente dentro de las listas que corresponden a cada regla no
    hace falta. Esto significa que la lista en la posición 0 del vector corresponde a la gramática
    de main y así sucesivamente. Sabiendo esto haremos insert("token1",1) para insertar
    "token1" en la la lista 1.
    */

    int search(string token,int pos,int aparicion) //token específico en la lista de una regla específica
    {                                             //aparición es #de instancia de la regla dentro de la lista
        typename list<tokenLista>::iterator iter;

        iter = arreglo[pos].begin(); //me posiciono en el primer elemento de la lista
        if(aparicion!=0) std::advance(iter,aparicion); //track de última aparición de la regla en la misma lista

           while(iter != arreglo[pos].end() && gettoken(*iter) != token) //busco en cada nodo de la lista correspondiente
           {
               //se detiene al llegar al final de la lista o encontrar token
               std::advance(iter,1); //cada que no se encuentre el token, avanzo un nodo
               aparicion+=1;
           }
           //se llega al elemento deseado, si existe

           if(gettoken(*iter) == token)
           {
               // std::cout<< "token encontrado " << *it << endl;
               return aparicion;
           }
           else //si se llegó al final de la lista y ninguno es el token
           {
               //  std::cout<< "token NO encontrado "  << endl;
               return -1;
           }

    };

    void insert(string *token, int lista, int sublista)
    {
        tokenLista obj;
        obj.tipo = reglas[sublista]; //sub regla a la que pertenece
        obj.tok = token;
        arreglo[lista].push_back(obj); //se inserta al final de la lista
    };
    // Inserta el elemento en la lista de una regla

    void actualizarPila(int regla)
    {
        PilaToken tok; //objeto para insertar a la pila, es uno por regla
        tok.tipo = regla;
        tok.posicionInicial = encontrarContador(regla);
        tok.posicionFinal = aumentarContador(regla)-1;
        pila.push(tok); //insertar en la pila el objeto con la info

    }

    void actualizarTabla(tokenLista obj, int li,int lf) //para llamar cuando una regla pueda contener símbolos
    {
        simbolos s; //hago un nuevo objeto de símbolos que contiene info de variables
        actualizarSimbolos(s,obj,li,lf); //objeto de símbolos, objeto token, linea inicial, linea final
        tablaSimbolos.push_front(s); //se inserta esta info en la lista (tabla de símbolos)
    }

    int encontrarContador(int regla)
    {
        switch(regla)
        {
        case 0:
            return Asignacion;
        case 1:
            return Devuelva;
        case 2:
            return Declaracion;
        case 3:
            return Iteracion;
        case 4:
            return Comparacion;
        case 5:
            return Imprimir;
        case 6:
            return Haga;
        case 7:
            return Mientras;
        case 8:
            return Si;
        case 9:
            return Funcion;
        case 10:
            return BloqueCodigo;
        case 11:
            return BloqueMain;
        case 12:
            return Main;
        case 13:
            return Bloque;
        case 14:
            return Meraki;
        }
    }
    int aumentarContador(int regla)
    {
        switch(regla)
        {
        case 0:
            Asignacion = arreglo[0].size();
            return Asignacion;
        case 1:
            Devuelva = arreglo[1].size();
            return Devuelva;
        case 2:
            Declaracion = arreglo[2].size();
            return Declaracion;
        case 3:
            Iteracion = arreglo[3].size();
            return Iteracion;
        case 4:
            Comparacion= arreglo[4].size();
            return Comparacion;
        case 5:
            Imprimir = arreglo[5].size();
            return Imprimir;
        case 6:
            Haga = arreglo[6].size();
            return Haga;
        case 7:
            Mientras = arreglo[7].size();
            return Mientras;
        case 8:
            Si = arreglo[8].size();
            return Si;
        case 9:
            Funcion = arreglo[9].size();
            return Funcion;
        case 10:
            BloqueCodigo = arreglo[10].size();
            return BloqueCodigo;
        case 11:
            BloqueMain = arreglo[11].size();
            return BloqueMain;
        case 12:
            Main = arreglo[12].size();
            return Main;
        case 13:
            Bloque = arreglo[13].size();
            return Bloque;
        case 14:
            Meraki = arreglo[14].size();
            return Meraki;
        }
    }
    void imprimir() //imprime la estructura de vector de listas
    {
        for (int i = 0; i < numEntradas; i++) //acceso a cada una de las listas
        {
            if(!arreglo[i].empty())
            {
                std::cout << "Regla " << reglas[i] << ": ";
                for (typename list<tokenLista>::iterator it2 = arreglo[i].begin(); it2 != arreglo[i].end(); it2++)
                {
                    cout << gettoken(*it2) << " ";
                }
                std::cout << std::endl;
            }
        }
        std::cout << std::endl;
        cout << "pop pila" << endl;

        while (!pila.empty())
        {
            PilaToken obj = pila.front();
            cout << "tipo regla: " << reglas[obj.tipo] << endl;
            cout << "posI: " << obj.posicionInicial << endl;
            cout << "posF: " << obj.posicionFinal << endl;
            pila.pop();
        }
    }
};
#endif
///Asignación = 0 y Declaración = 2 ->los tipos que buscamos en los objetos de la lista

