ActiveAdmin.register BxBlockBook::Price, as: "Prices" do
  permit_params :cover_type, :price, :min_limit, :max_limit, :book_size

  controller do
    def action_methods
      if BxBlockBook::Price.all&.count < 2 
        super
      else
       super - ['new', 'create']
      end
    end
  end
end
