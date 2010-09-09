#lang racket/base

(require (for-syntax scheme/base))

(define-syntax (require-permission stx)
  (syntax-case stx ()
    [(_ perms ...)
     (andmap (compose string? syntax-e) (syntax->list #'(perms ...)))
     (begin
       (printf "hello at compile time\n")
       
       (with-syntax ([permissions (datum->syntax stx 'permissions)])
         (syntax/loc stx
           (begin
             (provide permissions)
             (define permissions (list perms ...))
             (printf "I've defined permissions as: ~s~n" permissions)
             (void)))))]))



(provide require-permission)