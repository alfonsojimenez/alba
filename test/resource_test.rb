require_relative 'test_helper'

class ResourceTest < MiniTest::Test
  class Foo
    attr_accessor :id, :bars
  end

  class Bar
    attr_accessor :id
  end

  class BarResource
    include Alba::Resource
    attributes :id
  end

  class FooResource
    include Alba::Resource
    key :foo
    attributes :id
    many :bars, resource: BarResource
  end

  def test_serializable_hash
    foo = Foo.new
    foo.id = 1
    bar = Bar.new
    bar.id = 1
    foo.bars = [bar]
    assert_equal(
      {id: 1, bars: [{id: 1}]},
      FooResource.new(foo).serializable_hash
    )
  end
end
