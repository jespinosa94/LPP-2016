;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit)
        (graphics turtles))

(define (hoja? dato)
    (not (list? dato)))
                          ;-----------------;
                          ;;;;Ejercicio 1a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (arbol tam)
  (if (>= tam 5)
     (begin
      (draw tam)
      (turn 30)
      (arbol (- tam 10))
      (turn -60)
      (arbol (- tam 10))
      (turn 30)
      (move (* tam -1)))))
      

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1a________________ \n")
(turtles #t)
(turn 90)
(arbol 80)

                          ;-----------------;
                          ;;;;Ejercicio 1b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (arboles n giro tam)
  (if (= n 1)
      (begin
        (arbol tam)
        (turn giro))
      (begin
        (arbol tam)
        (turn giro)
        (arboles (- n 1) giro tam))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1b________________ \n")
(clear)    ; Limpiamos la ventana de dibujo
(turn 90)
(arboles 4 90 80)

                          ;-----------------;
                          ;;;;Ejercicio 2a;;;;
                          ;-----------------;
;;Definición de las funciones
(define lista-a '((a b) d (c (e) (f g) h)))  

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2a________________ \n")
(display "Para mostrar el elemento h hay que ejecutar la sentencia: \n(cdddr (caddr lista-a)) => ")
(display (cdddr (caddr lista-a)))

                          ;-----------------;
                          ;;;;Ejercicio 2b;;;;
                          ;-----------------;
;;Definición de las funciones
(define lista-b '(1 (6 (3) 10) (2) 8))  

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2b________________ \n")
(display "La sentencia que muestra el elemento 10 es: \n(cddr (cadr lista-b)) => ")
(display (cddr (cadr lista-b)))

                          ;-----------------;
                          ;;;;Ejercicio 3a1;;;;
                          ;-----------------;
;;Definición de las funciones
(define (suma-lista lista)
  (cond ((null? lista) 0)
        ((hoja? lista) lista)
        (else (+ (suma-lista (car lista))
                 (suma-lista (cdr lista))))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3a1________________ \n")
(display "El resultado de sumar los elementos de la lista estructurada
{1 {2 {3 {{{{4}}}} 5} 6 7}} es: ")
(display (suma-lista '(1 (2 (3 ((((4)))) 5) 6 7))))
;;Pruebas
(check-equal? (suma-lista '(1 (2 (3 ((((4)))) 5) 6 7))) 28)
(check-equal? (suma-lista '((3 4) 5 ((7) 1))) 20)
(check-equal? (suma-lista '((((((((1 2))))))))) 3)

                          ;-----------------;
                          ;;;;Ejercicio 3a2;;;;
                          ;-----------------;
;;Definición de las funciones
(define (suma-lista-FOS lista)
  (if (hoja? lista)
      lista
      (fold-right + 0 (map suma-lista-FOS lista))))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3a2________________ \n")
(display "El resultado de sumar los elementos de la lista estructurada
{1 {2 {3 {{{{4}}}} 5} 6 7}} es: ")
(display (suma-lista-FOS '(1 (2 (3 ((((4)))) 5) 6 7))))
;;Pruebas
(check-equal? (suma-lista-FOS '(1 (2 (3 ((((4)))) 5) 6 7))) 28)
(check-equal? (suma-lista-FOS '((3 4) 5 ((7) 1))) 20)
(check-equal? (suma-lista-FOS '((((((((1 2))))))))) 3)

                          ;-----------------;
                          ;;;;Ejercicio 3b1;;;;
                          ;-----------------;
;;Definición de las funciones
(define (aplana lista)
  (cond ((null? lista) '())
        ((hoja? lista) (list lista))
        (else (append (aplana (car lista))
                      (aplana (cdr lista))))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3b1________________ \n")
(display "Los elementos de la lista {1 {2 {3} 4 {5 {6 {7} 8}}}}} son: ")
(display (aplana '(1 (2 (3) 4 (5 (6 (7) 8))))))
;;Pruebas
(check-equal? (aplana '(1 (2 (3) 4 (5 (6 (7) 8))))) '(1 2 3 4 5 6 7 8))
(check-equal? (aplana '((((((((1 2))))))))) '(1 2))
(check-equal? (aplana '((3 4) 5 ((7) 1))) '(3 4 5 7 1))

                          ;-----------------;
                          ;;;;Ejercicio 3b2;;;;
                          ;-----------------;
;;Definición de las funciones
(define (aplana-FOS lista)
  (if (hoja? lista)
      (list lista)
      (fold-right append '() (map aplana-FOS lista))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3b2________________ \n")
(display "Los elementos de la lista {1 {2 {3} 4 {5 {6 {7} 8}}}}} son: ")
(display (aplana-FOS '(1 (2 (3) 4 (5 (6 (7) 8))))))
;;Pruebas
(check-equal? (aplana-FOS '(1 (2 (3) 4 (5 (6 (7) 8))))) '(1 2 3 4 5 6 7 8))
(check-equal? (aplana-FOS '((((((((1 2))))))))) '(1 2))
(check-equal? (aplana-FOS '((3 4) 5 ((7) 1))) '(3 4 5 7 1))

                          ;-----------------;
                          ;;;;Ejercicio 4a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (diff-listas l1 l2)
  (cond ((null? l1) '())
        ((hoja? l1) (if (not (equal? l1 l2))
                        (list (cons l1 l2))
                        '()))
        (else (append (diff-listas (car l1) (car l2))
                      (diff-listas (cdr l1) (cdr l2))))))
        

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4a________________ \n")
(display "Los elementos distintos entre las listas {a {b {{c}} d e} f} y {1 {b {{2}} 3 4} f} son: \n")
(display (diff-listas '(a (b ((c)) d e) f) '(1 (b ((2)) 3 4) f)))
;;Pruebas
(check-equal? (diff-listas '(a (b ((c)) d e) f) '(1 (b ((2)) 3 4) f)) (list (cons 'a 1) (cons 'c 2) (cons 'd 3) (cons 'e 4)))
(check-equal? (diff-listas '((a b) c) '((a b) c)) '())
(check-equal? (diff-listas '(a b c) '(1 2 c)) (list (cons 'a 1) (cons 'b 2)))
(check-equal? (diff-listas '() '()) '())

                          ;-----------------;
                          ;;;;Ejercicio 4b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (sustituye-elem lista elem-old elem-new)
  (cond ((null? lista) '())
        ((hoja? lista) (if (equal? lista elem-old)
                           elem-new
                           lista))
        (else (cons (sustituye-elem (car lista) elem-old elem-new)
                    (sustituye-elem (cdr lista) elem-old elem-new)))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4b________________ \n")
(display "El resultado de sustituir c por h en la lista {a b {c d {e c}} c {f {c} g}} es: \n")
(display (sustituye-elem '(a b (c d (e c)) c (f (c) g)) 'c 'h))
;;Pruebas
(check-equal? (sustituye-elem '(a b (c d (e c)) c (f (c) g)) 'c 'h) '(a b (h d (e h)) h (f (h) g)))
(check-equal? (sustituye-elem '(1 2 2 1 1 1) 3 0) '(1 2 2 1 1 1))
(check-equal? (sustituye-elem '(((((((1 2 3)) 3))) (1 3) 3)) 3 0) '(((((((1 2 0)) 0))) (1 0) 0)))

                          ;-----------------;
                          ;;;;Ejercicio 5;;;;
                          ;-----------------;
;;Definición de las funciones
(define (transformar lista plantilla)
  (cond ((null? lista) '())
        ((hoja? lista) (list-ref plantilla lista))
        (else (cons (transformar (car lista) plantilla)
                    (transformar (cdr lista) plantilla)))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 5________________ \n")
(display "La lista {{0 1} 4 {2 3}} sustituida por {hola que tal estas hoy} es: \n")
(display (transformar '((0 1) 4 (2 3)) '(hola que tal estas hoy)))
;;Pruebas
(check-equal? (transformar '((0 1) 4 (2 3)) '(hola que tal estas hoy)) '((hola que) hoy (tal estas)))
(check-equal? (transformar '(1 4 3 2 6 5 (0)) '(lambda es una forma especial de Scheme)) '(es especial forma una Scheme de (lambda)))
(check-equal? (transformar '((((2) (4) (((3)) 0 (1))))) '(hoy estoy bastante bien gracias)) '((((bastante) (gracias) (((bien)) hoy (estoy))))))
(check-equal? (transformar '(1 ((1) (1) 1)) '(por que repites)) '(que ((que) (que) que)))