require 'spec_helper'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'benchmark'

describe "testing concurrencies" do
  subject { Ghee.new(GH_AUTH) }

  xit "should make requests in parallel" do
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
  it "play with paging" do
    Benchmark.bm do |b|
      b.report do
        puts subject.repos("aspnet/mvc").issues.all_parallel.size
      end
      b.report do 
        puts subject.repos("aspnet/mvc").issues.all.size
      end
    end
  end
end
