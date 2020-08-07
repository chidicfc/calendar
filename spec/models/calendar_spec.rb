require 'date'

RSpec.describe Calendar do
  before do
    allow(Date).to receive(:today) { Date.new(2020, 8, 7) }
  end

  context 'when no argument is given' do
    subject { described_class.new }

    let(:calendar) do
<<-EOF
    August 2020\s\s\s\s\s
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
 9 10 11 12 13 14 15
16 17 18 19 20 21 22
23 24 25 26 27 28 29
30 31\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
EOF
    end

    it 'returns the calendar for August with Sunday as the first day of the week' do
      expect{subject.execute}.to output(calendar).to_stdout
    end
  end


  context 'when the first day of the week is given' do
    subject { described_class.new('Mo') }

    let(:calendar) do
<<-EOF
    August 2020\s\s\s\s\s
Mo Tu We Th Fr Sa Su
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30
31\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
EOF
    end

    it 'returns the calendar for August with Monday as the first day of the week' do
      expect{subject.execute}.to output(calendar).to_stdout
    end
  end

  context 'when an invalid argument is given' do
    subject { described_class.new('Mon') }

    it 'raises an error' do
      expect{subject}.to raise_error("expected one of Su, Mo, etc")
    end
  end
end
