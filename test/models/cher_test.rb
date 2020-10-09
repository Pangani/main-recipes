require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    def setup
        @chef = Chef.new(:chefname => "Chris", :email => "roypangani@gmail.com")
    end

    test "chef should be valid" do
        assert @chef.valid?
    end

    test "chefname should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end

    test "chefname should be less than 30 characters" do
        @chef.chefname = "a" * 31
        assert_not @chef.valid?
    end

    test "email should be present" do
        @chef.email = ""
        assert_not @chef.valid?
    end

    test "email should not be too long" do
        @chef.email = "a" * 245 +"@example.com"
        assert_not @chef.valid?
    end

    test "email should accept the correct format" do
        valid_emails = %w[user@example.com ROY@gmail.com john+smith@co.uk.org]
        valid_emails.each do |valid_email|
            @chef.email = valid_email
            assert @chef.valid?, "#{valid_email.inspect} should be valid"
        end   
    end

    test "should reject invalid addresses" do
        invalid_emails = %w[roy@example roy@example,com roy.name@gmailjoe@bar+foo.com]
        invalid_emails.each do |invalid_email|
            @chef.email = invalid_email
            assert_not @chef.valid?, "#{invalid_email.inspect} should be invalid"
        end
    end

    test "email should be unique and case insensitive" do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not duplicate_chef.valid?
    end  
    
    test "email should be lowercase before save" do
        mixed_email = "john@Example.com"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end
end