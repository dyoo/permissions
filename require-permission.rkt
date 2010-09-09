#lang racket/base

(require (for-syntax scheme/base))

(define-syntax (require-permission stx)
  (syntax-case stx ()
    [(_ perms ...)
     (andmap (compose string? syntax-e) (syntax->list #'(perms ...)))
     (with-syntax ([permissions (datum->syntax stx 'permissions)])
       (syntax/loc stx
         (begin
           (provide permissions)
           (define permissions (list (#%datum perms) ...)))))]))




(provide require-permission)