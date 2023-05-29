require 'rails_helper'

RSpec.describe NavbarComponent, type: :component do
  describe 'render component' do
    context 'with a logged user' do
      # Here i'm using FactoryBot gem
      let!(:user) { create(:user) }

      it 'renders a my account link' do
        render_inline(described_class.new(user: user))
        expect(rendered_component).to include 'Sign out'
      end
    end

    context 'without a logged user' do
      it 'does not render a my account link' do
        render_inline(described_class.new(user: nil))
        expect(rendered_component).to_not include 'Sign ut'
      end
    end
  end
end