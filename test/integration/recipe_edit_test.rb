require 'test_helper'

class RecipeEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "ropan", email: "ropan@mail.com", password: "password")
    @recipe =Recipe.create(:name => "vegetable", :description => "great veg sautee, add veg and oil", chef: @chef)
  end
  
  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description"} }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description} }
    assert_redirected_to  @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @recipe.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text; "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
  end
 
end
