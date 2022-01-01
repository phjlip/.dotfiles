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
(setq doom-font (font-spec :family "Iosevka nerd font" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

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


(map! :map (outline-mode-map global-map evil-org-mode-map)
      :niver "M-l" (lambda () (interactive) (evil-escape) (right-char))
      :niver "M-h" 'evil-escape
      :niver "M-j" (lambda () (interactive) (evil-escape) (evil-next-line 1))
      :niver "M-k" (lambda () (interactive) (evil-escape) (evil-previous-line 1))
      :niver "C-s" 'evil-write
      :nv    "C-j" 'evil-forward-paragraph
      :nv    "C-k" 'evil-backward-paragraph)

(map! :map (evil-org-mode-map)
      :nv       "j"     'evil-next-visual-line
      :nv       "k"     'evil-previous-visual-line)

(map! :map (evil-org-mode-map org-agenda-mode-map)
      "M-L"    'org-agenda-date-later-hours
      "M-H"    'org-agenda-date-earlier-hours
      "M-l"    'org-agenda-date-later-minutes
      "M-h"    'org-agenda-date-earlier-minutes)

(map! :leader :desc "Calendar" :g "o c" 'mycal)

(defun mycal ()
  (interactive)
  (cfw:open-calendar-buffer
   :view 'week
   :contents-sources
   (list
    (cfw:org-create-file-source "Personal" "~/Dropbox/org/agenda/Personal.org" "Blue")  ; org-agenda source
    (cfw:org-create-file-source "Work" "~/Dropbox/org/agenda/Personal.org" "Orange")  ; org-agenda source
    (cfw:org-create-file-source "Anika" "~/Dropbox/org/agenda/Anika.org" "Gray"))))  ; org-agenda source

(use-package! calfw
  :config
  (setq calendar-week-start-day 1))

(use-package! auth-source
  :init
  (setq auth-source-debug t
        auth-source-do-cache t))


(use-package! auth-source-pass
  :init
  (setq auth-sources nil)
  (auth-source-pass-enable))


(use-package! org-caldav
  :init
  (setq org-caldav-delete-org-entries 'always
        org-caldav-delete-calendar-entries 'always
        org-caldav-sync-changes-to-org 'all
        org-caldav-show-sync-results nil
        org-caldav-backup-file "~/Dropbox/org/agenda/org-caldav-backup.org"
        org-icalendar-timezone "Europe/Berlin"
        org-caldav-save-directory "~/Dropbox/org/agenda/"
        org-caldav-calendars
               '((:url "https://nextcloud05.webo.cloud/remote.php/dav/calendars/philipgottschall@gmail.com"
                  :calendar-id "personal-1"
                  :files nil
                  :inbox "~/Dropbox/org/agenda/Personal.org")
                 (:url "https://nextcloud05.webo.cloud/remote.php/dav/calendars/philipgottschall@gmail.com"
                  :calendar-id "work"
                  :files nil
                  :inbox "~/Dropbox/org/agenda/Work.org")))
                 ;; (:url "https://moseskonto.tu-berlin.de/moses/cal/export/44d6e415b887f4b58c76f0f01e3b54a9"
                 ;;  :calendar-id nil
                 ;;  :files nil
                 ;;  :inbox "~/Dropbox/org/agenda/Uni.org")))

  (add-hook 'org-agenda-mode-hook (lambda () (org-caldav-sync)))
  (add-hook 'org-capture-after-finalize-hook (lambda () (org-caldav-sync))))


(use-package! plstore
  :config
  (setq plstore-cache-passphrase-for-symmetric-encryption t))


(use-package! mu4e
  :if (file-exists-p "~/.config/mu4e/mbsyncrc")
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a"
        mu4e-change-filenames-when-moving t
        mu4e-compose-format-flowed t
        message-kill-buffer-on-exit t
        mu4e-update-interval  (* 10 60)
        message-send-mail-function 'smtpmail-send-it
        mu4e-sent-folder "/pgottsch-up/Sent"
        mu4e-drafts-folder "/pgottsch-up/Drafts"
        mu4e-trash-folder "/pgottsch-up/Trash")


  (setq mu4e-contexts
        (list
          ;; DEPRECATED Uni Potsdam
          (make-mu4e-context
          :name "UP"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/pgottsch-up" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "pgottsch@uni-potsdam.de")
                  (user-full-name    . "Philip Gottschall")
                  (smtpmail-smtp-user  . "pgottsch@uni-potsdam.de")
                  (smtpmail-smtp-server  . "smtp.uni-potsdam.de")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type  . ssl)
                  ;; (smtpmail-auth-credentials . (expand-file-name "~/.config/mu4e/authinfo.gpg"))
                  (mu4e-maildir-shortcuts . (("/pgottsch-up/Inbox"      . ?i)
                                              ("/pgottsch-up/Sent Mail" . ?s)
                                              ("/pgottsch-up/Drafts"     . ?d)
                                              ("/pgottsch-up/Trash"     . ?t)))
                  (mu4e-sent-folder . "/pgottsch-up/Sent")
                  (mu4e-drafts-folder . "/pgottsch-up/Drafts")
                  (mu4e-refile-folder . "/pgottsch-up/Archive")
                  (mu4e-trash-folder . "/pgottsch-up/Trash")))

          ;; Personal
          (make-mu4e-context
          :name "Personal"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/philipgottschall-gmail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "philipgottschall@gmail.com")
                  (user-full-name    . "Philip Gottschall")
                  (smtpmail-smtp-user  . "philipgottschall@gmail.com")
                  (smtpmail-smtp-server  . "smtp.gmail.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type  . ssl)
                  ;; (smtpmail-auth-credentials . (expand-file-name "~/.config/mu4e/authinfo.gpg"))
                  (mu4e-maildir-shortcuts . (("/philipgottschall-gmail/Inbox"      . ?i)
                                              ("/philipgottschall-gmail/Sent Mail" . ?s)
                                              ("/philipgottschall-gmail/Drafts"     . ?d)
                                              ("/philipgottschall-gmail/Trash"     . ?t)))
                  (mu4e-sent-folder  . "/philipgottschall-gmail/Sent")
                  (mu4e-drafts-folder  . "/philipgottschall-gmail/Drafts")
                  (mu4e-refile-folder  . "/philipgottschall-gmail/All Mail")
                  (mu4e-trash-folder  . "/philipgottschall-gmail/Trash"))))))


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
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
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

  ;; agenda
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Dropbox/org/agenda/Tasks.org"
          "~/Dropbox/org/agenda/Personal.org"
          "~/Dropbox/org/agenda/Work.org"
          "~/Dropbox/org/agenda/Uni.org"
          "~/Dropbox/org/agenda/Projects.org"
          "~/Dropbox/org/agenda/Birthday.org"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WIP(w)" "|" "DONE(d!)" "CANCEL(q)")
          (sequence "IDEA(i)" "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "HOLD(h)" "|" "COMPLETED(c)" "CANCELED(k@)" "BACKLOOP(l)")))

  (setq org-todo-keyword-faces
        '(("TODO" . "#ECBE7B") ("NEXT" . "#51afef")))

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
  (setq org-agenda-custom-commands
    '(("d" "Dashboard"
      ((agenda "" ((org-deadline-warning-days 7)))
        (todo "WIP" ((org-agenda-overriding-header "Current Tasks")))
        (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
        (tags-todo "+TODO=\"TODO\"+@work+LEVEL=2" ((org-agenda-overriding-header "Work")))
        (tags-todo "+TODO=\"TODO\"+@uni+LEVEL=2" ((org-agenda-overriding-header "Uni")))
        (tags-todo "+TODO=\"TODO\"+@home+LEVEL=2" ((org-agenda-overriding-header "Home")))
        (tags-todo "+TODO=\"TODO\"+@private+LEVEL=2" ((org-agenda-overriding-header "Private")))
        (tags-todo "+TODO=\"TODO\"+@system+LEVEL=2" ((org-agenda-overriding-header "System")))))

    ("n" "Next Tasks"
      ((todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))))

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
      ((org-agenda-overriding-header "Low Effort Tasks")
       (org-agenda-max-todos 20)
       (org-agenda-files org-agenda-files)))

    ("p" "Project Status"
      ((todo "IDEA"
             ((org-agenda-overriding-header "Ideas in Mind")
              (org-agenda-files org-agenda-files)))
       (todo "REVIEW"
             ((org-agenda-overriding-header "In Review")
              (org-agenda-files org-agenda-files)))
       (todo "PLAN"
             ((org-agenda-overriding-header "In Planning")
              (org-agenda-todo-list-sublevels nil)
              (org-agenda-files org-agenda-files)))
       (todo "BACKLOG"
             ((org-agenda-overriding-header "Project Backlog")
              (org-agenda-todo-list-sublevels nil)
              (org-agenda-files org-agenda-files)))
       (todo "READY"
             ((org-agenda-overriding-header "Ready for Work")
              (org-agenda-files org-agenda-files)))
       (todo "ACTIVE"
             ((org-agenda-overriding-header "Active Projects")
              (org-agenda-files org-agenda-files)))
       (todo "COMPLETED"
             ((org-agenda-overriding-header "Completed Projects")
              (org-agenda-files org-agenda-files)))
       (todo "CANCELED"
             ((org-agenda-overriding-header "Canceled Projects")
              (org-agenda-files org-agenda-files)))))))

  ;; Captures
  (setq org-capture-templates
    `(("t" "Tasks")
      ("tt" "Todo" entry (file+olp "~/Dropbox/org/agenda/Tasks.org" "Open")
           "* TODO %? %^{Task} \t %^G\n  %u\n  %i" :empty-lines 1)
      ("tn" "Next" entry (file+olp "~/Dropbox/org/agenda/Tasks.org" "Open")
           "* NEXT %?  %^{Task}  %^G\n  %u\n  %i" :empty-lines 1)
      ("tw" "Work in Progress" entry (file+olp "~/Dropbox/org/agenda/Tasks.org" "Open")
           "* WIP %? %^{Task} %^G\n %u\n SCHEDULED: %t %i" :empty-lines 1)

      ("p" "Projects")
      ("pn" "Idea" entry (file+olp "~/Dropbox/org/agenda/Tasks.org" "Open")
           "* IDEA %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("a" "Appointment")
      ("ap" "Personal" entry (file "~/Dropbox/org/agenda/Personal.org")
       "* %? %^{Event}\n %^T %i" :empty-lines 1)
      ("aw" "Work" entry (file "~/Dropbox/org/agenda/Work.org")
       "* %? %^{Event}\n %^T %i" :empty-lines 1))))


;; (use-package! org-roam
;;   :config
;;   (setq org-roam-index-file "~/Dropbox/org/roam/brain.org"
;;         org-roam-tag-sources '(prop all-directories))
;;   (setq org-roam-capture-templates
;;         '(("f" "New File" plain (function org-roam--capture-get-point)
;;                :file-name "%(read-directory-name \"path: \" \"~/Dropbox/org/roam/\")/${slug}"
;;                :head "#+title: ${title}\n#+created: %(format-time-string \"[%Y-%m-%d]\")\n#+roam_key: ${key}\n#+roam_tags: ${tags}\n\n%?"
;;                :unnarrowed t)
;;           ("n" "Note" plain (function org-roam--capture-get-point)
;;                :file-name "%(read-directory-name \"path: \" \"~/Dropbox/org/roam/\")/${slug}"
;;                :head "#+title: ${title}\n#+created: %(format-time-string \"[%Y-%m-%d]\")\n\n%?"
;;                :unnarrowed t))))

(use-package! org-roam
  :custom
  (org-roam-directory "~/cloud/roam")
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org"
                           "#+title: ${title}\n")
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


(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))


(use-package! visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))
