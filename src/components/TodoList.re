type Props = {
  todoList: array<todo>,
  onTodoClick: int => unit,
};

@react.component
let make = (~todoList: Props.todoList, ~onTodoClick: Props.onTodoClick) => {
  <div>
    {todoList
    ->Belt.Array.mapWithIndex((i, todo) =>
      <TodoItem key={todo.title} todo=todo onClick={_ => onTodoClick(i)} />
    )
    ->React.array}
  </div>;
};
