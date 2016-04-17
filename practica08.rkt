
;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit)
        (rnrs mutable-pairs))
;(import (rnrs base)
;        (rnrs io simple)
;        (schemeunit))

                          ;-----------------;
                          ;;;;Ejercicio 1;;;;
                          ;-----------------;
;;Definición de las funciones
(define (ultima-pareja olist)
  (if (null? (cdr olist))
      olist
      (ultima-pareja (cdr olist))))

(define (crear-lista-circular! clista)
  (set-cdr! (ultima-pareja clista) (cdr clista)))

(define clista '(clista 1 4 8 7))
(define lista1 '(lista1))
(define lista2 '(lista2 1))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1________________ \n")
(crear-lista-circular! clista)
(crear-lista-circular! lista1)
(crear-lista-circular! lista2)
(display clista)
(display "\n")
(display lista1)
(display "\n")
(display lista2)

                          ;-----------------;
                          ;;;;Ejercicio 2;;;;
                          ;-----------------;
;;Definición de las funciones

(define (intercambia-elementos! lista)
  (cond
    ((null? (cdr lista)) '())
    ((null? (cdddr lista)) (muta-items lista))
    (else
     (muta-items lista)
     (intercambia-elementos! (cddr lista)))))

(define (muta-items lista)
   (let ((aux (cdr lista)))
     (set-cdr! lista (cddr lista))
     (set-cdr! aux (cddr lista))
     (set-cdr! (cdr lista) aux)))

(define listap '(listap 1 2))
(define lista '(clist 1 2 3 4))
(define l '(clista 1 4 8 7 1 10))
(define q '(lista2))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2________________ \n")
(intercambia-elementos! lista)
(display "Se alteran los elementos de la lista {*clist*->1->2->3->4}: ")
(display lista)
;;Pruebas
(intercambia-elementos! listap)
(intercambia-elementos! l)
(intercambia-elementos! q)
(check-equal? lista '(clist 2 1 4 3))
(check-equal? listap '(listap 2 1))
(check-equal? l '(clista 4 1 7 8 10 1))
(check-equal? q '(lista2))

                          ;-----------------;
                          ;;;;Ejercicio 3;;;;
                          ;-----------------;
;;Definición de las funciones
(define (make-pila)
  (list '*stack*))
(define (push-pila! pila dato)
   (cond
     ((vacia-pila? pila) (set-cdr! pila (cons dato '())))
     (else (let ((aux (cdr pila)))
             (set-cdr! pila (cons dato '()))
             (set-cdr! (cdr pila) aux)))))

(define (pop-pila! pila)
  (if (not (vacia-pila? pila))
           (set-cdr! pila (cddr pila))))
(define (vacia-pila? pila)
  (if(null? (cdr pila))
     #t
     #f))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3________________ \n")
(define pila1 (make-pila))
(display "Añadir valores 10, hola y 'a: ")
(push-pila! pila1 10)
(push-pila! pila1 "hola")
(push-pila! pila1 'a)
(display pila1) (display "\nQuitar elementos de la cabeza x3: ")
(pop-pila! pila1)
(pop-pila! pila1)
(pop-pila! pila1)
(display pila1)(display "\n¿Está vacía? ")
(display (vacia-pila? pila1))
(display "\n Quitar elementos de la cabeza x1: ")
(pop-pila! pila1) ;La pila está vacía y se intenta eliminar un elemento
(display pila1)
(display "\n¿Está vacía? ")
(display (vacia-pila? pila1))(display "\n")
;;Pruebas
(define pila2 (make-pila))
(check-equal? (vacia-pila? pila2) #t)
(push-pila! pila2 "esto")
(push-pila! pila2 "estará")
(push-pila! pila2 "al")
(push-pila! pila2 "revés")
(check-equal? (vacia-pila? pila2) #f)
(check-equal? pila2 '(*stack* "revés" "al" "estará" "esto"))
(pop-pila! pila2)
(pop-pila! pila2)
(check-equal? pila2 '(*stack* "estará" "esto"))
(check-equal? (vacia-pila? pila2) #f)

                          ;-----------------;
                          ;;;;Ejercicio 4;;;;
                          ;-----------------;
;;Definición de las funciones
(define (make-dic)
  (list '*dic*))

(define (get-dic dic clave)
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        #f
        (cadr pareja)))) ;al ser una lista ahora hay que acceder a este elemento

(define (put-dic! dic clave valor)
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        (set-cdr! dic
                  (cons (cons clave (cons valor 1)) ;se altera la pareja convirtiendola en una lista almacenando valor y contador
                        (cdr dic)))
        (set-cdr! pareja (cons valor (+ 1 (cddr pareja)))))) ;se altera también la pareja haciendo una lista
  'ok)  

(define (cambios-dic diccionario clave) ;igual que get, pero accediendo al contador
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        0
        (cddr pareja))))

  ;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4________________ \n")
(define dic (make-dic))
(display "Añadir la clave 'a y valor 20: " )
(put-dic! dic 'a 20)
(display (cambios-dic dic 'a))
(display "\nAñadir la clave 'a y valor 30: ")
(put-dic! dic 'a 30)
(display (cambios-dic dic 'a))
(display "\nObtener el valor de la clave 'a: ")
(display (get-dic dic 'a))
(display "\nObtener la clave 'b: ")
(display (cambios-dic dic 'b))
(display "\nAñadir la clave 'b y valor 10: ")
(put-dic! dic 'b 10)
(display (cambios-dic dic 'b))
;;Pruebas
(define dic2 (make-dic))
(put-dic! dic 1 "una alteración")
(check-equal? (cambios-dic dic 1) 1)
(put-dic! dic 2 "una alteracion")
(check-equal? (cambios-dic dic 2) 1)
(put-dic! dic 2 "dos alteraciones")
(check-equal? (cambios-dic dic 2) 2)
(check-equal? (cambios-dic dic 3) 0)

                          ;-----------------;
                          ;;;;Ejercicio 5;;;;
                          ;-----------------;
;;Definición de las funciones
(define (memorizador func)
  (let ((p (make-pila)))
    (lambda (x)
      (cond
        ((equal? x 'mem) (if (not (vacia-pila? p))
                             (let ((aux (cadr p)))
                            (pop-pila! p)
                                         aux)))
          (else (push-pila! p (func x)) (func x))))))

(define (dispatcher mensaje p)
  (if (equal? mensaje 'mem)
      (pop-pila! p)
      ("Error: mensaje deconocido"))
  dispatcher)

(define (cuadrado x)
  (* x x))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 5________________ \n")
(define f (memorizador cuadrado))
(display "(f 10): ")
(display (f 10))
(display "\n(f 3): ")
(display (f 3))
(display "\n(f 2): ")
(display (f 2))
(display "\n(f 'mem): ")
(display (f 'mem))
(display "\n(f 'mem): ")
(display (f 'mem))
(display "\n(f 6): ")
(display (f 6))
(display "\n(f 'mem): ")
(display (f 'mem))
(display "\n(f 'mem): ")
(display (f 'mem))
(display "\n(f 'mem): ")
(display (f 'mem))
;;Pruebas
(define (suma2 n) ;incrementa en 2 unidades el número n
  (+ n 2))
(define h (memorizador suma2))
(check-equal? (h 3) 5)
(h 3)
(h 5)
(check-equal? (h 'mem) 7)
(h 10)
(h 20)
(check-equal? (h 3) 5)