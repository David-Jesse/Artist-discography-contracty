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

;; Admin list of principals
(define-data-var admins (list 10 principal) (list tx-sender))

;; Map that keeps track of tracks
(define-map track { artist: principal, album-id: uint, track-id: uint} { 
    title: (string-ascii 24),
    duration: uint,
    features: (optional principal)
    }
)

;; Map that keeps track of an album
(define-map album { artist: principal, album-id: uint}
    { 
        title: (string-ascii 24),
        tracks: (list 20 uint),
        height-published: uint 
    }
)

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
;; params -> title (string-ascii 24),  duration (uint), featured-artist (optional), album-id (uint)

(define-public (add-track (artist principal) (title (string-ascii 24)) (duration uint) (album-id uint) (featured-artist (optional principal))) 
    (let  

        (
            (current-discography (unwrap! (map-get? discography artist) (err u0)))
            (current-album (unwrap! (index-of? current-discography album-id)) (err u3))
            (current-album-data (unwrap! (map-get? album {artist: artist, album-id: album-id}) (err u4)))
            (current-album-tracks (get tracks current-album-data))
            (current-album-track-id (len current-album-tracks))
            (next-album-track-id (+ u1 current-album-track-id))
        )
        
        
            ;; Assert that artist or admin is making the update
            (asserts! (or (is-eq tx-sender artist) (is-some (index-of? (var-get admins) tx-sender))) (err u1))

            ;; Assert that duration is less than 600 (10 mins)
            (asserts! (< duration u600) (err u3))

            ;; Map set new track
            (map-set track {artist: artist, album-id: album-id, track-id: next-album-track-id} 
                {
                    title: title,
                    duration: duration,
                    features: featured-artist
                }
            )

            ;; Map-set append new track to album
            (ok (map-set album {artist: artist, album-id: album-id} 
                (merge 
                    current-album-data 
                    {tracks: (unwrap! (as-max-len? (append current-album-track next-album-track-id) u10) (err u4))}
                )
            ))
        
    )
)

;; Add an album
;; @desc -> function that allows the artist or admin to add a new album, or start a new discography and add album

(define-public (add-album-or-create-discography-and-add-album (artist principal) (album-title (string-ascii 24))) 
    (let     
        (
            (current-discography (default-to list (map-get? discography artist)))
            (current-album-id (len current-discography))
            (next-album-id (+ u1 current-album-id))
        )

            ;; Check whether discography exists / is-some
            (ok (if (is-eq current-album-id u0)

                ;; empty discography
                (begin      
                    (map-set discography artist (list current-album-id))
                    (map-set album {artist: artist, album-title: current-album-id} 
                        {
                            title: title,
                            track: (list ),
                            height-published: block-height
                        }
                    )
                )


                 ;; Discography exists
                (begin       
                    (map-set discography artist (unwrap! (as-max-len? (append current-discography next-album-id) u10) (err u4)))
                    (map-set album {artist: artist, album-title: next-album-id} 
                        {
                            title: title,
                            track: (list ),
                            height-published: block-height
                        }
                    )
                )
            ))
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