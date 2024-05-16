;; Artist Discography
;; Contracts that models the features present in a music discography of an artist

;; Discography
;; An artist discography is a list of albums made by artist
;; A discography can be initiated by either the artist that owns it or an admin who has access to the dicography

;; Track
;; A track is made up of name, title, duration and or a feature
;; An admin or artist can track or remove tracks


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Cons, Variables and Maps ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Map that keeps track of tracks
(define-map track { artist: principal, album-id: uint, track-id: uint } { 
    title: (string-ascii 24),
    duration: uint,
    features: (optional principal)
    }
)

;; Map that keeps track of a albums
(define-map album { artist: principal, album-id: uint } 
    { 
        title: (string-ascii 24),
        tracks: (list 20 uint),
        height-published: uint 
    })

;; Map that keeps track of a discography
(define-map discography principal (list 10 uint))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Read-only functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Get track
(define-read-only (get-track (artist principal) (album-id uint) (track-id uint)) 
    (map-get? track {artist: artist, album-id: album-id, track-id: track-id})
)   

;; Get featured artist
(define-read-only (get-featured-artist (artist principal) (album-id uint) (track-id uint)) 
    (get features (map-get? track {artist: artist, album-id: album-id, track-id: track-id}))
)

;; Get album data

(define-read-only (get-album-data (artist principal) (album-id uint)) 
    (map-get? album {artist: artist, album-id: album-id})
)

;; Get height published
(define-read-only (get-height-published (artist principal) (album-id uint))  
    (get height-published (map-get? album {artist: artist, album-id: album-id}))
)

;; Get Discography
(define-read-only (get-discography (artist principal)) 
    (map-get? discography artist)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Write functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add a Track
;; @desc -> Functions that allow a user or admin add a track
;; params -> title (string-ascii 24),  duration (uint), featured-artist (optional), album-id (uint) and discography

(define-public (add-track (artist (optional principal)) (title (string-ascii 24)) (duration uint) (album-id uint) (featured-artist (optional principal))) 
    (let        
        (


            (test u0)
        )
        
            ;; Assert that artist or admin is making the update


            ;; Assert that album exists in discography


            ;; Assert that duration is less than 600 (10 mins)


            ;; Map set new track


            ;; Map-set append new track to album


        (ok u1)
    )
)

;; Add an album
;; @desc -> function that allows the artist or admin to add a new album, or start a new discography and add album

(define-public (add-album-or-create-discography-and-add-album (artist (optional principal)) (alubm-title (string-ascii 24))) 
    (let     
        (
            ;; Local vars here
        )

            ;; Check whether discography exists / is-some
                
                ;; Discography exists

                    ;; Map-set new album

                    ;; Append new album to discography

                ;; Discography doesn't exist

                    ;; Map-set new discography


            ;; Map set new album

            
            ;; Append new album to discography


         (ok u1)
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Admin functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add Admin
;; @desc: function that an existing admin can call to add an admin. 
;; @params -> Principal
(define-public (add-admin (new-admin principal)) 
    (let   

        (
            ;; Local vars go here
        )

            ;; Assert that tx-sender is an existing admin

            ;; Assert that new admin is not already listed

            ;; Append new admin to admin list
        
         (ok u1)
    )

)

;; Remove Admin
;; @desc: function that removes an existing admin 
;; @params -> Removed admin (principal)

(define-public (remove-admin (removed-admin principal)) 
    (let     
        (
            ;; Variables
        )

            ;; Asserts that tx-sender is an admin

            ;; Assert that removed admin is exists

            ;; Remove admin 

            (ok u1)
    )
)