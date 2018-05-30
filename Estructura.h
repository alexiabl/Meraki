#ifndef ESTRUCTURA_CLASS
#define ESTRUCTURA_CLASS
#include <list>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

template <typename T>

class Estructura
{
public:
    Estructura()
    {
        numEntradas = 15; //número de posibles reglas en la gramática
        arreglo.resize(numEntradas);
    };
    // Especifica número de reglas en la gramática

    /* NOTA: como es un vector de listas, C++ no permite realizar estas inserciones 
       (los nombres de las reglas) en el vector como tal, sin embargo, como nosotros vamos 
       a insertar los tokens manualmente dentro de las listas que corresponden a cada regla no 
       hace falta. Esto significa que la lista en la posición 0 del vector corresponde a la gramática
       de main y así sucesivamente. Sabiendo esto haremos insert("token1",1) para insertar 
       "token1" en la lista de LLamado (que es la lista 1). 
       
       Especificación de las listas de reglas en el vector:
        //arreglo[0]= Main
        //arreglo[1]= Llamado
        //arreglo[2]= Funcion
        //arreglo[3]= Si
        //arreglo[4]= Mientras
        //arreglo[5]= Haga
        //arreglo[6]= Imprimir
        //arreglo[7]= Devuelva
        //arreglo[8]= Asignacion
        //arreglo[9]= Declaracion
        //arreglo[10]= Iteracion
       */
    
    ~Estructura()// Destructor
    {
        for(int i=0; i<numEntradas; i++) arreglo[i].clear(); //limpia las listas
        arreglo.clear(); //limpia el vector
    };

    T* search(const T& token,int pos) //busca token específico en la lista de una regla específica
    {
        typename list<T>::iterator it; //para accesar a la posición del arreglo correspondiente
        it = arreglo[pos].begin(); //me posiciono en el primer elemento de la lista

        while(it != arreglo[pos].end() && *it != token) //busco en cada nodo de la lista correspondiente
        {
            //se detiene al llegar al final de la lista o encontrar token
            std::advance(it,1); //cada que no se encuentre el token, avanzo un nodo
        }
        //se llega al elemento deseado, si existe

        if(*it == token)
        {
            std::cout<< "token encontrado " << *it << endl;
            return &*it;
        }
        else //si se llegó al final de la lista y ninguno es el token
        {
            std::cout<< "token NO encontrado "  << endl;
            return NULL;
        }

    }; // Retorna un puntero a la llave o NULL si no se encuentra

    void insert(const T& token, int pos)
    {
        arreglo[pos].push_back(token); //se inserta al final de la lista
    };
    // Inserta el elemento en la lista de una regla

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
};
#endif
