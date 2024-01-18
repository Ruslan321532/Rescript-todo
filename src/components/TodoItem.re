%%raw(`import './styles.scss';`)

type Props = {
  todo: todo,
  onClick: unit => unit,
};

@react.component
let make = (~todo: Props.todo, ~onClick: Props.onClick) => {
  let todoClassName = if (todo.isDone) {"completed"} else {"notCompleted"};

  <div
    onClick={_ => onClick()}
    key={todo.title}
    className={todoClassName}>
    {React.string(todo.title)}
  </div>;
};
