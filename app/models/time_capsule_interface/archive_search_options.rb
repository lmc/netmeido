class TimeCapsuleInterface::ArchiveSearchOptions < OpenStruct
  include OpenStructExtensions
  
  def initialize(params)
    params.reverse_merge!(
      :period_start_gt => 1.days.ago,
      :period_start_lt => Time.now,
      :interfaces    => :all
    )
    super(params)
  end
  
end