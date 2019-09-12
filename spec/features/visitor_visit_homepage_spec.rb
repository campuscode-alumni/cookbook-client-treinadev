require 'rails_helper'

feature "Visitor visit homepage" do
  scenario "and view recipe" do
    allow_any_instance_of(Faraday::Connection).to receive(:get)
      .and_return(
        double("response",
               status: 200,
               body: JSON.parse(
                 File.read(Rails.root.join('spec', 'support', 'recipes.json')),
                 symbolize_names: true)
              )
    )

    visit root_path

    expect(page).to have_css("h1", text: 'Bolo de fubá')
    expect(page).to have_css("li", text: 'Médio')
    expect(page).to have_css("li", text: '50')
    expect(page).to have_css("li", text: 'Farinha, açucar, cenoura')
    expect(page).to have_css("h1", text: 'Bolo de banana')
    expect(page).to have_css("li", text: 'Fácil')
    expect(page).to have_css("li", text: '40')
    expect(page).to have_css("li", text: 'Misturar e assar')
  end
end
