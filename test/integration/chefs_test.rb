require 'test_helper'

class ChefsTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(:chefname => "Pride", :email => "pride@gmail.com", password: "password")
    @chef2 = Chef.create!(chefname: "usher", email: "usher@example.com", password: "password")
  end
  
  test "should get chefs index" do
    get recipes_url
    assert_response :success
  end

  test "should get chefs listing" do
    get recipes_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname
  end

  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count' -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

  # test "create new valid recipe" do
  #   get new_recipe_path
  #   assert_template 'recipes/new'
  #   name_of_recipe = "chicken saute"
  #   description_of_recipe = "pill the potatoes cut into sizeable pieces, fry them in hot cooking oil, ready to pieces"
  #   assert_difference 'Recipe.count', 1 do
  #     post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe } }
  #   end
  #   follow_redirect!
  #   assert_match name_of_recipe.capitalize, response.body
  #   assert_match description_of_recipe.capitalize, response.body
  # end

  # test "reject invalid recipe submissions" do
  #   get new_recipe_path
  #   assert_template 'recipes/new'
  #   assert_no_difference "Recipe.count" do
  #     post recipes_path, params: { recipe: { name: " ", description: " "} }
  #   end
  #   assert_template 'recipes/new'
  #   assert_select 'h2.panel-title'
  #   assert_select 'div.panel-body'
  # end
end
