# frozen_string_literal: true

class CertsyRobot
  attr_reader :state, :x, :y, :direction
  VALID_POS_X = 0..5
  VALID_POS_Y = 0..5
  VALID_DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  VALID_ACTIONS = %w[PLACE MOVE LEFT RIGHT REPORT].freeze
  COMMAND_PATTERN = /(#{VALID_ACTIONS.join('|')})\s*(.+)?/

  def initialize
    @state = :pending
  end

  def command(command_string)
    matched = command_string.match(COMMAND_PATTERN)
    return unless matched
    case matched[1]
    when 'PLACE'
      x, y, direction = matched[2].split(',')
      place(x, y, direction)
    when 'REPORT'
      return if pending?
      puts report
    when 'LEFT'
      return if pending?
      left
    when 'RIGHT'
      return if pending?
      right
    when 'MOVE'
      return if pending?
      move
    end
  end

  def report
    "#{x},#{y},#{direction}"
  end

  private

  def move
    case direction
    when 'NORTH'
      @y += 1 if valid_position?(x, y + 1)
    when 'SOUTH'
      @y -= 1 if valid_position?(x, y - 1)
    when 'EAST'
      @x += 1 if valid_position?(x + 1, y)
    when 'WEST'
      @x -= 1 if valid_position?(x - 1, y)
    end
  end

  def left
    index = VALID_DIRECTIONS.index(direction) - 1
    @direction = VALID_DIRECTIONS[index]
  end

  def right
    index = VALID_DIRECTIONS.index(direction) + 1
    @direction = VALID_DIRECTIONS[index % 4]
  end

  def pending?
    state == :pending
  end

  def valid_position?(pos_x, pos_y)
    VALID_POS_X.cover?(pos_x.to_i) && VALID_POS_Y.cover?(pos_y.to_i)
  end

  def valid_direction?(direction)
    VALID_DIRECTIONS.include?(direction)
  end

  def place(pos_x, pos_y, direction)
    return unless valid_position?(pos_x, pos_y) && valid_direction?(direction)
    @direction = direction
    @x = pos_x.to_i
    @y = pos_y.to_i
    @state = :placed
  end

  def ignore; nil end
end
