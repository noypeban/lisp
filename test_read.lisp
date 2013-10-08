#! /home/ml1_2/bin/clisp

(defun split-by-one-space (string)
  "Returns a list of substrings of string
  divided by ONE space each.
  Note: Two consecutive spaces will be seen as
  if there were an empty string between them."
  (loop for i = 0 then (1+ j)
        as j = (position #\Space string :start i)
        collect (subseq string i j)
        while j))

(defun split-by-space (string)
 (remove "" 
  (split-by-one-space string)
  :test #'equal))

(let (acc)
  (with-open-file (in "/home/s1zr64g_10/YLOG_EDI/EDI/130925/reportTranVio"
                    ;"~/lisp/test.txt"
                    )
    (loop for line = (read-line in nil)
          while line 
          do 
          (cond
            ((zerop (length line)) nil)
            ((member (substring line 0 1) '("#" "*") :test #'equal)
             "comment line"
             nil)
            ((string/= (substring line 0 1) " ")
             (setq acc line))
            (acc
             (let ((lst (split-by-space line)))
              (format t "~a ~a ~a ~a~%"
               acc
               ;lst
               (nth 3 lst)
               (nth 2 lst)
               (or (nth 5 lst)
                (nth 4 lst))
               ))
             (setq acc nil)
             )))))
