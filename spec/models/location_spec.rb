RSpec.describe Location, type: :model do

  describe 'Factory' do
    it 'is expected to be valid' do
      expect(create(:location)).to be_valid
    end
  end

end
