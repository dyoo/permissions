#lang racket/base


(define records '())
(provide records record-permission)

(define (record-permission a-module-source permissions)
  (printf "I see ~s~n" (list a-module-source permissions))
  (set! records (cons (list a-module-source permissions)
                      records)))
