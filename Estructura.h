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



    int search(const T& token,int pos) //token específico en la lista de una regla específica
    {
        int contador=0;
        typename list<T>::iterator it; //para accesar a la posición del arreglo correspondiente
        it = arreglo[pos].begin(); //me posiciono en el primer elemento de la lista

        while(it != arreglo[pos].end() && *it != token) //busco en cada nodo de la lista correspondiente
        {
            //se detiene al llegar al final de la lista o encontrar token
            std::advance(it,1); //cada que no se encuentre el token, avanzo un nodo
            contador+=1;
        }
        //se llega al elemento deseado, si existe

        if(*it == token)
        {
            std::cout<< "token encontrado " << *it << endl;
            return contador;
        }
        else //si se llegó al final de la lista y ninguno es el token
        {
            std::cout<< "token NO encontrado "  << endl;
            return -1;
        }

    }; // Retorna la posición de un token en la lista correspondiente

    void insert(const T& token, int pos)
    {
        arreglo[pos].push_back(token); //se inserta al final de la lista      
    };
    // Inserta el elemento en la lista de una regla

    void actualizarPila(const T& tokenI, const T& tokenF, int pos)
    {
        PilaToken tok; //objeto para insertar a la pila, es uno por regla
        tok.tipo = pos; //ocupamos una forma de traducir la posición a la regla que es, como guardar las reglas en un vector por aparte

        //por ahora dejo esto así, le damos el token inicial y final de la regla que tenemos en la lista
        //y vemos dónde empieza y termina esa regla específica

        tok.posicionInicial = search(tokenI,pos);
        tok.posicionFinal = search(tokenF,pos);
        pila.push(tok); //insertar en la pila el objeto con la info
    }

    void imprimir()
    {
        for (int i = 0; i < numEntradas; i++) //acceso a cada una de las listas
        {
            std::cout << "lista #" << i << ": ";
            for (typename list<T>::iterator it = arreglo[i].begin(); it != arreglo[i].end(); it++)
            {
                std::cout << *it << " "; //recorrido individual de cada nodo de la lista
            }
            std::cout << std::endl;
        }
    }

private:
    int numEntradas;
    // Nœmero de entradas en el arreglo
    vector<list<T> > arreglo;
    // El arreglo es un vector de listas de STL
    queue<PilaToken> pila;
};
#endif
