type todo = {
  title: string,
  isDone: bool,
}

type state = {todoList: array<todo>, inputValue: string}

type actions =
  | AddTodo
  | ClearTodos
  | InputChanged(string)
  | MarkDone(int)
