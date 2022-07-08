module TodosController
  
  using Todos
  using Genie.Renderers, Genie.Renderers.Html
  using Genie.Router
  using SearchLight
  using SearchLight.Validation
  using Genie.Renderers.Json
  using Genie.Requests

  function index()
    html(:todos, :index, todos = all(Todo))
  end

  function create()
    todo = Todo(todo = params(:todo))		 # 1
    validator = validate(todo)
    if haserrors(validator)
      return redirect("/?error=$(errors_to_string(validator))")
    end   
  
    if save(todo)					   # 2
      redirect("/?success=Todo created") # 3
    else
      redirect("/?error=Could not save todo&todo=$(params(:todo))")
    end
  end


  function toggle()
    todo = findone(Todo, id = params(:id))
    if todo === nothing
      return Router.error(NOT_FOUND, "Todo item with id $(params(:id))", MIME"text/html")
    end

    todo.completed = ! todo.completed

    save(todo) && json(:todo => todo)
  end

  function update()
    todo = findone(Todo, id = params(:id))
    if todo === nothing
      return Router.error(NOT_FOUND, "Todo item with id $(params(:id))", MIME"text/html")
    end
  
    todo.todo = replace(jsonpayload("todo"), "<br>"=>"")
    save(todo) && json(todo)
  end

  function delete()
    todo = findone(Todo, id = params(:id))
    if todo === nothing
      return Router.error(NOT_FOUND, "Todo item with id $(params(:id))", MIME"text/html")
    end
  
    SearchLight.delete(todo)
    json(Dict(:id => (:value => params(:id))))
  end
  
  
end
