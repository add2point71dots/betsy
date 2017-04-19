require "test_helper"

describe Category do

     # describe "relations" do
     #
     #      it "has a list of categories" do
     #           product = products(:product)
     #           product.must_respond_to :categories
     #           product.categories.each do |category|
     #           category.must_be_kind_of Category
     #      end
     # end

     describe "validations" do

          it "requires a label" do
               work = Category.new
               work.valid?.must_equal false
               work.errors.messages.must_include :label
          end

          it "allows three valid categories" do
               valid_categories = ['empire', 'strikes', 'back']
               valid_categories.each do |category|
                    category = Category.new(label: category)
                    category.valid?.must_equal true
               end
          end

          it "fixes almost-valid categories" do
               categories = ['Blues', 'blues', 'BLUE', 'reds', 'GreEn']
               categories.each do |category|
                    category = Category.new(label: category)
                    category.valid?.must_equal true
                    category.label.must_equal category.label.downcase.singularize
               end
          end

          it "rejects invalid categories" do
               invalid_categories = ['at', 'do', 'phd thesis', 1337, nil]
               invalid_categories.each do |category|
                     category = Category.new(label: category)
                     category.valid?.must_equal false
                     category.errors.messages.must_include :label
               end
          end

          it "requires unique labels for each category instance" do
               label = 'blues'
               category_blue = Category.new(label: label)
               category_blue.save!

               category_azure = Category.new(label: label)
               category_azure.valid?.must_equal false
               category_azure.errors.messages.must_include :label
          end
     end
end
