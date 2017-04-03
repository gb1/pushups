defmodule PushupsTest do
  use ExUnit.Case
  alias Pushups.{User,Repo,Routine}
  # doctest Pushups

  setup_all do
    on_exit fn ->
      users = Repo.all(User)
      Enum.each(users, fn(user) ->
        Repo.delete(user)
      end)
    end
  end

  # @tag :skip
  test "test inserting a user into the db" do

      changeset = User.changeset(
        %User{}, %{user: "123", week: 1, day: 1, level: 2})

      case Repo.insert(changeset) do
        {:ok, _model}        -> assert true = true
        {:error, _changeset} -> assert false = true
      end
  end

  # @tag :skip
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
      {:ok, _model}        -> assert true == false
      {:error, _changeset} -> assert true == true
    end

  end


  # @tag :skip
  test "welcome message for a new user & creation of new user" do
    seshId = "new_user"
    assert Routine.welcome(seshId) == "Hi, welcome to 100 pushups"

    case Repo.get_by(User, user: seshId) do
      nil ->
        assert true == false
      _user ->
        assert true == true
    end

  end

  # @tag :skip
  test "welcome message for an existing user" do

    seshId = "existing_user"

    changeset = User.changeset(
      %User{}, %{user: seshId, week: 1, day: 1, level: 1})

    case Repo.insert(changeset) do
      {:ok, _model}        ->
        assert Routine.welcome(seshId) == "welcome back!"
      {:error, _changeset} -> assert true == true
    end
  end


  @tag :skip
  test "" do

    # msg = %{"id" => "e10c77c8-3f20-485f-8f3d-d879f5f07cbf", "lang" => "en",
    #   "result" => %{"action" => "input.welcome", "actionIncomplete" => false,
    #     "contexts" => [%{"lifespan" => 2, "name" => "defaultwelcomeintent-followup",
    #        "parameters" => %{}}],
    #     "fulfillment" => %{"messages" => [%{"speech" => "Hi! Are you ready to do some pushups? :-)",
    #          "type" => 0}],
    #       "speech" => "Hi! Are you ready to do some pushups? :-)"},
    #     "metadata" => %{"intentId" => "3bb1908c-c8d9-43d0-a51f-37ceb74dcca8",
    #       "intentName" => "Default Welcome Intent",
    #       "webhookForSlotFillingUsed" => "false", "webhookUsed" => "true"},
    #     "parameters" => %{}, "resolvedQuery" => "Hi", "score" => 1.0,
    #     "source" => "agent", "speech" => ""},
    #   "sessionId" => "d8e0a474-43fc-4b9e-961d-41fd34c87a44",
    #   "status" => %{"code" => 200, "errorType" => "success"},
    #   "timestamp" => "2017-04-01T19:50:32.356Z"}

  end

end
