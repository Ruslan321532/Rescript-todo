%%raw(`import './output.css';`)

open Types
open Components

let initialState: state = {
  todoList: [],
  inputValue: "",
  errorMessage: None,
}

let reducer = (state, action) =>
  switch action {
  | AddTodo => {
      inputValue: "",
      errorMessage: state.inputValue->Js.String.empty->Option.from->Option.map(_ => "Input empty"),
      todoList: state.inputValue
      ->Option.flatMap(_ =>
        state.todoList->Js.Array2.concat([
          {
            title: state.inputValue,
            isDone: false,
          },
        ])
      )
      ->Option.getWithDefault(~default=state.todoList),
    }
  | ClearTodos => {...state, todoList: []}
  | InputChanged(newValue) => {...state, inputValue: newValue, errorMessage: None}
  | MarkDone(index) => {
      ...state,
      todoList: state.todoList->Belt.Array.modify(index, todo => {...todo, isDone: !todo.isDone}),
    }
  }

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let handleChangeInput = e => {
    let newValue = ReactEvent.Form.target(e)["value"]
    newValue->InputChanged->dispatch
  }

  <div className="App">
    <h1> {"TodoList"->React.string} </h1>
    <input
      value={state.inputValue} type_="text" onChange={handleChangeInput} className="inputStyle"
    />
    <button onClick={_ => dispatch(AddTodo)} className="buttonStyle">
      {"ADD"->React.string}
    </button>
    <button onClick={_ => dispatch(ClearTodos)} className="buttonStyle">
      {"CLEAR LIST"->React.string}
    </button>
    {state.errorMessage->Option.map(message =>
      <div className="errorMessage"> {message->React.string} </div>
    )}
    <TodoList todoList={state.todoList} onTodoClick={i => dispatch(MarkDone(i))} />
  </div>
}
