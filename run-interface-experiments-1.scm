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


(define-syntax run-a-little
  (syntax-rules ()
    [(_ next done (q) g0 g ...)
     (begin
       (define my-stream
         (suspend
          ((fresh (q) g0 g ...
             (lambda (st)
               (let ((st (state-with-scope st nonlocal-scope)))
                 (let ((z ((reify q) st)))
                   (cons z (lambda () (lambda () #f)))))))
           empty-state)))
       (define (next)
         (let ((old-stream my-stream))
           (set! my-stream (my-stream))
           (case-inf my-stream
             (()
              (begin
                (set! my-stream old-stream)
                'done))
             ((f) (next))
             ((c) c)
             ((c f)
              (begin
                (set! my-stream f)
                c)))))
       (next))]
    [(_ next done (x x* ...) g0 g* ...)
     (run-a-little next done (q)
       (fresh (x x* ...)
         (== (list x x* ...) q)
         g0 g* ...))]))

#!eof

(load "run-interface-experiments-1.scm")

(run* (l s) (appendo l s '(a b c)))
'((() (a b c)) ((a) (b c)) ((a b) (c)) ((a b c) ()))

(run-a-little my-next dun (l s) (appendo l s '(a b c)))
'(() (a b c))

(my-next)
'((a) (b c))

(my-next)
'((a b) (c))

(my-next)
'((a b c) ())

(my-next)
'dun

(my-next)
'dun
