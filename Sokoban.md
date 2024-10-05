// MINT

``` 
 

// Constants
:A 20 w! 10 h!  // Width and height of the game area
w h * b!        // Total size of the game buffer

// Characters
64 p! 35 l! 36 x! 46 f! 42 t! 43 o!  // @#$.*+ respectively

// Game state
b /A g!         // Allocate game buffer
0 q!            // Player position
0 m!            // Move counter
;

// Read level design
:R
  w h * (
    /K " f = ~ (
      " g /i +!
    ) /E (
      f g /i +!
    )
    " p = ( /i q! )
  )
;

// Draw game state
:D
  `Moves:` m . /N
  h (
    w (
      g /j w * /i + + ? /C
    )
    10 /C  // New line
  )
;

// Move player
:M
  " g + ? l = ~ (  // If not wall
    " g + ? x = (   // If box
      " + g + ? f = (  // If next space is floor
        f g +!   // Move box
        x " + g +!
        p g +!  // Move player
        f g q +!
        q!     // Update player position
        m 1 + m!  // Increment move counter
      ) /E (
        " + g + ? t = (  // If next space is target
          f g +!   // Move box
          o " + g +!
          p g +!  // Move player
          f g q +!
          q!     // Update player position
          m 1 + m!  // Increment move counter
        )
      )
    ) /E (
      " g + ? f = (  // If floor
        p " g +!   // Move player
        f g q +!
        q!        // Update player position
        m 1 + m!  // Increment move counter
      ) /E (
        " g + ? t = (  // If target
          p " g +!    // Move player
          f g q +!
          q!         // Update player position
          m 1 + m!  // Increment move counter
        )
      )
    )
  )
;

// Check win condition
:W
  /T w!
  b ( g /i + ? x = g /i + ? o = | ( /F w! ) )
  w
;

// Game loop
:G
  R  // Read level design
  /U (
    D
    W ( `You win in` m . `moves!` /F /W )
    /K
    " 119 = ( q w - M )  // W - Up
    " 115 = ( q w + M )  // S - Down
    " 97 = ( q 1 - M )   // A - Left
    " 100 = ( q 1 + M )  // D - Right
    " 114 = ( A G )      // R - Restart
    " 113 = ( /F /W )    // Q - Quit
  )
;

// Start the game
A G

// Example level design (input this when prompted):
// ####################
// #@   *  #    *     #
// #  $  # # #  $  #  #
// # $   # # #     #  #
// #  $    # #  $  #  #
// ####################

```
