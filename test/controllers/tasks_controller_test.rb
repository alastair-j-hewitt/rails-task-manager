require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = Task.create!(title: "Buy milk", details: "Semi-skimmed")
  end

  test "index lists tasks" do
    get tasks_url
    assert_response :success
    assert_includes response.body, "Buy milk"
  end

  test "show renders a single task" do
    get task_url(@task)
    assert_response :success
    assert_includes response.body, "Semi-skimmed"
  end

  test "create saves a valid task" do
    assert_difference("Task.count", 1) do
      post tasks_url, params: { task: { title: "Walk the dog" } }
    end
    assert_redirected_to task_url(Task.last)
  end

  test "create rejects a task without a title" do
    assert_no_difference("Task.count") do
      post tasks_url, params: { task: { title: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "update marks a task completed" do
    patch task_url(@task), params: { task: { completed: "1" } }
    assert @task.reload.completed
  end

  test "destroy deletes the task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end
  end
end
