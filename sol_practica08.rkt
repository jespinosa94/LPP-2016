;;-------------------------
;; Solución práctica 8
;--------------------------

#lang r6rs
(import (rnrs)
        (rnrs mutable-pairs)
        (schemeunit))



;--------------------------
; Ejercicio 1
;--------------------------
(define (crear-lista-circular-aux! clista ref)
  (if (null? (cdr ref))
      (set-cdr! ref (cdr clista))
      (crear-lista-circular-aux! clista (cdr ref))))

(define (crear-lista-circular! clista)
  (crear-lista-circular-aux! clista clista))


; Demostración y Pruebas
(display "\nEjercicio 1\n")
(define clista '(*clista* 1 4 9 7))
(crear-lista-circular! clista)
(display clista) ;⇒ {*clista* . #0={1 4 9 7 . #0#}}
(newline)




;--------------------------
; Ejercicio 2
;--------------------------
;;foto

(define (intercambia-siguiente! ref)
  (let ((aux (cddr ref)))            ;; 1
    (begin
      (set-cdr! (cdr ref) (cdr aux)) ;; 2
      (set-cdr! aux (cdr ref))       ;; 3
      (set-cdr! ref aux))))          ;; 4


(define (intercambia-elementos! lista)
  (if (not (null? (cdr lista)))
      (begin
        (intercambia-siguiente! lista)
        (intercambia-elementos! (cddr lista)))))


; Demostración y Pruebas
(display "\nEjercicio 2\n")
(define lista '(*clist* 1 2 3 4)) 
(intercambia-elementos! lista) 
(display lista) ; ⇒ (*clist* 2 1 4 3)
(newline)
(check-equal? lista '(*clist*  2 1 4 3))
(define lista2 '(*clist* 1 2)) 
(intercambia-elementos! lista2) 
(check-equal? lista2 '(*clist*  2 1))




;--------------------------
; Ejercicio 3
;--------------------------

(define (make-pila)
  (list '*pila*))

(define (vacia-pila? pila)
  (null? (cdr pila)))

(define (push-pila! pila dato)
  (set-cdr! pila (cons dato (cdr pila))))

(define (pop-pila! pila)
  (if (not (vacia-pila? pila))
      (let ((item (cadr pila)))
        (set-cdr! pila (cddr pila))
        item)))

                              
; Demostración y Pruebas
(display "\nEjercicio 3\n")
(define pila1 (make-pila))
(push-pila! pila1 10)
(push-pila! pila1 "hola")
(push-pila! pila1 'a)
(check-equal? (pop-pila! pila1) 'a)
(check-equal? (pop-pila! pila1) "hola")
(check-equal? (pop-pila! pila1) 10)
(check-true (vacia-pila? pila1))
(display (pop-pila! pila1)) ;⇒ #<void>
(newline)




;--------------------------
; Ejercicio 4
;--------------------------

;;
;; En la parte derecha de cada pareja del diccionario
;; guardaremos otra pareja con el valor y el número de veces 
;; que se ha actualizado. Las parejas que guardaremos
;; en la lista de asociación tendrán la siguiente estructura:
;;
;; {clave . {valor . cambios}}
;; 
;; Por ejemplo, después de realizar las operaciones del ejemplo
;; tendremos como diccionario la siguiente lista:
;; 
;; {*dic* {b . {10 . 1}} {a . {30 . 2}}}
;;

(define (make-dic)
  (list '*dic*))

(define (get-dic dic clave)
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        #f
        (cadr pareja))))

(define (put-dic! dic clave valor)
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        (set-cdr! dic
                  (cons (cons clave (cons valor 1))
                        (cdr dic)))
         (begin
          (set-car! (cdr pareja) valor)
          (set-cdr! (cdr pareja) (+ (cddr pareja) 1)))))
  'ok)

(define (cambios-dic dic clave)
  (let ((pareja (assq clave (cdr dic))))
    (if (not pareja)
        0
        (cddr pareja))))

    
; Demostración y Pruebas
(display "\nEjercicio 4\n")
(define dic (make-dic))
(check-equal? (put-dic! dic 'a 20) 'ok)
(check-equal? (cambios-dic dic 'a) 1)
(check-equal? (put-dic! dic 'a 30) 'ok)
(check-equal? (cambios-dic dic 'a) 2)
(check-equal? (get-dic dic 'a) 30)
(check-equal? (cambios-dic dic 'b) 0)
(check-equal? (put-dic! dic 'b 10) 'ok)
(check-equal? (cambios-dic dic 'b) 1)




;--------------------------
; Ejercicio 5
;--------------------------
(define (memorizador func)
  (let ((pila (make-pila)))
    (lambda (x)
      (if (equal? x 'mem)
          (pop-pila! pila)
          (let ((res (func x)))
            (push-pila! pila res)
            res)))))

; Demostración y Pruebas
(display "\nEjercicio 5\n")
(define (cuadrado x)
  (* x x))
(define f (memorizador cuadrado))
(check-equal? (f 10) 100)
(check-equal? (f 3) 9)
(check-equal? (f 2) 4)
(check-equal? (f 'mem) 4)
(check-equal? (f 'mem) 9)
(check-equal? (f 6) 36)
(check-equal? (f 'mem) 36)
(check-equal? (f 'mem) 100)
(display (f 'mem)) ;⇒ #<void>
(newline)
