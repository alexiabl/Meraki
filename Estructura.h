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

       /* NOTA: como es un vector de listas, C++ no permite realizar estas inserciones
       (los nombres de las reglas) en el vector como tal, sin embargo, como nosotros vamos
       a insertar los tokens manualmente dentro de las listas que corresponden a cada regla no
       hace falta. Esto significa que la lista en la posición 0 del vector corresponde a la gramática
       de asignación y así sucesivamente. 

       Especificación de las listas de reglas en el vector:
       // arreglo[0]="Asignacion";
       // arreglo[1]="Devuelva";
       // arreglo[2]="Declaracion";
       // arreglo[3]="Iteracion";
       // arreglo[4]="Comparacion";
       // arreglo[5]="Imprimir";
       // arreglo[6]="Haga";
       // arreglo[7]="Mientras";
       // arreglo[8]="Si";
       // arreglo[9]="Funcion";
       // arreglo[10]="BloqueCodigo";
       // arreglo[11]="BloqueMain";
       // arreglo[12]="Main";
       // arreglo[13]="Bloque";
       // arreglo[14]="Meraki";
       */

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
            // std::cout<< "token encontrado " << *it << endl;
            return contador;
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

    void actualizarPila(const T& tokenI, const T& tokenF, int pos)
    {
        PilaToken tok; //objeto para insertar a la pila, es uno por regla
        tok.tipo = pos; //eventual traducción?

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
        
        std::cout << std::endl;
        cout << "pop pila" << endl;
        
        while (!pila.empty())
        {
            PilaToken obj = pila.front();
            cout << "tipo regla: " << obj.tipo << endl;
            cout << "posI: " << obj.posicionInicial << endl;
            cout << "posF: " << obj.posicionFinal << endl;
            pila.pop();
        }
    }

private:
    int numEntradas;
    // Nœmero de entradas en el arreglo
    vector<list<T> > arreglo;
    // El arreglo es un vector de listas de STL
    queue<PilaToken> pila;
    // Arreglo con la definicion de las posiciones del arreglo de tipos o reglas
    string reglas[15] = {"Asignacion", "Devuelva","Declaracion","Iteracion","Comparacion","Imprimir",
    "Haga","Mientras","Si","Funcion","BloqueCodigo","BloqueMain","Main","Bloque","Meraki"};
};
#endif
