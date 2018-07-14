require 'rails_helper'

feature 'Admin search for content filter by date' do
  scenario 'successfully' do
    
    admin = create(:admin)
    create(:admin_profile)
    category = create(:category)
    image = Rails.root.join('public',
                            'templates',
                            'yummy',
                            'img',
                            'blog-img',
                            "#{Random.rand(1..16)}.jpg")
    post = create(:post)
    post2 = create(:post)
    post3 = create(:post, title: Faker::Name.unique.name, created_at: Date.yesterday.to_s, images: [image.open])

    backoffice_blog_dashboard_index_path
  
    click_link("#{post.created_at.strftime('%B %d, %Y')}", match: :first)
    
    expect(page).to have_css('h3', text: admin.admin_profile.name)
    expect(page).to have_css('a', text: admin.email)
    expect(page).to have_css('p', text: admin.admin_profile.description)
    expect(page).to have_css('a', text: admin.created_at.strftime('%B %d, %Y'))
    expect(page).to have_css("img[src*='#{admin.admin_profile.avatar.file.identifier}']")
    
    expect(page).to have_css('h3', text: category.description)
    expect(page).to have_css('a', text: category.created_at.strftime('%B %d, %Y'))
    expect(page).to have_css('a', text: "#{t('created_by')}: #{category.admin}")
    expect(page).to have_css("img[src*='#{category.avatar.file.identifier}']")
    
    expect(page).to have_css('h3', text: post.title)
    expect(page).to have_css('a', text: post.admin.admin_profile.name)
    expect(page).to have_css('p', text: post.body[0..96])
    expect(page).to have_css('a', text: post.created_at.strftime('%B %d, %Y'))
    expect(page).to have_css("img[src*='#{post.images.first.file.identifier}']")

    expect(page).to have_css('h3', text: post2.title)
    expect(page).to have_css('a', text: post.admin.admin_profile.name)
    expect(page).to have_css('p', text: post2.body[0..96])
    expect(page).to have_css('a', text: post2.created_at.strftime('%B %d, %Y'))
    expect(page).to have_css("img[src*='#{post2
                                          .images.first.file.identifier}']")
                                          
    expect(page).not_to have_css('h3', text: post3.title)
    expect(page).not_to have_css('p', text: post3.body[0..96])
    expect(page).not_to have_css('a', text: post3.created_at.strftime('%B %d, %Y'))
    expect(page).not_to have_css("img[src*='#{post3
                                          .images.first.file.identifier}']")
  end
end