defmodule Pushups.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :user, :string
    field :week, :integer
    field :day, :integer
    field :level, :integer
    timestamps()
  end

  @required_fields ~w(user week day level)
  @optional_fields ~w()

  def changeset(user, params \\ :empty) do
    user
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:user)
  end


end
