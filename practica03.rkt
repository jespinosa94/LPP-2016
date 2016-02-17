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

                          ;;;;Ejercicio 2a;;;;
;;Definición de las funciones
(define (intercambia-elem pareja)
  (cons (cdr pareja) (car pareja)))  

;;Ejemplos del enunciado
(display "\n\n Ejercicio 2a \n")
(display "El resultado de intercambiar la pareja (10 . 5) es: ")
(display (intercambia-elem (cons 10 5)))

;;Pruebas
(check-equal? (intercambia-elem (cons 10 5)) (cons 5 10))
(check-equal? (intercambia-elem (cons '() 1)) (cons 1 '()))
(check-equal? (intercambia-elem (cons -2 5)) (cons 5 -2))

                          ;;;;Ejercicio 2b;;;;
;;Definición de las funciones
(define (suma-izq n pareja)
  (if (equal? n 0)
      pareja
      (cond
        ((> n 0) (suma-izq (- n 1) (cons (+ (car pareja) 1) (cdr pareja))))
        ((< n 0) (suma-izq (+ n 1) (cons (- (car pareja) 1) (cdr pareja)))))))
(define (suma-der n pareja)
  (if (equal? n 0)
      pareja
      (cond
        ((> n 0) (suma-der (- n 1) (cons (car pareja) (+ (cdr pareja) 1))))
        ((< n 0) (suma-der (+ n 1) (cons (car pareja) (- (cdr pareja) 1)))))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 2b \n")
(display "El resultado de sumar 5 a la parte izquierda de (10 . 20) es: ")
(display (suma-izq 5 (cons 10 20)))
(display "\nEl resultado de sumar 6 a la parte derecha de (10 . 20) es: ")
(display (suma-der 6 (cons 10 20)))
;;Pruebas
(check-equal? (suma-izq 5 (cons 10 20)) (cons 15 20))
(check-equal? (suma-izq -1 (cons 3 5)) (cons 2 5))
(check-equal? (suma-izq 5 (cons -3 5)) (cons 2 5))
(check-equal? (suma-der 6 (cons 10 20)) (cons 10 26))
(check-equal? (suma-der -3 (cons 1 -3)) (cons 1 -6))
(check-equal? (suma-der 10 (cons 1 -3)) (cons 1 7))

                          ;;;;Ejercicio 2c;;;;
;;Definición de las funciones
(define (suma-impares-pares lista-num)
  (if (null? lista-num)
      (cons 0 0)
      (if (odd? (car lista-num))
          (suma-izq (car lista-num) (suma-impares-pares (cdr lista-num)))
      (suma-der (car lista-num) (suma-impares-pares (cdr lista-num))))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 2c \n")
(display "La suma de pares e impares de la lista (3, 2, 1, 4, 8, 7, 6, 5) es: ")
(display (suma-impares-pares '(3 2 1 4 8 7 6 5)))

;;Pruebas
(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) (cons 16 20))
(check-equal? (suma-impares-pares '(3 1 5)) (cons 9 0))
(check-equal? (suma-impares-pares '(-3 6 5 9 -1 -15 -2 -4)) (cons -5 0))
(check-equal? (suma-impares-pares '()) (cons 0 0))

                          ;;;;Ejercicio 3;;;;
;;Definición de las funciones
  

;;Ejemplos del enunciado
(display "\n\n Ejercicio 3 \n")

;;Pruebas