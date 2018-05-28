
# proc newFormData*(): FormData
#     {.importcpp: "new FormData()", constructor.}

proc establish_terminal_on_start_function*(on_terminal_start: proc): void
  {.importcpp: "establish_terminal_on_start_function(@)".}

proc establish_terminal_on_input_function*(on_terminal_input: proc): void 
  {.importcpp: "establish_terminal_on_input_function(@)".}

proc send(msg: cstring): void
  {.importcpp: "send(@)".}

proc send*(msg: string): void =
  send(msg.cstring)

# proc send*(msg: string) =
#   echo msg
