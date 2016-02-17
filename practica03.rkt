;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))


                          ;;;;Ejercicio 1 - Apartados a, b y c;;;;
;;Definición de las funciones
(define p1 (cons (cons 1 2) (cons 3 '())))
(define p2 (cons (list "a" "b" '()) '()))
(define p3 (list 4 p1 p2 5))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 1- Apartados a, b y c\n")
(display p1)
(display p2)
(display p3)
(display "P1, P2 y P3 son listas porque son tipos de datos que tienen
         más de 2 tipos de datos guardados, el número de elementos de cada lista son:
         P1: 5
         P2: 5
         P3: 2\n")
;;Pruebas
;;no puedo utilizar check-equal aquí
;;(check-equal? (cdadr p3) (3))
(display "cdadr mostrará el número: ")
(display (cdadr p3)) ;;3
(display "\ncdddr mostrará el número: ")
(display (cdddr p3)) ;;5

                          ;;;;Ejercicio 2;;;;
;;Definición de las funciones
  

;;Ejemplos del enunciado
(display "\n\n Ejercicio 2 \n")

;;Pruebas