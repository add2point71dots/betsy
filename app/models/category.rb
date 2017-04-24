class Category < ApplicationRecord
     has_and_belongs_to_many :products

     validates :label, presence: { message: 'Oops. Can\'t make something from nothing. Try again.' },
          length: { minimum: 3, message: 'Oops. Label must be at least three characters.' },
          uniqueness: { message: 'Oops. Someone stole your thunder. Labels must be unique.' },
          format: { with: /\A[a-zA-Z]+\z/, message: "Oops. Letters only. Give it another go." }

     before_validation :downcase_label

     def sample_photo
          products = self.products
          product = products.sample
          return product.photo_url
     end

private

     def downcase_label
          if self.label
               self.label = self.label.downcase.singularize
          end
     end
end
