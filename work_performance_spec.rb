require 'rspec-benchmark'
require_relative 'task-1'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

def generate_data_file(x = 1)
  data = File.read(DATA_FILE)
  data_file = File.open('test_data.txt', 'w+')
  x.times do
    File.write(data_file, "#{data}", mode: 'a')
  end

  data_file.path
end

RSpec.describe 'Performance' do
  describe 'linear work' do
    it 'works under 4 ms' do
      expect { work(file_path: generate_data_file(1)) }.to perform_under(1).ms.warmup(2).times.sample(20).times
    end

    it 'works with 2000 its per sec' do
      expect { work(file_path: generate_data_file(1)) }.to perform_at_least(2000).within(1).warmup(1).ips
    end

    # it 'performs large data with 30 sec' do
    #   expect { work(file_path: 'data_large.txt') }.to perform_under(30).ms
    # end

    it 'performs with linear complexity' do
      sizes = [1, 2, 4, 8]
      expect { |n, _i|
        work(file_path: generate_data_file(n))
      }.to perform_linear.in_range(sizes).ratio(2)
    end
  end
end