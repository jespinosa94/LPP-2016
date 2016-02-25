;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit))

                          ;-----------------;
                          ;;;;Ejercicio 1a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (suma-lista-nums lista1 lista2)
  (if (null? lista1)
      '()
      (cons (+ (car lista1) (car lista2))
            (suma-lista-nums (cdr lista1) (cdr lista2)))))

(define (divide-lista-nums lista1 lista2)
  (if (null? lista1)
      '()
      (cons (/ (car lista1) (car lista2))
            (divide-lista-nums (cdr lista1) (cdr lista2)))))

;;Ejemplos del enunciado
(display "\n\n               _____________Ejercicio 1a________________ \n")
(display "El resultado de sumar las listas {10, 8, 4, 6} y {2, 5, 3, 4} es: ")
(display (suma-lista-nums '(10 8 4 6) '(2 5 3 4)))
(display "\nEl resultado de dividir las listas {10, 8, 1, 8} y {2, 16, 3, 4} es: ")
(display (divide-lista-nums '(10 8 1 8) '(2 16 3 4)))
;;Pruebas
(check-equal? (suma-lista-nums '(10 8 4 6) '(2 5 3 4)) '(12 13 7 10))
(check-equal? (suma-lista-nums '(-1 -1 -1) '(2 3 0)) '(1 2 -1))
(check-equal? (suma-lista-nums '(10 5 3 -5) '(10 5 3 -5)) '(20 10 6 -10))
(check-equal? (divide-lista-nums '(10 8 1 8) '(2 16 3 4)) '(5 1/2 1/3 2))
(check-equal? (divide-lista-nums '(-2 5 20) '(1 5 10)) '(-2 1 2))
(check-equal? (divide-lista-nums '(4) '(9)) '(4/9))

                          ;-----------------;
                          ;;;;Ejercicio 1b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (opera-listas f lista1 lista2)
  (if (null? lista1)
      '()
      (cons (f (car lista1) (car lista2))
            (opera-listas f (cdr lista1) (cdr lista2)))))

;;Ejemplos del enunciado
(display "\n\n               _____________Ejercicio 1b________________ \n")
(display "El resultado de sumar las listas {10, 8, 4, 6} y {2, 5, 3, 4} es: ")
(display (opera-listas + '(10 8 4 6) '(2 5 3 4)))
(display "\nEl resultado de dividir las listas {10, 8, 1, 8} y {2, 16, 3, 4} es: ")
(display (opera-listas / '(10 8 1 8) '(2 16 3 4)))
;;Pruebas
(check-equal? (opera-listas + '(10 8 4 6) '(2 5 3 4)) '(12 13 7 10))
(check-equal? (opera-listas + '(-1 -1 -1) '(2 3 0)) '(1 2 -1))
(check-equal? (opera-listas + '(10 5 3 -5) '(10 5 3 -5)) '(20 10 6 -10))
(check-equal? (opera-listas / '(10 8 1 8) '(2 16 3 4)) '(5 1/2 1/3 2))
(check-equal? (opera-listas / '(-2 5 20) '(1 5 10)) '(-2 1 2))
(check-equal? (opera-listas / '(4) '(9)) '(4/9))

                          ;-----------------;
                          ;;;;Ejercicio 2a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (aplica-funciones lista-parejas)
  (if (null? lista-parejas)
      '()
      (cons ((caar lista-parejas) (cdar lista-parejas))
            (aplica-funciones (cdr lista-parejas)))))

;;Ejemplos del enunciado
(display "\n\n               _____________Ejercicio 2a________________ \n")
(display " El resultado de aplicar (even? 6) (null? '(4) (list 8) y (car'(1 2 3) es: ")
(display (aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))))
;;Pruebas
(check-equal? (aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) '(#t #f (8) 1))
(check-equal? (aplica-funciones (list (cons null? '()) (cons cdr '(1 4)))) '(#t (4)))

                          ;-----------------;
                          ;;;;Ejercicio 2b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (f pareja)
  ((car pareja) (cdr pareja)))
(define (aplica-funciones-FOS lista-parejas)
  (map f lista-parejas))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2b________________ \n")
(display " El resultado de aplicar (even? 6) (null? '(4) (list 8) y (car'(1 2 3) es: ")
(display (aplica-funciones-FOS (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))))
;;Pruebas
(check-equal? (aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) '(#t #f (8) 1))
(check-equal? (aplica-funciones (list (cons null? '()) (cons cdr '(1 4)))) '(#t (4)))

                          ;-----------------;
                          ;;;;Ejercicio 3a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (aplana-lista lista)
  (fold-right (lambda (l1 l2)
                (append l1 l2))
              '() lista))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3a________________ \n")
(display "El resultado de aplanar las listas {1, 2, 3} {4, 5, 6} {7} es: ")
(display (aplana-lista '((1 2 3) (4 5 6) (7))))
;;Pruebas
(check-equal? (aplana-lista '((1 2 3) (4 5 6) (7))) '(1 2 3 4 5 6 7))
(check-equal? (aplana-lista '(('a 'b 'c) ())) '('a 'b 'c))
(check-equal? (aplana-lista '(('a 'b) ('c 'd))) '('a 'b 'c 'd))

                          ;-----------------;
                          ;;;;Ejercicio 3b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (cons (car pareja)
            (expande-pareja (cons (car pareja)
                                  (- (cdr pareja) 1))))))
(define (expande lista-parejas)
  (aplana-lista (map expande-pareja lista-parejas)))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3b________________ \n")
(display "El resultado de expandir la lista de parejas {(#t . 3) (LPP . 2) ('b . 4)}) es: ")
(display (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))))
;;Pruebas
(check-equal? (expande-pareja (cons 'a 6)) '(a a a a a a))
(check-equal? (expande-pareja (cons 'a 0)) '())
(check-equal? (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))) '(#t #t #t "LPP" "LPP" b b b b))
(check-equal? (expande (list)) '())
(check-equal? (expande (list (cons 4 3))) '(4 4 4))
(check-equal? (expande '()) '())

                          ;-----------------;
                          ;;;;Ejercicio 3c;;;;
                          ;-----------------;
;;Definición de las funciones
(define (suma-impares-pares lista-num)
  (fold-right (lambda (x pareja)
                (if (odd? x)
                    (cons (+ x (car pareja)) (cdr pareja))
                    (cons (car pareja) (+ x (cdr pareja)))))
                     (cons 0 0) lista-num))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3c________________ \n")
(display "La suma de pares e impares de la lista (3, 2, 1, 4, 8, 7, 6, 5) es: ")
(display (suma-impares-pares '(3 2 1 4 8 7 6 5)))
;;Pruebas
(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) (cons 16 20))
(check-equal? (suma-impares-pares '(3 1 5)) (cons 9 0))
(check-equal? (suma-impares-pares '(-3 6 5 9 -1 -15 -2 -4)) (cons -5 0))
(check-equal? (suma-impares-pares '()) (cons 0 0))

                          ;-----------------;
                          ;;;;Ejercicio 4;;;;
                          ;-----------------;
;;Definición de las funciones
(define (filtra-simbolos lista-simbolos lista-num)
  (map (lambda (x y)
         ((= (string-length (symbol->string x)) y))
         (cons x y))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4________________ \n")
(display "(filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6))  : ")
(display (filtra-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6)))

;;Pruebas
(check-equal? (filtra-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6))
              (list (cons 'un 2) (cons 'ejercicio 9) (cons 'examen 6)))
(check-equal? (filtra-simbolos '(no era muy dificil de sacar) '(2 3 3 7 2 5))
              (list (cons 'no 2) (cons 'era 3) (cons 'muy 3) (cons 'dificil 7)
                    (cons 'de 2) (cons 'sacar 5)))
(check-equal? (filtra-simbolos '(este tiene que salir vacio) '( 1 1 1 1 1))
              '())