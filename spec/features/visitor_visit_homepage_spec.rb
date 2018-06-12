require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    create(:admin )
    create( :blog )
    
    visit root_path

    expect(page).to have_css('a', text: 'NutriLife')
    expect(page).to have_css('p', text: 'Bem-vindo ao Mundo Saudável')
  end
  
  scenario 'and see the Blogs' do
    #cria os dados necessários
    create(:admin )
    blog = create( :blog )
    blog2 = create( :blog, images: [Rails.root.join('public', "Nutritionist2.jpg").open] )
  
    # simula a ação do usuário
    visit root_path
  
    # expectativas do usuário após a ação
    expect(page).to have_css('h4', text: blog.title)
    expect(page).to have_css('a', text: blog.admin.name)
    expect(page).to have_css('p', text: blog.body[0..96])
    expect(page).to have_css('a', text: blog.created_at.strftime("%B %d, %Y"))
    expect(page).to have_css("img[src*='#{blog.images.first.file.identifier}']")
    
    expect(page).to have_css('h4', text: blog2.title)
    expect(page).to have_css('a', text: blog.admin.name)
    expect(page).to have_css('p', text: blog2.body[0..96])
    expect(page).to have_css('a', text: blog2.created_at.strftime("%B %d, %Y"))
    expect(page).to have_css("img[src*='#{blog2.images.first.file.identifier}']")
  end

  scenario 'and see the categories' do
    #cria os dados necessários
    create(:admin )
    create( :blog )
    category1 = create(:category )
    category2 = create(:category )
    category3 = create(:category )
    
  
    # simula a ação do usuário
    visit root_path
    
    # expectativas do usuário após a ação
    expect(page).to have_css('a', text: category1.description)
    expect(page).to have_css('a', text: category2.description)
    expect(page).to have_css('a', text: category3.description)
  end
  
end
