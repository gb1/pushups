defmodule Pushups.Routine do
  alias Pushups.{User,Repo}

  def welcome(user) do

    case Repo.get_by(User, user: user) do
      nil ->
        create_user(user)
        "Hi, welcome to 100 pushups"
      _user ->
        "welcome back!"
    end
  end

  def create_user(user) do
    changeset = User.changeset(
      %User{}, %{user: user, week: 1, day: 1, level: 1})

    case Repo.insert(changeset) do
      {:ok, _model} ->
        :ok
      {:error, _changeset} ->
        raise "oh no!"
      end
  end

  def initial_fitness_test do

  end

  def routine_for_day(week, day) do
    
  end

end
