defmodule Pento.SurveyTest do
  use Pento.DataCase
  alias Pento.Survey


  describe "demographics" do
    alias Pento.Survey.Demographic

    import Pento.SurveyFixtures

    @invalid_attrs %{gender: nil, year_of_birth: nil, user_id: nil}

    test "list_demographics/0 returns all demographics" do
      demographic = demographic_fixture()
      assert Survey.list_demographics() == [demographic]
    end

    test "get_demographic!/1 returns the demographic with given id" do
      demographic = demographic_fixture()
      assert Survey.get_demographic!(demographic.id) == demographic
    end
    import Pento.{SurveyFixtures, AccountsFixtures, CatalogFixtures}

    test "create_demographic/1 with valid data creates a demographic" do
      valid_attrs =
        %{gender: "female", year_of_birth: 2000, user_id: user_fixture().id}

      assert {:ok, %Demographic{} = demographic} =
               Survey.create_demographic(valid_attrs)

      assert demographic.gender ==
               "female"

      assert demographic.year_of_birth == 2000
    end

    test "create_demographic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Survey.create_demographic(@invalid_attrs)
    end

    test "update_demographic/2 with valid data updates the demographic" do
      demographic = demographic_fixture()
      update_attrs = %{gender: "male", year_of_birth: 2001}

      assert {:ok, %Demographic{} = demographic} =
               Survey.update_demographic(demographic, update_attrs)

      assert demographic.gender ==
               "male"

      assert demographic.year_of_birth == 2001
    end

    test "update_demographic/2 with invalid data returns error changeset" do
      demographic = demographic_fixture()
      assert {:error, %Ecto.Changeset{}} = Survey.update_demographic(demographic, @invalid_attrs)
      assert demographic == Survey.get_demographic!(demographic.id)
    end

    test "delete_demographic/1 deletes the demographic" do
      demographic = demographic_fixture()
      assert {:ok, %Demographic{}} = Survey.delete_demographic(demographic)
      assert_raise Ecto.NoResultsError, fn -> Survey.get_demographic!(demographic.id) end
    end

    test "change_demographic/1 returns a demographic changeset" do
      demographic = demographic_fixture()
      assert %Ecto.Changeset{} = Survey.change_demographic(demographic)
    end
  end

  describe "ratings" do
    alias Pento.Survey.Rating

    import Pento.SurveyFixtures

    @invalid_attrs %{stars: nil}

    test "list_ratings/0 returns all ratings" do
      rating = rating_fixture()
      assert Survey.list_ratings() == [rating]
    end

    test "get_rating!/1 returns the rating with given id" do
      rating = rating_fixture()
      assert Survey.get_rating!(rating.id) == rating
    end

    import Pento.{SurveyFixtures, AccountsFixtures, CatalogFixtures}

    test"create_rating/1 with valid data creates a rating" do
    valid_attrs = %{
    stars: 4,
    user_id: Pento.AccountsFixtures.user_fixture().id,
    product_id: product_fixture().id
    }
    assert {:ok, %Rating{} = rating} = Survey.create_rating(valid_attrs)
    assert rating.stars == 4
    end
    test"update_rating/2 with valid data updates the rating" do
    rating = rating_fixture()
    update_attrs = %{stars: 3}

      assert {:ok, %Rating{} = rating} =
               Survey.update_rating(rating, update_attrs)

      assert rating.stars == 3
    end

    test "update_rating/2 with invalid data returns error changeset" do
      rating = rating_fixture()
      assert {:error, %Ecto.Changeset{}} = Survey.update_rating(rating, @invalid_attrs)
      assert rating == Survey.get_rating!(rating.id)
    end

    test "delete_rating/1 deletes the rating" do
      rating = rating_fixture()
      assert {:ok, %Rating{}} = Survey.delete_rating(rating)
      assert_raise Ecto.NoResultsError, fn -> Survey.get_rating!(rating.id) end
    end

    test "change_rating/1 returns a rating changeset" do
      rating = rating_fixture()
      assert %Ecto.Changeset{} = Survey.change_rating(rating)
    end
  end
end
