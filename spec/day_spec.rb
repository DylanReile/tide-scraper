require_relative "../day"

describe Day do
  subject { described_class.new(events: events) }

  describe "#daylight_lowtide" do
    subject { super().daylight_lowtide }

    context "when lowtide occurs before sunrise" do
      let(:events) do
        [
          Event.new(type: "Low Tide"),
          Event.new(type: "Sunrise")
        ]
      end

      it { is_expected.to be_nil }
    end

    context "when lowtide occurs after sunset" do
      let(:events) do
        [
          Event.new(type: "Sunrise"),
          Event.new(type: "Sunset"),
          Event.new(type: "Low Tide")
        ]
      end

      it { is_expected.to be_nil }
    end

    context "when no lowtide occurs" do
      let(:events) { [] }
      it { is_expected.to be_nil }
    end

    context "when lowtide occurs between sunrise and sunset" do
      let(:lowtide_event) { Event.new(type: "Low Tide") }

      let(:events) do
        [
          Event.new(type: "Sunrise"),
          lowtide_event,
          Event.new(type: "Sunset"),
        ]
      end
    
      it { is_expected.to eq(lowtide_event) } 
    end
  end
end
