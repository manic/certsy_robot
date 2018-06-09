require 'spec_helper'
require 'certsy_robot'

RSpec.describe CertsyRobot do
  Given(:robot) { CertsyRobot.new }

  context 'initial state: pending' do
    Then { robot.state == :pending }
  end

  context '#command' do
    context 'when receive PLACE' do
      When { allow(robot).to receive(:place).and_call_original }
      When { robot.command('PLACE 1,2,SOUTH') }
      Then { expect(robot).to have_received(:place).with('1', '2', 'SOUTH') }
      And { robot.state == :placed }
      And { robot.x == 1 }
      And { robot.y == 2 }
      And { robot.direction == 'SOUTH' }
    end

    context 'when receive PLACE twice' do
      When { robot.command('PLACE 1,2,NORTH') }
      When { robot.command('PLACE 2,3,WEST') }
      Then { robot.state == :placed }
      And { robot.x == 2 }
      And { robot.y == 3 }
      And { robot.direction == 'WEST' }
    end

    context 'when receive invalid PLACE command' do
      context 'when direction is invalid' do
        When { robot.command('PLACE 1,3,INVALID') }
        Then { robot.state == :pending }
        And { robot.x == nil }
        And { robot.y == nil }
        And { robot.direction == nil }
      end

      context 'when position is invalid' do
        When { robot.command('PLACE 1,9,NORTH') }
        Then { robot.state == :pending }
        And { robot.x == nil }
        And { robot.y == nil }
        And { robot.direction == nil }
      end
    end

    context 'when receive REPORT' do
      When { robot.command('PLACE 1,2,SOUTH') }
      Then do
        expect { robot.command('REPORT') }.to output("1,2,SOUTH\n").to_stdout
      end
    end

    context 'when receive LEFT' do
      context 'ignore when robot is not placed' do
        When { robot.command('LEFT') }
        Then { robot.state == :pending }
      end

      context 'when robot is placed facing SOUTH' do
        When { robot.command('PLACE 1,2,SOUTH') }
        When { robot.command('LEFT') }
        Then { robot.direction == 'EAST' }
      end
      context 'when robot is placed facing EAST' do
        When { robot.command('PLACE 1,2,EAST') }
        When { robot.command('LEFT') }
        Then { robot.direction == 'NORTH' }
      end
      context 'when robot is placed facing NORTH' do
        When { robot.command('PLACE 1,2,NORTH') }
        When { robot.command('LEFT') }
        Then { robot.direction == 'WEST' }
      end
      context 'when robot is placed facing WEST' do
        When { robot.command('PLACE 1,2,WEST') }
        When { robot.command('LEFT') }
        Then { robot.direction == 'SOUTH' }
      end
    end
    context 'when receive RIGHT' do
      context 'ignore when robot is not placed' do
        When { robot.command('RIGHT') }
        Then { robot.state == :pending }
      end

      context 'when robot is placed facing SOUTH' do
        When { robot.command('PLACE 1,2,SOUTH') }
        When { robot.command('RIGHT') }
        Then { robot.direction == 'WEST' }
      end
      context 'when robot is placed facing EAST' do
        When { robot.command('PLACE 1,2,EAST') }
        When { robot.command('RIGHT') }
        Then { robot.direction == 'SOUTH' }
      end
      context 'when robot is placed facing NORTH' do
        When { robot.command('PLACE 1,2,NORTH') }
        When { robot.command('RIGHT') }
        Then { robot.direction == 'EAST' }
      end
      context 'when robot is placed facing WEST' do
        When { robot.command('PLACE 1,2,WEST') }
        When { robot.command('RIGHT') }
        Then { robot.direction == 'NORTH' }
      end
    end
  end
end
