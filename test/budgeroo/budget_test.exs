defmodule Budgeroo.BudgetTest do
  use Budgeroo.DataCase

  alias Budgeroo.Budget

  describe "envelopes" do
    alias Budgeroo.Budget.Envelope

    import Budgeroo.BudgetFixtures

    @invalid_attrs %{amount: nil, goal: nil, group: nil, name: nil}

    test "list_envelopes/0 returns all envelopes" do
      envelope = envelope_fixture()
      assert Budget.list_envelopes() == [envelope]
    end

    test "get_envelope!/1 returns the envelope with given id" do
      envelope = envelope_fixture()
      assert Budget.get_envelope!(envelope.id) == envelope
    end

    test "create_envelope/1 with valid data creates a envelope" do
      valid_attrs = %{amount: 42, goal: 42, group: "some group", name: "some name"}

      assert {:ok, %Envelope{} = envelope} = Budget.create_envelope(valid_attrs)
      assert envelope.amount == 42
      assert envelope.goal == 42
      assert envelope.group == "some group"
      assert envelope.name == "some name"
    end

    test "create_envelope/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Budget.create_envelope(@invalid_attrs)
    end

    test "update_envelope/2 with valid data updates the envelope" do
      envelope = envelope_fixture()
      update_attrs = %{amount: 43, goal: 43, group: "some updated group", name: "some updated name"}

      assert {:ok, %Envelope{} = envelope} = Budget.update_envelope(envelope, update_attrs)
      assert envelope.amount == 43
      assert envelope.goal == 43
      assert envelope.group == "some updated group"
      assert envelope.name == "some updated name"
    end

    test "update_envelope/2 with invalid data returns error changeset" do
      envelope = envelope_fixture()
      assert {:error, %Ecto.Changeset{}} = Budget.update_envelope(envelope, @invalid_attrs)
      assert envelope == Budget.get_envelope!(envelope.id)
    end

    test "delete_envelope/1 deletes the envelope" do
      envelope = envelope_fixture()
      assert {:ok, %Envelope{}} = Budget.delete_envelope(envelope)
      assert_raise Ecto.NoResultsError, fn -> Budget.get_envelope!(envelope.id) end
    end

    test "change_envelope/1 returns a envelope changeset" do
      envelope = envelope_fixture()
      assert %Ecto.Changeset{} = Budget.change_envelope(envelope)
    end
  end
end
