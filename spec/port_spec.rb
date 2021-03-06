require 'spec_helper'

context "A port" do
  specify "should return terms from the queue if it is not empty" do
    port = FakePort.new()
    port.queue.clear
    port.queue << :foo << :bar
    expect(port.receive).to eq(:foo)
    expect(port.receive).to eq(:bar)
    expect(port.receive).to eq(nil)
  end

  specify "should read_from_input if the queue gets empty" do
    port = FakePort.new(:bar)
    port.queue.clear
    port.queue << :foo
    expect(port.receive).to eq(:foo)
    expect(port.receive).to eq(:bar)
    expect(port.receive).to eq(nil)
  end

  specify "should put the terms in skipped at the front of queue when restore_skipped is called" do
    port = FakePort.new(:baz)
    port.queue.clear
    port.queue << :bar
    port.skipped << :foo
    port.restore_skipped

    expect(port.receive).to eq(:foo)
    expect(port.receive).to eq(:bar)
    expect(port.receive).to eq(:baz)
    expect(port.receive).to eq(nil)
  end
end
