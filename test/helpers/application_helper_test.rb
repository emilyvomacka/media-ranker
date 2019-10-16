require "test_helper"

describe ApplicationHelper, :helper do 
  describe 'readable date' do
    #nominal success case
    it 'returns correctly formatted date with full timestamp from expected input' do 
      date = Date.today - 14
      result = readable_date(date)
      expect(result).must_include date.to_s
    end 

    #edge failure case
    it 'returns [unknown] from invalid input' do
      date = nil
      result = readable_date(date)
      expect(result).must_equal "[unknown]"
    end 
  end 
end 