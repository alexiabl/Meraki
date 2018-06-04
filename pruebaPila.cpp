#include <stack>
#include <list>
#include <string.h>
#include <iostream>
#include <cstdlib>

#include "PilaToken.h"

using namespace std;

class pruebaPila{

int main(int, char**) {
    std::list<string> tipo; 
    PilaToken<string> pt;

    
    pt.setPosicionFinal(4);
    pt.setPosicionInicial(0);
    pt.setTipo(tipo);


    std::stack<PilaToken<string>> stack;

    stack.push(pt);

    std::cout << "Popping out elements...";

  while (!stack.empty())
  {
     std::cout << " " << stack.top() << std::endl;
     std::cout << "hola" << std::endl;
     stack.pop();
  }

return 0;

}

};
