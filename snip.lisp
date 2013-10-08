;;;my snippet

;load text
(let ((in (open "~/.zshrc" :external-format charset:utf-8)))
  (when in
    (loop for line = (read-line in nil)
          while line do (format t "~a~%" line))
    (close in)))

(with-open-file (in "~/.zshrc" :external-format charset:utf-8)
  (loop for line = (read-line in nil)
        while line do (format t "~a~%" line)))

;format ; http://super.para.media.kyoto-u.ac.jp/~tasuku/format-func.html
(format t "test")
"1st argument is output stream. t=>stdout, nil=>return string"

(format t "this is ~A string." "test")
=>this is test string.
"~a: princ style"

(format t "this is ~S string." "test")
=>this is "test" string.
"~s: prin1 style"

;path http://d.hatena.ne.jp/inuzini-jiro/20101228/1293536975
;; pathname からファイル名を取得
(file-namestring #P"/tmp/hoge.tgz")
;; => "hoge.tgz"

;; pathname から拡張子を取得
(pathname-type #P"/tmp/hoge.tgz")
;; => "tgz"

;; pathname からファイル名(拡張子無し)を取得
(pathname-name #P"/tmp/hoge.tgz")
;; => "hoge"

;; pathname からディレクトリを取得
(pathname-directory #P"/tmp/hoge.tgz")
;; => (:ABSOLUTE "tmp")

(pathname-directory #P"tmp/hoge.tgz")
;; => (:RELATIVE "tmp")

;; pathname からドライブレターを取得
(pathname-device #P"D:/tmp/hoge.tgz")
;; => "D"

(defun read-list (endchar)
  (lambda (s c)
    (declare (ignore c));「使われてないヨ」warning抑制のために宣言
    (read-delimited-list endchar s T)))

(let ((*readtable* (copy-readtable nil)))
  (set-syntax-from-char #\, #\Space)
  (set-macro-character #\[ (read-list #\]))
  (set-syntax-from-char #\] #\))
  ;; 
  (read-from-string "[1,2,3,4,5,6,7,8,9]"))
