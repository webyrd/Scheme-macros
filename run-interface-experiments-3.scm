(load "mk-vicare.scm")
(load "mk.scm")

(define appendo
  (lambda (l s ls)
    (conde
      ((== '() l) (== s ls))
      ((fresh (a d res)
         (== (cons a d) l)
         (== (cons a res) ls)
         (appendo d s res))))))

(run* (l s) (appendo l s '(a b c)))
'((() (a b c)) ((a) (b c)) ((a b) (c)) ((a b c) ()))

(define (take-1-k stream)
  (case-inf (stream)
    (() (values (lambda () #f) 'done))
    ((f) (take-1-k f))
    ((c) (values (lambda () #f) c))
    ((c f) (values f c))))

(define-syntax run-a-little
  (syntax-rules ()
    [(_ next (q) g0 g ...)
     (begin
       ;; () -> stream
       (define my-stream
         (suspend
          ((fresh (q) g0 g ...
             (lambda (st)
               (let ((st (state-with-scope st nonlocal-scope)))
                 (let ((z ((reify q) st)))
                   (cons z (lambda () (lambda () #f)))))))
           empty-state)))
       ;; () -> 'done | value
       ;; effect: mutates my-stream
       (define (next)         
         (define-values (new-stream result) (take-1-k my-stream))
         (set! my-stream new-stream)
         result)
       (next))]
    [(_ next (x x* ...) g0 g* ...)
     (run-a-little next (q)
       (fresh (x x* ...)
         (== (list x x* ...) q)
         g0 g* ...))]))

#!eof

(load "run-interface-experiments-3.scm")

(run-a-little my-next (l s) (appendo l s '(1 2 3)))
'(() (1 2 3))

(my-next)
'((1) (2 3))

(my-next)
'((1 2) (3))

(my-next)
'((1 2 3) ())

(my-next)
'done

(my-next)
'done
