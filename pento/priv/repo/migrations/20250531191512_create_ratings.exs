defmodule Pento.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add(:stars, :integer)
      add(:user_id, references(:users, on_delete: :nothing))
      add(:product_id, references(:products, on_delete: :nothing))

      timestamps(type: :utc_datetime)
    end

    create(index(:ratings, [:user_id]))
    create(index(:ratings, [:product_id]))
    # Add the following unique index
    create(
      unique_index(
        :ratings,
        [:user_id, :product_id],
        name: :index_ratings_on_user_product
      )
    )
  end
end
