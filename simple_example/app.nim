import webterminal

# a simple example that simply repeats anything the user types

proc on_terminal_start() =
  send("3\n2\n1\n")
  send("The repeating app has started.")

establish_terminal_on_start_function(on_terminal_start);

proc on_terminal_input(msg: string) =
  send("You just said \"" & msg & "\".")

establish_terminal_on_input_function(on_terminal_input);
