import turn_based_game
import negamax
import webterminal
import strutils

import knights

let instructions = [
  "Each player has one chess knight in the corners of a 5x5 chessboard. Just",
  "like in regular chess, a Knight can jump in an \"L\" pattern. Each turn,",
  "move your knight to any tile that hasn't been occupied by a knight before.",
  "The first player that cannot move loses.",
  " ",
  "Please choose how many moves ahead your opponent can look (1 to 10):"
]

type
  game_states = enum
    init, get_level, waiting_on_user, playing_ai, game_over, done

var
  game = Knights()
  current_state: game_states
  our_score: int = 0
  ai_score: int = 0


proc handle_end(game: Knights) =
  webterminal.send(" ")
  webterminal.send("-----------------")
  webterminal.send("GAME OVER")
  webterminal.send(game.status())
  webterminal.send(" ")
  if game.winner_player_number == 1:
    our_score += 1
    webterminal.send("YOU WON! The AI is out of moves.")
  else:
    ai_score += 1
    webterminal.send("The AI won. You ran out of moves but the AI has a move remaining.")
  #webterminal.send("\nRefresh the browser page to play again.")
  current_state = game_over
  webterminal.send("\n")
  webterminal.send("-------------------------------------------\n")
  webterminal.send("Your score: "& $our_score)
  webterminal.send("AI score: "& $ai_score)
  webterminal.send("-------------------------------------------\n")
  webterminal.send("Do you want to play again? (y/n)\n")



proc show_turn_start(game: Knights) =
  var moves_possible: seq[string]
  game.set_possible_moves(moves_possible)
  webterminal.send(" ")
  webterminal.send("-----------------")
  if game.current_player_number == 1:
    webterminal.send("Your turn (White Knight)")
  else:
    webterminal.send("AI's turn (Black Knight)")
  webterminal.send(game.status())
  if game.current_player_number == 1:
    let move_display = moves_possible.join(", ")
    webterminal.send("Possible moves: " & move_display)
    webterminal.send("Send move:")
  else:
    webterminal.send("Thinking...")

proc on_load() =
  current_state = get_level
  webterminal.send("Game of Knights")
  webterminal.send(" ")
  for line in instructions:
    webterminal.send(line)

webterminal.establish_terminal_on_start_function(on_load)

proc on_input(cmsg: cstring) =
  var moves_possible: seq[string]
  var move: string
  let msg_str = $cmsg
  let msg = msg_str.toUpperAscii()
  case current_state:
  of game_over:
    if msg == "Y":
      ### if yes
      game = Knights()
      on_load()
    elif msg == "N":
      ####if no
      current_state = done
    else:
      webterminal.send("\"" & msg & "\" is not a recognized move. Try again.")
  of waiting_on_user:
    game.set_possible_moves(moves_possible)
    if msg in moves_possible:
      webterminal.send(">>" & game.make_move(msg))
      game.determine_winner()
      if game.is_over():
        handle_end(game)
        current_state = game_over
      else:
        current_state = playing_ai
        game.current_player_number = game.next_player_number()
        show_turn_start(game)
        move = game.current_player.get_move(game)
        webterminal.send(">>" & game.make_move(move))
        game.determine_winner()
        if game.is_over():
          handle_end(game)
          current_state = game_over
        else:
          game.current_player_number = game.next_player_number()
          show_turn_start(game)
          current_state = waiting_on_user
    else:
      webterminal.send("\"" & msg & "\" is not a recognized move. Try again.")
  of get_level:
    try:
      let lvl = msg.parseInt()
      if lvl < 1:
        webterminal.send("Too low. Try again.")
      elif lvl > 10:
        webterminal.send("Too high. Try again.")
      else:
        game.setup(@[
          Player(name: "White Knight"),
          NegamaxPlayer(name: "Black Knight", depth: lvl)
        ])
        show_turn_start(game)
        current_state = waiting_on_user
    except:
      webterminal.send("Don't recognize \"$1\" as a number.".format(msg))
  else:
    webterminal.send("Internal error, reached an impossible state.")

webterminal.establish_terminal_on_input_function(on_input)


# method play*(self: Game) : seq[string] {.base discardable.} =
#   result = @[]
#   var move: string = ""
#   while not self.is_over():
#     self.current_player.display("-----------------")
#     self.current_player.display("$1's Turn".format(self.current_player.name))
#     move = self.current_player.get_move(self)
#     if move.isNil:
#       break
#     result.add(move)
#     self.current_player.display("")
#     self.current_player.display(TAB & self.make_move(move))
#     self.determine_winner()
#     if self.is_over():
#       self.current_player.display("")
#       if self.winner_player_number == STALEMATE:
#         self.current_player.display("STALEMATE.")
#       else:
#         self.current_player.display("WINNER IS $#".format([self.winning_player.name]))
#       break
#     self.current_player_number = self.next_player_number()
