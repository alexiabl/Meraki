#ifndef ESTRUCTURA_CLASS
#define ESTRUCTURA_CLASS
#include <list>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <queue>
using namespace std;

struct PilaToken
{
    int posicionInicial;
    int posicionFinal;
    int tipo;
};

template <typename T>
class Estructura
{
public:
    int numEntradas;
    // Nœmero de entradas en el arreglo
    vector<list<T> > arreglo;
    // El arreglo es un vector de listas de STL
    queue<PilaToken> pila;
    string reglas [15] = {"Asignacion", "Devuelva","Declaracion","Iteracion","Comparacion","Imprimir",
                          "Haga","Mientras","Si","Funcion","BloqueCodigo","BloqueMain","Main","Bloque","Meraki"
                         };
    //contadores
    int Asignacion = 0;
    int Devuelva  = 0;
    int Declaracion  = 0;
    int Iteracion  = 0;
    int Comparacion  = 0;
    int Imprimir  = 0;
    int Haga  = 0;
    int Mientras  = 0;
    int Si  = 0;
    int Funcion  = 0;
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
    "token1" en la lista de LLamado (que es la lista 1).
    */

    int search(const T& token,int pos,int aparicion) //token específico en la lista de una regla específica
    {
        typename list<T>::iterator iter;

        iter = arreglo[pos].begin(); //me posiciono en el primer elemento de la lista
        if(aparicion!=0) std::advance(iter,aparicion); //track de última aparición de la regla en la misma lista

        while(iter != arreglo[pos].end() && *iter != token) //busco en cada nodo de la lista correspondiente
        {
            //se detiene al llegar al final de la lista o encontrar token
            std::advance(iter,1); //cada que no se encuentre el token, avanzo un nodo
            aparicion+=1;
        }
        //se llega al elemento deseado, si existe

        if(*iter == token)
        {
            // std::cout<< "token encontrado " << *it << endl;
            return aparicion;
        }
        else //si se llegó al final de la lista y ninguno es el token
        {
            //  std::cout<< "token NO encontrado "  << endl;
            return -1;
        }

    }; // Retorna un puntero a la llave o NULL si no se encuentra

    void insert(const T& token, int pos)
    {
        arreglo[pos].push_back(token); //se inserta al final de la lista
    };
    // Inserta el elemento en la lista de una regla

    void actualizarPila(const T& tokenI, const T& tokenF, int regla)
    {
        int aparicion = encontrarContador(regla);
        PilaToken tok; //objeto para insertar a la pila, es uno por regla
        tok.tipo = regla; //ocupamos una forma de traducir la posición a la regla que es, como guardar las reglas en un vector por aparte

        //le damos el token inicial y final de la regla que tenemos en la lista
        //y vemos dónde empieza y termina esa regla específica

        tok.posicionInicial = search(tokenI,regla,aparicion);
        tok.posicionFinal = search(tokenF,regla,aparicion);
        pila.push(tok); //insertar en la pila el objeto con la info
        aumentarContador(regla);
    }

    int encontrarContador(int regla)
    {
        switch(regla)
        {
        case 0: return Asignacion;
        case 1: return Devuelva;
        case 2: return Declaracion;
        case 3: return Iteracion;
        case 4: return Comparacion;
        case 5: return Imprimir;
        case 6: return Haga;
        case 7: return Mientras;
        case 8: return Si;
        case 9: return Funcion;
        case 10: return BloqueCodigo;
        case 11: return BloqueMain;
        case 12: return Main;
        case 13: return Bloque;
        case 14: return Meraki;
        }
    }
    void aumentarContador(int regla)
    {
        switch(regla)
        {
        case 0: Asignacion = arreglo[0].size();
        case 1: Devuelva = arreglo[1].size();
        case 2: Declaracion = arreglo[2].size();
        case 3: Iteracion = arreglo[3].size();
        case 4: Comparacion= arreglo[4].size();
        case 5: Imprimir = arreglo[5].size();
        case 6: Haga = arreglo[6].size();
        case 7: Mientras = arreglo[7].size();
        case 8: Si = arreglo[8].size();
        case 9: Funcion = arreglo[9].size();
        case 10: BloqueCodigo = arreglo[10].size();
        case 11: BloqueMain = arreglo[11].size();
        case 12: Main = arreglo[12].size();
        case 13: Bloque = arreglo[13].size();
        case 14: Meraki = arreglo[14].size();
        }
    }
    void imprimir()
    {
        for (int i = 0; i < numEntradas; i++) //acceso a cada una de las listas
        {
            std::cout << "lista #" << i << ": ";
            for (typename list<T>::iterator it2 = arreglo[i].begin(); it2 != arreglo[i].end(); it2++)
            {
                std::cout << *it2 << " "; //recorrido individual de cada nodo de la lista
            }
            std::cout << std::endl;
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
