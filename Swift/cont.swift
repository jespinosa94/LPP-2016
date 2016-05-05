func cuadrado(x: Int) -> Int {
  return x * x
}
func compruebaParejas(array: ArraySlice<Int>, funcion: (Int)-> Int) -> [(Int, Int)] {
  if(array.isEmpty) {
    return []
  } else if array.count>1 {
    let primero = array[array.startIndex]
    let segundo = array[array.startIndex+1]
    let resto = array[array.startIndex+1..<array.endIndex]
    if(funcion(primero) == segundo) {
      return [(primero, segundo)] + compruebaParejas(resto, funcion: cuadrado)
    } else {
      return compruebaParejas(resto, funcion: cuadrado)
    }
  } else {
    return []
  }
}

print(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))

enum Intervalo {
  case Limites (Int, Int)
  case Vacio
}
let intervalo1 = Intervalo.Limites(10, 20)
let intervalo2 = Intervalo.Limites(15, 30)
let intervalo3 = Intervalo.Limites(25, 30)
let intervalo4 = Intervalo.Vacio

func union(intervalo1: Intervalo, intervalo2: Intervalo) -> (Int, Int) {
  
}
