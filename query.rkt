#lang racket/base

(require racket/contract)

(provide/contract [query-module-permissions
                   (module-path? . -> . (listof string?))])

;; query-module-permissions: module-path -> (listof string)
;; Given a module, see what permissions it is declaring.
(define (query-module-permissions a-module-path)
  (parameterize ([current-namespace (make-base-empty-namespace)])
    (namespace-require/expansion-time a-module-path)
    (printf "~s\n" (namespace-mapped-symbols))
    #;(namespace-variable-value 'records)
    #;(namespace-variable-value 'permissions)))


(query-module-permissions "t/open-image-url.rkt")