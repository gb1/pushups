defmodule PushupsTest do
  use ExUnit.Case
  alias Pushups.{User,Repo}
  # doctest Pushups

  test "test inserting a user into the db" do

      # changeset = User.changeset(
      #   %User{}, %{user: "123", week: 1, day: 1, level: 2})
      #
      # case Repo.insert(changeset) do
      #   {:ok, _model}        -> assert true = true
      #   {:error, _changeset} -> assert false = true
      # end

      users = Repo.all(User)
      Enum.each(users, fn(user) ->
        Repo.delete(user)
      end)

      # user = Repo.get!(User, "2")
      # Repo.delete(user)

  end

end
