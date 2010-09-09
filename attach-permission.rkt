#lang racket/base

(require (for-syntax scheme/base))

(define-syntax (attach-permission stx)
  (syntax-case stx ()
    [(_ id some-string ...)
     (andmap (compose string? syntax-e) (syntax->list #'(some-string ...)))
     (begin
       
       ;; What do I do here to annotate the binding at compile time?
       
       (syntax/loc stx
         (void)))]))



(provide attach-permission)