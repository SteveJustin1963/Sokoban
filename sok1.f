\ Define the game map size
10 constant WIDTH
10 constant HEIGHT

\ Allocate memory for the game map
create map WIDTH HEIGHT * allot

\ Define constants for game characters
char # constant WALL
char @ constant PLAYER
char $ constant BOX
char . constant GOAL
char ' ' constant EMPTY
char + constant BOX_ON_GOAL
char * constant PLAYER_ON_GOAL

\ Define variables for the player's position
variable player-x
variable player-y

\ Initialize the game map
: init-map ( -- )
    s" ##########" map 0 WIDTH * + swap move
    s" #@ $ .   #" map 1 WIDTH * + swap move
    s" ##########" map 2 WIDTH * + swap move
;

\ Get character at map position
: map-at ( x y -- c )
    WIDTH * + map + c@
;

\ Set character at map position
: map-set ( c x y -- )
    WIDTH * + map + c!
;

\ Initialize the game state
: init-game ( -- )
    1 player-x !
    1 player-y !
    init-map
;

\ Display the game screen
: display ( -- )
    HEIGHT 0 do
        WIDTH 0 do
            j i map-at emit
        loop
        cr
    loop
;

\ Check if the move is valid
: valid-move? ( new-x new-y -- flag )
    2dup map-at WALL = if drop drop false exit then
    2dup map-at BOX = if
        2dup player-x @ player-y @ - player-x @ player-y @ - + 
        2dup map-at WALL = if drop drop false exit then
        map-at BOX = if drop drop false exit then
    then
    true
;

\ Move player and update map
: move-player ( new-x new-y -- )
    2dup valid-move? if
        player-x @ player-y @ map-at EMPTY swap player-x @ player-y @ map-set
        2dup player-x ! player-y !
        player-x @ player-y @ map-set PLAYER
    then
;

\ Handle input and update the player's position
: handle-input ( c -- )
    case
        char w of  player-x @ player-y @ 1 - move-player  endof
        char a of  player-x @ 1 - player-y @ move-player  endof
        char s of  player-x @ player-y @ 1 + move-player  endof
        char d of  player-x @ 1 + player-y @ move-player  endof
    endcase
;

\ Check for winning condition
: check-win ( -- flag )
    false
    HEIGHT 0 do
        WIDTH 0 do
            j i map-at GOAL = if
                j i map-at BOX <> if drop drop true exit then
            then
        loop
    loop
;

\ Main game loop
: main-loop ( -- )
    begin
        display
        key handle-input
        check-win if
            ." You win!" cr
            bye
        then
    again
;

\ Start the game
: start ( -- )
    init-game
    main-loop
;
