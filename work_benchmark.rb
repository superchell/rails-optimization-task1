require 'benchmark/ips'
require_relative 'task-1'

GC.disable

Benchmark.ips do |x|
  # x.time = 1
  # x.warmup = 2
  x.stats = :bootstrap
  x.confidence = 95

  x.report('Work 1x') { work }
  x.report('Work 2x') { work(file_path: 'data_samples/data2x.txt') }
  x.report('Work 4x') { work(file_path: 'data_samples/data4x.txt') }
  x.report('Work 8x') { work(file_path: 'data_samples/data8x.txt') }

  x.compare!
end