require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

    test "get new category form and create category" do
        sign_in_as(@user, "password")
        get new_category_path
        assert_template 'categories/new'
        assert_difference 'Category.count', 1 do
            post categories_path, 
                    params: {category: {name: 'news'}}
                    assert_redirected_to categories_path
                    follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "news", response.body
    end

    test "invalid category submissions results in failure" do
        sign_in_as(@user, "password")
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count' do
            post categories_path, 
                    params: {category: {name: ' '}}
        end
        assert_template 'categories/new'
        assert_select 'h4.alert-heading'
    end

end