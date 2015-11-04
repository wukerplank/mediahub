class MediaType

  TYPES = [
    { name: 'Movie', value: 'movie' },
    { name: 'TV-Show', value: 'tvshow' }
  ]

  attr_reader :name, :value

  def initialize(value)
    return nil if value.blank?

    type = TYPES.detect { |type| type[:value] == value }
    raise "Unknown type '#{value}'" unless type

    @name = type[:name]
    @value = type[:value]
  end

  def self.all
    TYPES.map{ |type| MediaType.new(type[:value]) }
  end

end
