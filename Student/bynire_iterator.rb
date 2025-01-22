
class Binary_iterator
  include Enumerable

  def initialize(root)
    self.root = root
  end

  def each(&block)
    traverse_in_order(self.root, &block)
  end

  private

  attr_accessor :root
  def traverse_in_order(node, &block)
    return if node.nil?

    traverse_in_order(node.left, &block)
    block.call(node.value)
    traverse_in_order(node.right, &block)
  end
end