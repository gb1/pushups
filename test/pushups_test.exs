defmodule PushupsTest do
  use ExUnit.Case
  alias Pushups.{User,Repo}
  # doctest Pushups

  setup_all do
    on_exit fn ->
      users = Repo.all(User)
      Enum.each(users, fn(user) ->
        Repo.delete(user)
      end)
    end
  end

  test "test inserting a user into the db" do

      changeset = User.changeset(
        %User{}, %{user: "123", week: 1, day: 1, level: 2})

      case Repo.insert(changeset) do
        {:ok, _model}        -> assert true = true
        {:error, _changeset} -> assert false = true
      end
  end

  test "no duplicate users allowed in the db" do
    changeset = User.changeset(
      %User{}, %{user: "dupe", week: 1, day: 1, level: 2})

    case Repo.insert(changeset) do
      {:ok, _model}        -> assert true = true
      {:error, _changeset} -> assert false = true
    end

    changeset = User.changeset(
      %User{}, %{user: "dupe", week: 1, day: 1, level: 2})

    case Repo.insert(changeset) do
      {:ok, _model}        -> assert true = false
      {:error, _changeset} -> assert true = true
    end

  end


end
