defmodule SportCars.ProductsTest do
  use SportCars.DataCase

  alias SportCars.Products

  describe "cars" do
    alias SportCars.Products.Car

    import SportCars.ProductsFixtures

    @invalid_attrs %{brand: nil, model: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Products.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Products.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{brand: "some brand", model: "some model"}

      assert {:ok, %Car{} = car} = Products.create_car(valid_attrs)
      assert car.brand == "some brand"
      assert car.model == "some model"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{brand: "some updated brand", model: "some updated model"}

      assert {:ok, %Car{} = car} = Products.update_car(car, update_attrs)
      assert car.brand == "some updated brand"
      assert car.model == "some updated model"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_car(car, @invalid_attrs)
      assert car == Products.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Products.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Products.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Products.change_car(car)
    end
  end
end
