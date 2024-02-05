Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "epi-0006.scm")
> passed
> (run* (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
  ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))
> (define eng
    (make-engine
      (lambda () 3))) 
> make-engine
#<procedure make-engine>
> (make-engine
    (lambda () 3))
#<procedure>
> (define eng
    (make-engine
      (lambda () 3)))
> eng
#<procedure>
> (eng
   1000 ; ticks of fuel
   (lambda (v t) v) ; complete
   (lambda (e) 'engine-ran-out-of-fuel)   ; expire
   )
1000
> (eng
   1000 ; ticks of fuel
   (lambda (t v) v) ; complete
   (lambda (e) 'engine-ran-out-of-fuel)   ; expire
   )
3
> (eng
   1000 ; ticks of fuel
   (lambda (t v) (list t v)) ; complete
   (lambda (e) 'engine-ran-out-of-fuel)   ; expire
   )
(1000 3)
> (define eng
    (make-engine
      (lambda () (* 3 4))))
> (eng
   1000 ; ticks of fuel
   (lambda (t v) (list t v)) ; complete
   (lambda (e) 'engine-ran-out-of-fuel)   ; expire
   )
(1000 12)
> (define eng
    (make-engine
      (lambda ()
        ((lambda (x) (x x)) (lambda (x) (x x))))))
> ((lambda (x) (x x)) (lambda (x) (x x)))
  C-c C-c
break> r
> (define eng
    (make-engine
      (lambda ()
        ((lambda (x) (x x)) (lambda (x) (x x))))))
> (eng
   1000 ; ticks of fuel
   (lambda (t v) (list t v)) ; complete
   (lambda (e) 'engine-ran-out-of-fuel)   ; expire
   )
engine-ran-out-of-fuel
> 