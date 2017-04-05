defmodule Pushups.Routine do
  alias Pushups.{User,Repo}

  def welcome(user) do
    """
    Hi, welcome to 100 pushups! 😄

    This is a six week training program where at the end you'll be able to
    do 100 pushups in a row 💪💪

    We'll do an initial fitness test first to
    find what level you are at.

    Would you like to start now? 😗
    """
    # case Repo.get_by(User, user: user) do
    #   nil ->
    #     "hi stranger"
    #     # create_user(user)
    #     # """
    #
    #   _user ->
    #     "welcome back!"
    # end
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

  def get_session_id(json) do
    json["sessionId"]
  end

  def is_date_in_the_past?(date) do
    case Date.compare(NaiveDateTime.to_date(date), Date.utc_today()) do
      :lt ->
        true
      _ ->
        false
    end
  end

end
