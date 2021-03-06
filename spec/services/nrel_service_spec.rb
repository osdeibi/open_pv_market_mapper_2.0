describe NRELService do

  before(:each) do
    @service = NRELService.new
  end

  it 'creates states with accurate data' do
    VCR.use_cassette 'nrel_service#get_state_data' do
      @service.get_state_data
      state = State.find_by(abbreviation: "AK")

      expect(state.abbreviation).to eq "AK"
      expect(state.avg_cost_pw).to eq 6.466
      expect(state.total_capacity).to eq 0.1242
      expect(state.total_installs).to eq 22
    end
  end

  it "updates states" do
    VCR.use_cassette 'nrel_service#get_state_data' do
      @service.get_state_data
      VCR.use_cassette 'nrel_service#update_state_data' do
        @service.update_state_data
        state = State.find_by(abbreviation: "AK")

        expect(state.abbreviation).to eq "AK"
        expect(state.avg_cost_pw).to eq 6.466
        expect(state.total_capacity).to eq 0.1242
        expect(state.total_installs).to eq 22
      end
    end
  end
end
