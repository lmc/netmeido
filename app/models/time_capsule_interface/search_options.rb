class TimeCapsuleInterface::SearchOptions < OpenStruct
  
  def initialize(params)
    params.reverse_merge!(
      :created_at_gt => 15.minutes.ago,
      :created_at_lt => Time.now,
      :interfaces    => :all
    )
    super(params)
  end
  
  def [](key)
    send(key)
  end
  
end