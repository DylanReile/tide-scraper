require_relative "../tide_station"

describe TideStation do
  subject { described_class.new("Huntington-Beach") }

  before do
    stub_request(:any, "https://www.tide-forecast.com/locations/Huntington-Beach/tides/latest")
    .to_return(body: '
      <table>
          <tr class="even">
            <td class="date" rowspan="2">Wednesday 31 January</td>
            <td class="time "> 5:52 PM</td>
            <td class="time-zone">PST</td>
            <td class="level metric"></td>
            <td class="level"></td>
            <td>Moonrise</td>
          </tr>

          <tr class="odd">
            <td class="date" rowspan="8">Thursday 1 February</td>
            <td class="time tide"> 3:02 AM</td>
            <td class="time-zone">PST</td>
            <td class="level metric">0.78 meters</td>
            <td class="level">(<span class="imperial">2.56 ft</span>)</td>
            <td class="tide">Low Tide</td>
          </tr>

          <tr class="odd">
            <td class="time tide"> 8:02 PM</td>
            <td class="time-zone">PST</td>
            <td class="level metric"></td>
            <td class="level">(<span class="imperial"></span>)</td>
            <td>Sunset</td>
          </tr>
      </table>
    ')
  end

  it "parses out the days" do
    expect(subject.days.map(&:date)).to eq([
      "Wednesday 31 January",
      "Thursday 1 February"
    ])
  end

  it "parses events into ther corresponding days" do
    expect(subject.days.first.events.count).to eq(1)
    expect(subject.days.last.events.count).to eq(2)
  end

  it "parses event fields" do
    expect(subject.days.first.events.first.attributes).to eq(
      time: " 5:52 PM",
      timezone: "PST",
      type: "Moonrise",
      tidal_height_meters: ""  
    )
  end
end
