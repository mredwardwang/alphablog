require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

    def setup
        @category = Category.create(name: "sports")
        @category2 = Category.create(name: "programming")
        @user = User.create(username: "fred", 
        email: "fred@example.com", 
        password: "password", 
        admin: true)        
    end

    test "should show categories listing" do
        get categories_path
        assert_template 'categories/index'
        assert_select "a[href=?]", category_path(@category), text: @category.name
        assert_select "a[href=?]", category_path(@category2), text: @category2.name
    end

end