(setq doom-font (font-spec :family "Roboto Mono" :size 14 :adstyle "Regular")
      doom-variable-pitch-font (font-spec :family "sans"))

(setq doom-theme 'doom-ayu-mirage)

(setq user-full-name "Lydien SANDANASAMY"
      user-mail-address "s.lydien@icloud.com")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(defun lydien/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (hide-mode-line-mode 1)
  (display-line-numbers-mode 0))

(defun lydien/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook! org-mode
      (lydien/org-mode-setup)
      (lydien/org-mode-visual-fill))

(setq org-directory "~/doc/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-roam-directory (concat org-directory "notes/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db")
      org-journal-encrypt-journal t
      org-journal-file-format "%d%m%Y.org"
      org-startup-folded 'overview
      org-ellipsis " ⤵" )

(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam--capture-get-point)
       "%?"
       :file-name "%(format-time-string \"%d-%m-%Y_%HH%M-${slug}\" (current-time) t)"
       :head "#+title: ${title}\n"
       :unnarrowed t)))

(setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(map! "C-c C-s" 'counsel-tramp)
