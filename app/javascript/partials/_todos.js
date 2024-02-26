document.addEventListener('DOMContentLoaded', function() {

  function addTodo() {
    // Get the new to-do input value
    var newTodoValue = document.getElementById('newTodoInput').value.trim();

    if (newTodoValue !== '') {
      // Create a new to-do item
      var newTodo = document.createElement('a');
      newTodo.classList.add('dropdown-item', 'todo-item');
      newTodo.innerHTML = '<input type="checkbox">' + newTodoValue;
      newTodo.addEventListener('click', toggleTodo);

      // Append the new to-do item to the dropdown
      var dropdownMenu = document.querySelector('.dropdown-menu');
      dropdownMenu.insertBefore(newTodo, dropdownMenu.lastElementChild);

      // Clear the input field
      document.getElementById('newTodoInput').value = '';
    }
  }

  function toggleTodo(event) {
    var todoItem = event.currentTarget;

    // Toggle the 'checked' class
    todoItem.classList.toggle('checked');
  }

});
