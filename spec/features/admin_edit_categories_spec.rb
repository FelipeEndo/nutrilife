require 'rails_helper'

feature 'Admin Edit category', js: true do
  scenario 'successfully', driver: :webkit do
    admin = create(:admin)
    create(:admin_profile)
    description = Faker::Dessert.unique.variety
    description2 = Faker::Dessert.unique.variety
    image = Rails.root.join('public',
                            'templates',
                            'yummy',
                            'img',
                            'blog-img',
                            "#{Random.rand(1..5)}.jpg")

    category = create(:category, description: description)
    
    image2 = category.avatar

    login_as(admin, scope: :admin)
    visit backoffice_category_index_path

    click_link('Editar Categoria')

    fill_in 'Descrição', with: description2
    attach_file image
    click_button('Editar')
    click_button('Confirmar')

    expect(page).to have_current_path(backoffice_category_index_path)

    expect(page).to have_css('h3', text: description2)
    expect(page).to have_css('a',
                             text: "Editado em: #{category.updated_at
                                                .strftime('%B %d, %Y')}")
    expect(page).to have_css("img[src*='#{File.basename(image)}']")

    expect(page).not_to have_css('h3', text: description)

    expect(page).not_to have_css("img[src*='#{File.basename(image2)}']")
  end
  
  Capybara.use_default_driver 
end