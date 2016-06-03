//////////////////////
// Solución práctica 11
//////////////////////


/////////////////////////////////////////////////////////
// Ejercicio 1
/////////////////////////////////////////////////////////

indirect enum Arbol {
    case Node(Int, [Arbol])
    case Hoja(Int)
}


// Barrera de abstracción de árboles con tipo de dato Int
func datoArbol(arbol : Arbol) -> Int {
    switch arbol {
    case let .Hoja(dato) :
        return dato
    case let .Node(dato, _) :
        return dato
    }
}

func hijosArbol(arbol : Arbol) -> [Arbol] {
    switch arbol {
    case .Hoja :
        return []
    case let .Node(_, hijos) :
        return hijos
    }
}

func esHojaArbol(arbol : Arbol) ->  Bool {
    switch arbol {
    case .Hoja :
        return true
    case .Node :
        return false
    }
}


// Pruebas
let arbol1: Arbol = .Node(8, [.Hoja(2), .Hoja(12), .Node(20, [.Hoja(9), .Hoja(10)])])
let arbolHoja: Arbol = .Hoja(8)
let arbolSubHijos: Arbol = hijosArbol(arbol1)[2]
print("\n\nEjercicio 1")
print("datoArbol del arbol \(arbol1) es \(datoArbol(arbol1))\n")
print("datoArbol del arbol \(arbolSubHijos) es \(datoArbol(arbolSubHijos))\n")
print("hijosArbol del arbol \(arbol1) es \(hijosArbol(arbol1))\n")
print("hijosArbol del arbol \(arbolSubHijos) es \(hijosArbol(arbolSubHijos))\n")
print("el arbol \(arbol1) es hoja: \(esHojaArbol(arbol1))\n")
print("el arbol \(arbolHoja) es hoja: \(esHojaArbol(arbolHoja))\n")



/////////////////////////////////////////////////////////
// Ejercicio 2
/////////////////////////////////////////////////////////

//----------------------------
// Versión con Recursión mutua
//----------------------------
func sumaArbol(arbol : Arbol) -> Int {
    if esHojaArbol(arbol) {
        return datoArbol(arbol)
    }
    else {
        return datoArbol(arbol) + sumaBosque(hijosArbol(arbol))
    }
}

func sumaBosque(bosque: [Arbol]) -> Int {
    if bosque.isEmpty {
        return 0
    } else {
        let primero = bosque[0]
        let resto = Array(bosque[1..<bosque.endIndex])
        return sumaArbol(primero) + sumaBosque(resto)
    }
}


//----------------------------
// Version FOS
//----------------------------
func sumaArbolFOS(arbol : Arbol) -> Int {
    return datoArbol(arbol) + (hijosArbol(arbol).map(sumaArbolFOS)).reduce(0, combine: +)
}


// Pruebas
let arbol2: Arbol = .Node(10, [.Hoja(2), .Node(12, [.Hoja(4), .Hoja(2)]), .Node(10, [.Hoja(5)])])
print("\n\nEjercicio 2")
print("La suma del arbol \(arbol2) es \(sumaArbol(arbol2))\n")

print("La suma del arbol \(arbol2) es \(sumaArbolFOS(arbol2))\n")




/////////////////////////////////////////////////////////
// Ejercicio 3
/////////////////////////////////////////////////////////

// función auxiliar
func compruebaRaiz(arbol : Arbol, _ dato : Int) -> Int {
    if datoArbol(arbol) == dato {
        return 1
    }
    else {
        return 0
    }
}

//----------------------------
// Versión con Recursión mutua
//----------------------------
func vecesArbol(arbol : Arbol, _ dato : Int) -> Int {
    if esHojaArbol(arbol) {
        return compruebaRaiz(arbol, dato)
    }
    else {
        return compruebaRaiz(arbol, dato) + vecesBosque(hijosArbol(arbol), dato)
    }
}

func vecesBosque(bosque: [Arbol], _ dato : Int) -> Int {
    if bosque.isEmpty {
        return 0
    } else {
        let primero = bosque[0]
        let resto = Array(bosque[1..<bosque.endIndex])
        return vecesArbol(primero, dato) + vecesBosque(resto, dato)
    }
}


//----------------------------
// Version FOS
//----------------------------
func sumaArray(array : [Int]) -> Int {
    return array.reduce(0, combine: +)
}

func vecesArbolFOS(arbol : Arbol, _ dato : Int) -> Int {
    return compruebaRaiz(arbol, dato) + sumaArray(hijosArbol(arbol).map {vecesArbolFOS($0, dato)})
}

// Pruebas
let arbol3: Arbol = .Node(1, [.Node(2, [.Hoja(3), .Hoja(1)]), .Hoja(3), .Node(4, [.Hoja(3), .Hoja(2)])])
let dato2 = 2
let dato3 = 3
let dato0 = 0
print("\n\nEjercicio 3")
print("La veces que aparece el dato \(dato2) en el arbol \(arbol3) es \(vecesArbol(arbol3, dato2))\n")
print("La veces que aparece el dato \(dato3) en el arbol \(arbol3) es \(vecesArbol(arbol3, dato3))\n")
print("La veces que aparece el dato \(dato0) en el arbol \(arbol3) es \(vecesArbol(arbol3, dato0))\n")

print("La veces que aparece el dato \(dato2) en el arbol \(arbol3) es \(vecesArbolFOS(arbol3, dato2))\n")
print("La veces que aparece el dato \(dato3) en el arbol \(arbol3) es \(vecesArbolFOS(arbol3, dato3))\n")
print("La veces que aparece el dato \(dato0) en el arbol \(arbol3) es \(vecesArbolFOS(arbol3, dato0))\n")




/////////////////////////////////////////////////////////
// Ejercicio 4
/////////////////////////////////////////////////////////

//----------------------------
// Versión con Recursión mutua
//----------------------------
func sumaHijosArbol(arbol : Arbol) -> Bool {
    if esHojaArbol(arbol) {
        return true
    } else {
        return(datoArbol(arbol) == sumaArray(hijosArbol(arbol).map(datoArbol)))
               &&
               sumaHijosBosque(hijosArbol(arbol))
    }
}

func sumaHijosBosque(bosque: [Arbol]) -> Bool {
    if bosque.isEmpty {
        return true
    } else {
        let primero = bosque[0]
        let resto = Array(bosque[1..<bosque.endIndex])
        return sumaHijosArbol(primero) && sumaHijosBosque(resto)
    }
}


//----------------------------
// Version FOS
//----------------------------
// función auxiliar
func andArray(array : [Bool]) -> Bool {
    return array.reduce(true, combine: {$0 && $1})
}


func sumaHijosArbolFOS(arbol : Arbol) -> Bool {
    if esHojaArbol(arbol) {
        return true
    } else {
        return(datoArbol(arbol) == sumaArray(hijosArbol(arbol).map(datoArbol)))
               &&
            (andArray(hijosArbol(arbol).map(sumaHijosArbolFOS)))
    }
}

// Pruebas
let arbol4: Arbol = .Node(35, [.Hoja(5), .Node(20, [.Hoja(13), .Hoja(7)]), .Node(10, [.Hoja(10)])])
let arbol5: Arbol = .Node(35, [.Hoja(5), .Node(20, [.Hoja(13), .Hoja(7)]), .Node(10, [.Hoja(5)])])
let arbol6: Arbol = .Node(35, [.Hoja(5), .Node(22, [.Hoja(15), .Hoja(7)]), .Node(10, [.Hoja(5)])])
print("\n\nEjercicio 4")
print("Los hijos del arbol \(arbol4) suman:  \(sumaHijosArbol(arbol4))\n")
print("Los hijos del arbol \(arbol5) suman:  \(sumaHijosArbol(arbol5))\n")
print("Los hijos del arbol \(arbol6) suman:  \(sumaHijosArbol(arbol6))\n")

print("Los hijos del arbol \(arbol4) suman:  \(sumaHijosArbolFOS(arbol4))\n")
print("Los hijos del arbol \(arbol5) suman:  \(sumaHijosArbolFOS(arbol5))\n")
print("Los hijos del arbol \(arbol6) suman:  \(sumaHijosArbolFOS(arbol6))\n")




/////////////////////////////////////////////////////////
// Ejercicio 5
/////////////////////////////////////////////////////////

indirect enum ArbolG<T> {
    case Node(T, [ArbolG<T>])
    case Hoja(T)
}


// Barrera de abstracción de árboles con tipo de dato genérico
func datoArbolG<T>(arbol : ArbolG<T>) -> T {
    switch arbol {
    case let .Hoja(dato) :
        return dato
    case let .Node(dato, _) :
        return dato
    }
}

func hijosArbolG<T>(arbol : ArbolG<T>) -> [ArbolG<T>] {
    switch arbol {
    case .Hoja :
        return []
    case let .Node(_, hijos) :
        return hijos
    }
}

func esHojaArbolG<T>(arbol : ArbolG<T>) ->  Bool {
    switch arbol {
    case .Hoja :
        return true
    case .Node :
        return false
    }
}



func sumaArbolG<T>(arbol : ArbolG<T>, suma:(T,T)->T, neutro elem:T) -> T {
    return suma(datoArbolG(arbol), (hijosArbolG(arbol).map {sumaArbolG($0, suma: suma, neutro: elem)}).reduce(elem, combine: suma))
}


// Pruebas
let arbolInt: ArbolG = .Node(8, [.Hoja(2), .Hoja(12)])
let t1 = (8,10)
let t2 = (2,7)
let t3 = (6,4)
let arbolTuplas: ArbolG = .Node(t1, [.Hoja(t2), .Hoja(t3)])
print("\n\nEjercicio 5")
print("La suma del arbol \(arbolInt) es \(sumaArbolG(arbolInt, suma : +, neutro : 0))\n")
print("La suma del arbol \(arbolTuplas) es \(sumaArbolG(arbolTuplas, suma : {($0.0 + $1.0, $0.1 + $1.1)}, neutro : (0, 0)))\n")

