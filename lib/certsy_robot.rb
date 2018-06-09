# frozen_string_literal: true

class CertsyRobot
  attr_reader :state, :x, :y, :direction
  VALID_DIRECTIONS = %w[NORTH EAST SOUTH WEST]
  VALID_ACTIONS = %w[PLACE MOVE LEFT RIGHT REPORT]
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
    end
  end

  def report
    "#{x},#{y},#{direction}"
  end

  private

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

  def valid_position?(x, y)
    (0..5).include?(x.to_i) && (0..5).include?(y.to_i)
  end

  def valid_direction?(direction)
    VALID_DIRECTIONS.include?(direction)
  end

  def place(x, y, direction)
    return unless valid_position?(x, y) && valid_direction?(direction)
    @direction = direction
    @x = x.to_i
    @y = y.to_i
    @state = :placed
  end

  def ignore; nil end
end
