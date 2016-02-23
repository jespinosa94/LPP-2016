;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))


                          ;;;;Ejercicio 1;;;;
(define (new-cond c1 x c2 y z)
  (cond
    (c1 x)
    (c2 y)
    (else z)))
;;Ejemplos del enunciado
(display "\n\n Ejercicio 1 \n")
(display "new-cond evalua las expresiones que recibe de distinta manera, 
 primero evalúa todos los resultados y devuelve el correcto y sin embargo
cond evalua las expresiones y a partir de ellas devuelve el resultado correcto.")
(display "\n apartado b")
(display "AND y OR son formas especiales por la misma razón que cond,
 primero evalúan las expresiones, no los resultados, para comprobarlo
 volveremos a incluir una expresión donde se divida por 0")
(and (< 3 2) (= 1 1) (/ 3 0))
(or (< 3 2) (= 1 1) (/ 3 0))

                          ;;;;Ejercicio 2;;;;
;;Definición de las funciones
(define (menor n1 n2)
  (if (< n1 n2)
      n1
      n2))
  
(define (minimo lista)
  (if (null? (cdr lista))
      (car lista)
      (menor (car lista) (minimo (cdr lista)))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 2 \n")
(display "el elemento más pequeño de la lista (9 8 6 4 3) es: ")
(display (minimo '(9 8 6 4 3)))

;;Pruebas
(check-equal? (minimo '(9 8 6 4 3)) 3)
(check-equal? (minimo '(9 8 3 6 4)) 3)
(check-equal? (minimo '(10 50 -1 30 31 2 1)) -1)
(check-equal? (minimo '(1 2 3 4 5 6 7)) 1)

                          ;;;;Ejercicio 3;;;;
;;Definición de las funciones
(define (ordenada-decrecientemente? lista-nums)
  (if (null? (cdr lista-nums))
      #t
      (and (>= (car lista-nums) (cadr lista-nums))
           (ordenada-decrecientemente? (cdr lista-nums)))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 3 \n")
(display "¿Está ordenada decrecientemente la lista 99 59 45 23 -1? ")
(display (ordenada-decrecientemente? '(99 59 45 23 -1)))

;;Pruebas
(check-true (ordenada-decrecientemente? '(99 59 45 23 -1)))
(check-false (ordenada-decrecientemente? '(12 50 -1 293 1000)))
(check-true (ordenada-decrecientemente? '(3)))
(check-false (ordenada-decrecientemente? '(2 3 4 5)))
(check-true (ordenada-decrecientemente? '(-1 -2 -3 -4)))

                          ;;;;Ejercicio 4;;;;
;;Definición de las funciones
(define (engloba? a1 a2 b1 b2)
  (cond
    ((and (<= a1 b1) (>= a2 b2)))
    ((and (>= a1 b1) (<= a2 b2)))
    (else #f)))
(define (engloban-intervalos? a b)
   (if (or (equal? a 'vacio) (equal? b 'vacio))
      #t
  (engloba? (car a) (cdr a) (car b) (cdr b))))  

;;Ejemplos del enunciado
(display "\n\n Ejercicio 4 \n")
(define i1 (cons 4 9))
(define i2 (cons 3 10))
(define i3 (cons 12 15))
(define i4 (cons 8 19))
(display "¿Engloban los intervalos [5,9] y [4,8]? ")
(display (engloban-intervalos? (cons 5 9) (cons 4 8)))

;;Pruebas
(check-false (engloban-intervalos? (cons 5 9) (cons 4 8)))
(check-true (engloban-intervalos? i1 i2))
(check-true (engloban-intervalos? i3 'vacio))
(check-true (engloban-intervalos? (cons 4 10) (cons 5 9)))
(check-true (engloban-intervalos? (cons 4 9) (cons 4 15)))
(check-false (engloban-intervalos? (cons 2 6) (cons 4 8)))
(check-false (engloban-intervalos? (cons -4 1) (cons -5 0)))
(check-true (engloban-intervalos? (cons 15 16) (cons 11 16)))

                          ;;;;Apartado b;;;;
;;Definición de las funciones
 (define (union-intervalos a b)
    (if (or (equal? a 'vacio) (equal? b 'vacio))
      (if (equal? a 'vacio)
          b
          a)
   (cons (min (car a) (car b)) (max (cdr a) (cdr b))))) 

;;Ejemplos del enunciado
(display "\n\n Apartado b \n")
(display "La unión de los intervalos [4,10] y [3,8] es: ")
(display (union-intervalos (cons 4 10) (cons 3 8)))

;;Pruebas
(check-equal? (union-intervalos (cons 4 10) (cons 3 8)) (cons 3 10))
(check-equal? (union-intervalos i2 i3) (cons 3 15))
(check-equal? (union-intervalos 'vacio i4) (cons 8 19))
(check-equal? (union-intervalos (cons 1 5) (cons 2 5)) (cons 1 5))
(check-equal? (union-intervalos (cons -3 0) (cons -4 -1)) (cons -4 0))

                          ;;;;Apartado c;;;;
;;Definición de las funciones
(define (intersectan? a1 a2 b1 b2)
    (if (and (<= b1 a2) (<= a1 b2))
    #t
    #f))
(define (interseccion-intervalos a b)
  (if (or (equal? a 'vacio) (equal? b 'vacio))
      'vacio
      (if (intersectan? (car a) (cdr a) (car b) (cdr b))
          (cons (max (car a) (car b)) (min (cdr a) (cdr b)))
          'vacio)))

;;Ejemplos del enunciado
(display "\n\n Apartado c \n")
(display "La intersección de los intervalos [4,10] y [8, 15] es: ")
(display (interseccion-intervalos (cons 4 10) (cons 8 15)))

;;Pruebas
(check-equal? (interseccion-intervalos (cons 4 10) (cons 8 15)) (cons 8 10))
(check-equal? (interseccion-intervalos i1 i3) 'vacio)
(check-equal? (interseccion-intervalos 'vacio i4) 'vacio)
(check-equal? (interseccion-intervalos (cons -2 4) (cons -6 -1)) (cons -2 -1))
(check-equal? (interseccion-intervalos (cons 2 6) (cons 3 5)) (cons 3 5))

                          ;;;;Ejercicio 5;;;;
;;Definición de las funciones
(define (union-lista-intervalos lista-intervalos)
  (if (null? (cdr lista-intervalos))
      (car lista-intervalos)
      (union-intervalos (car lista-intervalos) (union-lista-intervalos
                                                (cdr lista-intervalos)))))
(define (interseccion-lista-intervalos lista-intervalos)
  (if (null? (cdr lista-intervalos))
      (car lista-intervalos)
      (interseccion-intervalos (car lista-intervalos) (interseccion-lista-intervalos
                                                       (cdr lista-intervalos)))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 5 \n")
(display "La unión de la lista de intervalos [2,12] [-1, 10] [8, 20] es: ")
(display (union-lista-intervalos (list (cons 2 12) (cons -1 10) (cons 8 20))))

;;Pruebas
(check-equal? (union-lista-intervalos (list (cons 2 12) (cons -1 10) (cons 8 20))) (cons -1 20))
(check-equal? (interseccion-lista-intervalos (list (cons 12 30) (cons -8 20) (cons 13 35))) (cons 13 20))
(check-equal? (interseccion-lista-intervalos (list (cons 25 30) (cons -8 20) (cons 13 35))) 'vacio)
(check-equal? (union-lista-intervalos (list (cons -5 -3) (cons -6 -3) (cons 2 3) (cons 1 3))) (cons -6 3))
(check-equal? (interseccion-lista-intervalos (list (cons 2 10) (cons 3 9) (cons -1 0))) 'vacio)