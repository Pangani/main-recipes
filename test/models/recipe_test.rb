require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    def setup
        @chef = Chef.create!(:chefname => "Wishly", :email => "rex@gmail.com", password: "password", password_confirmation:"password" )
        @recipe = @chef.recipes.build(:name => "vegetable", :description => "vegetable recipe")
    end

    test "recipe should be valid" do
        assert @recipe.valid?
    end

    test "name should be present" do
        @recipe.name = ""
        assert_not @recipe.valid?
    end

    test "description should be present" do
        @recipe.description = ""
        assert_not @recipe.valid?
    end

    test "recipe without chef should be invalid" do
        @recipe.chef_id = nil 
        assert_not @recipe.valid?
    end

    test "description shouldn't be less than 5 characters" do
        @recipe.description = "a" * 3
        assert_not @recipe.valid?
    end
    
    test "description shouldn't be more tha 500 charactere" do
        @recipe.description = "a" * 501
        assert_not @recipe.valid?
    end
end
