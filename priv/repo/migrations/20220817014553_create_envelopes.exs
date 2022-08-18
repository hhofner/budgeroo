defmodule Budgeroo.Repo.Migrations.CreateEnvelopes do
  use Ecto.Migration

  def change do
    create table(:envelopes) do
      add :name, :string
      add :group, :string
      add :amount, :integer
      add :goal, :integer

      timestamps()
    end
  end
end
