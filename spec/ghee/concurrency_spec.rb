require 'spec_helper'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'benchmark'

describe "testing concurrencies" do
  subject { Ghee.new(GH_AUTH) }

  it "should make requests in parallel" do
    Benchmark.bm do |b|
      b.report do
        subject.in_parallel :em_synchrony do |ghee|
          puts ghee.connection.in_parallel?
          5.times do |i|
            ghee.repos("rauhryan/huboard").raw
            ghee.repos("rauhryan/huboard").issues.raw
            ghee.repos("rauhryan/huboard").issues.labels.raw
          end
        end
      end
      b.report do
        ghee = subject
        ghee.connection.adapter  :typhoeus
        puts ghee.connection.in_parallel?
          5.times do |i|
             ghee.repos("rauhryan/huboard").raw
             ghee.repos("rauhryan/huboard").issues.raw
             ghee.repos("rauhryan/huboard").issues.labels.raw
          end
      end
    end
  end
end
