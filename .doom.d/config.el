;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Iosevka nerd font" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/cloud/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq confirm-kill-emacs nil)

(visual-line-mode 1)
(adaptive-wrap-prefix-mode 1)

(dolist  (mode   '(org-mode-hook
                   term-mode-hook
                   shell-mode-hook
                   eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Key Mappings
(map! :map (outline-mode-map global-map evil-org-mode-map)
      :niver "C-s"    'evil-write
      :n     "<esc>"  'evil-write
      :nv    "C-j"   'evil-forward-paragraph
      :nv    "C-k"   'evil-backward-paragraph)

(map! :map (evil-org-mode-map)
      :nv       "j"     'evil-next-visual-line
      :nv       "k"     'evil-previous-visual-line)

(map! :map (evil-org-mode-map org-agenda-mode-map)
      "M-L"    'org-agenda-date-later-hours
      "M-H"    'org-agenda-date-earlier-hours
      "M-l"    'org-agenda-date-later-minutes
      "M-h"    'org-agenda-date-earlier-minutes)


(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.15)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-indent nil   :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  ;; (set-face-attribute 'org-verbatim nil :foreground "MediumPurple1" :bold t) ;:inherit '(shadow fixed-pitch)
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch))


(defun efs/org-mode-setup ()
  (visual-line-mode 1)
  (hl-todo-mode 1)
  ;; (org-indent-mode)
  (variable-pitch-mode 1))


(use-package! org
  :hook (org-mode . efs/org-mode-setup)
  :config

  (setq org-ellipsis " ▾")
  (setq org-hide-emphasis-markers t)

  (setq org-agenda-files
        '("~/cloud/org/agenda/Tasks.org"
          "~/cloud/org/agenda/Inbox.org"
          "~/cloud/org/agenda/Birthday.org"))

  (setq org-todo-keywords
        '((sequence "WAIT(v)" "TODO(t)" "NEXT(n)" "WIP(w)" "|" "DONE(d!)" "CANCEL(c)")
          (sequence "IDEA(i)" "PLAN(p)" "ACTIVE(a)" "HOLD(h)" "|" "FINISHED(f)" "CANCELED(q)" "BACKLOOP(l)")))

  (setq org-todo-keyword-faces
        '(("TODO" . "#ECBE7B") ("NEXT" . "#51afef") ("WAIT" . "#a7cc8c") ("WIP" . "#d291e4")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (advice-add 'org-schedule :after 'org-save-all-org-buffers)
  (advice-add 'counsel-org-tag :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
          ; Mutually exclusive tags here
          (:endgroup)
          ("@home" . ?H)
          ("@work" . ?W)
          ("@project" . ?P)
          ("@uni" . ?U)
          ("@private" . ?I)
          ("@system" . ?S)
          ("email" . ?e)
          ("phone" . ?p)
          ("orga" . ?o)
          ("code" . ?c)
          ("buy" . ?b)
          ("read" . ?r)))
  ;; Configure custom agenda views
  ;; (setq org-agenda-custom-commands
  ;;   '(("d" "Dashboard"
  ;;     ((agenda "" ((org-deadline-warning-days 7)))
  ;;       (todo "WIP" ((org-agenda-overriding-header "Current Tasks")))
  ;;       (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
  ;;       (tags-todo "+TODO=\"TODO\"+@work+LEVEL=2" ((org-agenda-overriding-header "Work")))
  ;;       (tags-todo "+TODO=\"TODO\"+@uni+LEVEL=2" ((org-agenda-overriding-header "Uni")))
  ;;       (tags-todo "+TODO=\"TODO\"+@home+LEVEL=2" ((org-agenda-overriding-header "Home")))
  ;;       (tags-todo "+TODO=\"TODO\"+@private+LEVEL=2" ((org-agenda-overriding-header "Private")))
  ;;       (tags-todo "+TODO=\"TODO\"+@system+LEVEL=2" ((org-agenda-overriding-header "System")))))

  ;;   ("n" "Next Tasks"
  ;;     ((todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))))

  ;;   ("k" "Kanban"
  ;;    ((tags-todo "+TODO=\"TODO\"+@project+CATEGORY=\"1\"" ((org-agenda-overriding-header "To Do")))
  ;;     (tags-todo "+TODO=\"WIP\"+@project+CATEGORY=\"1\"" ((org-agenda-overriding-header "Work in Progress")))
  ;;     (tags-todo "+TODO=\"DONE\"+@project+CATEGORY=\"1\"" ((org-agenda-overriding-header "Done")))))

  ;;   ;; Low-effort next actions
  ;;   ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
  ;;     ((org-agenda-overriding-header "Low Effort Tasks")
  ;;      (org-agenda-max-todos 20)
  ;;      (org-agenda-files org-agenda-files)))

  ;;   ("p" "Project Status"
  ;;     ((todo "IDEA"
  ;;            ((org-agenda-overriding-header "Ideas in Mind")
  ;;             (org-agenda-files org-agenda-files)))
  ;;      (todo "PLAN"
  ;;            ((org-agenda-overriding-header "In Planning")
  ;;             (org-agenda-todo-list-sublevels nil)
  ;;             (org-agenda-files org-agenda-files)))
  ;;      (todo "HOLD"
  ;;            ((org-agenda-overriding-header "Waiting for Parts")
  ;;             (org-agenda-files org-agenda-files)))
  ;;      (todo "ACTIVE"
  ;;            ((org-agenda-overriding-header "Active Projects")
  ;;             (org-agenda-files org-agenda-files)))
  ;;      (todo "FINISHED"
  ;;            ((org-agenda-overriding-header "Finished Projects")
  ;;             (org-agenda-files org-agenda-files)))
  ;;      (todo "CANCELED"
  ;;            ((org-agenda-overriding-header "Canceled Projects")
  ;;             (org-agenda-files org-agenda-files)))))))


  ;; Captures
  (setq org-capture-templates
    `(("t" "Tasks")
      ("tt" "Todo" entry (file "~/cloud/org/agenda/Tasks.org")
           "* TODO %? %^{Task} \t %^G\n  %u\n  %i" :empty-lines 1)
      ("tn" "Next" entry (file "~/cloud/org/agenda/Tasks.org")
           "* NEXT %?  %^{Task}  %^G\n  %u\n  %i" :empty-lines 1)
      ("tw" "Work in Progress" entry (file "~/cloud/org/agenda/Tasks.org")
           "* WIP %? %^{Task} %^G\n %u\n SCHEDULED: %t %i" :empty-lines 1)

      ("p" "Projects")
      ("pn" "Idea" entry (file "~/cloud/org/agenda/Tasks.org")
           "* IDEA %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("n" "Inbox" entry (file "~/cloud/org/agenda/Inbox.org")
           "* TODO %?\n" :empty-lines 1)

      ("a" "Appointment")
      ("ap" "Personal" entry (file "~/cloud/org/agenda/Personal.org")
       "* %? %^{Event}\n %^T %i" :empty-lines 1)
      ("aw" "Work" entry (file "~/cloud/org/agenda/Work.org")
       "* %? %^{Event}\n %^T %i" :empty-lines 1))))


(defun my-agenda-prefix ()
  (format "%s" (my-agenda-indent-string (org-current-level))))

(defun my-agenda-indent-string (level)
  (if (= level 1)
      ""
    (let ((str " ╰─"))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "──")))
      (concat str "►"))))

(defun agenda-prefix-projects ()
  (format "%s" (agenda-indent-string-projects (org-current-level))))

(defun agenda-indent-string-projects (level)
  (if (= level 1)
      "\n\n--------------------------\n\n"
    (if (= level 2)
        "~~~\n\n"
    (let ((str " ╰─"))
      (while (> level 3)
        (setq level (1- level)
              str (concat str "──")))
      (concat str "►")))))

(use-package! org-super-agenda
  :after org-agenda
  :config
  ;; (setq org-agenda-skip-scheduled-if-done t
  ;;     org-agenda-skip-deadline-if-done t
  ;;     org-agenda-include-deadlines t
  ;;     org-agenda-block-separator nil
  ;;     org-agenda-compact-blocks t
  ;;     org-agenda-start-day nil ;; i.e. today
  ;;     org-agenda-span 1
  ;;     org-agenda-start-on-weekday nil)
  (setq org-super-agenda-header-map (make-sparse-keymap)
        org-agenda-dim-blocked-tasks nil)
  ;; (setq org-super-agenda-header-map evil-org-agenda-mode-map)
  ;; agenda
  ;; (setq org-agenda-start-with-log-mode t)
  ;; (setq org-log-done 'time)
  ;; (setq org-log-into-drawer t)
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           (;;(agenda "" ((org-deadline-warning-days 7)))
            (todo "" ((org-agenda-overriding-header "Overview")
                      (org-super-agenda-groups
                        '((:name "Today"
                                :todo "WIP")
                          (:name "Next"
                                :todo "NEXT")
                          (:name "Inbox"
                                :and (:todo t
                                      :file-path "~/cloud/org/agenda/Inbox.org"))
                         (:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Work Tasks")
                      (org-agenda-prefix-format " %e %(my-agenda-prefix) ")
                      (org-tags-match-list-sublevels t)
                      (org-super-agenda-groups
                        '((:name "To Do"
                                :and (:todo t
                                      :tag "@work"))
                         ;; (:name "Next in Line"
                         ;;        :and (:todo "NEXT"
                         ;;              :children nil
                         ;;              :tag "@work"))
                         ;; (:name "Doing"
                         ;;        :and (:todo "WIP"
                         ;;              :tag "@work"))
                         ;; (:name "Done"
                         ;;        :and (:todo "DONE"
                         ;;              :tag "@work"))
                         (:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "University Tasks")
                      (org-agenda-prefix-format " %e %(my-agenda-prefix) ")
                      (org-tags-match-list-sublevels t)
                      (org-super-agenda-groups
                        '((:name "To Do"
                                :and (:todo t
                                      :tag "@uni"))
                         (:name "Next in Line"
                                :and (:todo "NEXT"
                                      :children nil
                                      :tag "@uni"))
                         (:name "Doing"
                                :and (:todo "WIP"
                                      :tag "@uni"))
                         (:name "Done"
                                :and (:todo "DONE"
                                      :tag "@uni"))
                         (:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Home Tasks")
                      (org-agenda-prefix-format " %e %(my-agenda-prefix) ")
                      (org-tags-match-list-sublevels t)
                      (org-super-agenda-groups
                        '((:name "To Do"
                                :and (:todo t
                                      :tag "@home"))
                         (:name "Next in Line"
                                :and (:todo "NEXT"
                                      :children nil
                                      :tag "@home"))
                         (:name "Doing"
                                :and (:todo "WIP"
                                      :tag "@home"))
                         (:name "Done"
                                :and (:todo "DONE"
                                      :tag "@home"))
                         (:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Personal Tasks")
                      (org-agenda-prefix-format " %e %(my-agenda-prefix) ")
                      (org-tags-match-list-sublevels t)
                      (org-super-agenda-groups
                        '((:name "To Do"
                                :and (:todo t
                                      :tag "@private"))
                         (:name "Next in Line"
                                :and (:todo "NEXT"
                                      :children nil
                                      :tag "@private"))
                         (:name "Doing"
                                :and (:todo "WIP"
                                      :tag "@private"))
                         (:name "Done"
                                :and (:todo "DONE"
                                      :tag "@private"))
                         (:discard (:anything))))))))
          ("j" "Overview Projects"
           ((todo "" ((org-agenda-overriding-header "Projects")
                      (org-agenda-files org-agenda-files)
                      (org-super-agenda-groups
                       '((:name "Ideas in Mind"
                                :todo "IDEA")
                         (:name "In Planning"
                                :todo "PLAN")
                         (:name "Waiting for Things"
                                :todo "HOLD")
                         (:name "Active Developement"
                                :todo "ACTIVE")
                         (:name "Finished"
                                :todo "FINISHED")
                         (:name "Canceled"
                                :todo "CANCELED")
                         (:discard (:anything))))))))
          ("p" "Projects"
           ((todo "" ((org-agenda-overriding-header "Project Tasks")
                      (org-agenda-prefix-format " %e %(agenda-prefix-projects) ")
                      (org-tags-match-list-sublevels t)
                      (org-super-agenda-groups
                       '((:name "Projects"
                                :tag "@project")
                         (:discard (:anything))))))))
          ("c" . "Context Kanbans")
          ("cw" "Work"
           ((todo "" ((org-agenda-overriding-header "Work Kanban")
                      (org-super-agenda-groups
                       '((:name "Awaiting"
                          :and (:todo "WAIT"
                                :tag "@work"))
                         (:name "To Do"
                          :and (:todo "TODO"
                                :children nil
                                :tag "@work"))
                         (:name "Next in Line"
                          :and (:todo "NEXT"
                                :children nil
                                :tag "@work"))
                         (:name "Doing"
                          :and (:todo "WIP"
                                :tag "@work"))
                         (:name "Done"
                          :and (:todo "DONE"
                                :tag "@work"))
                         (:discard (:anything))))))))
          ("cu" "Uni"
           ((todo "" ((org-agenda-overriding-header "Uni Kanban")
                      (org-super-agenda-groups
                       '((:name "Awaiting"
                          :and (:todo "WAIT"
                                :tag "@uni"))
                         (:name "To Do"
                          :and (:todo "TODO"
                                :children nil
                                :tag "@uni"))
                         (:name "Next in Line"
                          :and (:todo "NEXT"
                                :children nil
                                :tag "@uni"))
                         (:name "Doing"
                          :and (:todo "WIP"
                                :tag "@uni"))
                         (:name "Done"
                          :and (:todo "DONE"
                                :tag "@uni"))
                         (:discard (:anything))))))))
          ("ch" "Home"
           ((todo "" ((org-agenda-overriding-header "Home Improvement Kanban")
                      (org-super-agenda-groups
                       '((:name "Awaiting"
                          :and (:todo "WAIT"
                                :children nil
                                :tag "@home"))
                         (:name "To Do"
                          :and (:todo "TODO"
                                :children nil
                                :tag "@home"))
                         (:name "Next in Line"
                          :and (:todo "NEXT"
                                :children nil
                                :tag "@home"))
                         (:name "Doing"
                          :and (:todo "WIP"
                                :tag "@home"))
                         (:name "Done"
                          :and (:todo "DONE"
                                :tag "@home"))
                         (:discard (:anything))))))))
          ("cp" "Personal"
           ((todo "" ((org-agenda-overriding-header "Personal Kanban")
                      (org-super-agenda-groups
                       '((:name "Awaiting"
                          :and (:todo "WAIT"
                                :tag "@private"))
                         (:name "To Do"
                          :and (:todo "TODO"
                                :children nil
                                :tag "@private"))
                         (:name "Next in Line"
                          :and (:todo "NEXT"
                                :children nil
                                :tag "@private"))
                         (:name "Doing"
                          :and (:todo "WIP"
                                :tag "@private"))
                         (:name "Done"
                          :and (:todo "DONE"
                                :tag "@private"))
                         (:discard (:anything))))))))
          ("cq" "Projects"
           (
            ;; (lambda (arg) (call-interactively #'proj-id-prop-search nil))
            (todo "" ((org-agenda-overriding-header "Project Kanban")
                       (org-super-agenda-groups
                        '((:name "Some Project Name"
                           :pred (lambda (item) (s-matches?
                                   (interactive
                                    (list
                                     (completing-read "Project ID: " (org-property-values "PROJID")))) item))
                           )))))))))
  ; Milestone Todo tag for every todo with children
  ; these are not activley worked on but reached when
  ; child tasks are done
  (org-super-agenda-mode))


(defun proj-id-prop-search (id)
  "Search by WITH propery, which is made inheritable for this function"
  (interactive
   (list
    (completing-read "Project ID: " (org-property-values "PROJID"))))
  (let ((org-use-property-inheritance
         (append org-use-property-inheritance '("PROJID"))))
    ;; (org-tags-view t (format "PROJID=\"%s\"/TODO" id))
    (org-todo-list)
    ))


(use-package! org-roam
  :custom
  (org-roam-directory "~/cloud/roam")
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org"
                              "#+title: ${title}\n#+startup: latexpreview imagepreview\n")
           :unnarrowed t)))
  (org-roam-setup))


(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-remove-leading-stars t
        org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
        org-superstar-item-bullet-alist '((?* . "+")
                                          (?+ . "-")
                                          (?- . "•")))
  (efs/org-font-setup))


(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("1" "2" "3" "4")))


(use-package! org-xournalpp
  :config
  (add-hook 'org-mode-hook 'org-xournalpp-mode))

(use-package! ox-ipynb)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))


(use-package! visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))
