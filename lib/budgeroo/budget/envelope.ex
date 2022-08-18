defmodule Budgeroo.Budget.Envelope do
  use Ecto.Schema
  import Ecto.Changeset

  schema "envelopes" do
    field :amount, :integer
    field :goal, :integer
    field :group, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(envelope, attrs) do
    envelope
    |> cast(attrs, [:name, :group, :amount, :goal])
    |> validate_required([:name, :group, :amount, :goal])
  end
end
