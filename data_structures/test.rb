class BinarySearcTree
  class Node
    attr_accessor :value, :left, :right
    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end
  end

  attr_accessor :root
  def initialize()
    @root = nil
  end

  def loop_insert(value)
    new_node = Node.new(value)
    if @root == nil
      @root = new_node
      return
    end
    temp_node = @root
    while true
      if value <= temp_node.value
        if temp_node.left == nil
          temp_node.left = new_node
          return
        else
          temp_node = temp_node.left
        end
      elsif value > temp_node.value
        if temp_node.right == nil
          temp_node.right = new_node
          return
        else
          temp_node = temp_node.right
        end
      end
    end
  end

  def insert(value, root)
    new_node = Node.new(value)
    if root == nil
      root = new_node
    elsif value <= root.value
      if root.left == nil
        root.left = new_node
      else
        insert(value, root.left)
      end
    elsif value > root.value
      if root.right == nil
        root.right = new_node
      else
        insert(value, root.right)
      end
    end
    root
  end

  def insert_node(value, root = @root)
    @root = insert(value, root)
  end

  def append(value, root)
    if root == nil
      root = Node.new(value)
    elsif value <= root.value
      root.left = append(value, root.left)
    else
      root.right = append(value, root.right)
    end
    root
  end

  def append_node(value, root = @root)
    @root = append(value, root)
  end

  def contains?(value, root = @root)
    return false if root == nil
    if root.value == value
      return true
    elsif value <= root.value
      contains?(value, root.left)
    else
      contains?(value, root.right)
    end
  end
  
  def find_min(root = @root)
    return nil if root == nil
    until root.left == nil
      root = root.left
    end
    root.value
  end

  def find_min_recursion(root = @root)
    return nil if root == nil
    return root.value if root.left == nil
    find_min_recursion(root.left)
  end

  def find_max(root = @root)
    return nil if root == nil
    until root.right == nil
      root = root.right
    end
    root.value
  end

  def find_max_recursion(root = @root)
    return nil if root == nil
    return root.value if root.right == nil
    find_max_recursion(root.right)
  end

  def root_height(root = @root)
    return -1 if root == nil
    left = root_height(root.left)
    right = root_height(root.right)
    return [left, right].max + 1
  end

  def level_traversal(root = @root)
    return if root == nil
    queue = Array.new()
    queue.push(root)
    while !queue.empty?()
      dequque = queue.shift()
      print "#{dequque.value} "
      queue.push(dequque.left) if dequque.left != nil
      queue.push(dequque.right) if dequque.right != nil
    end
    puts
  end

  def preorder_traversal(root = @root)
    return if root == nil
    print "#{root.value} "
    preorder_traversal(root.left)
    preorder_traversal(root.right)
  end

  def inorder_traversal(root = @root)
    return if root == nil
    inorder_traversal(root.left)
    print "#{root.value} "
    inorder_traversal(root.right)
  end

  def posorder_traversal(root = @root)
    return if root == nil
    posorder_traversal(root.left)
    posorder_traversal(root.right)
    print "#{root.value} "
  end
  #cheking if BT is BST
  def is_subtree_lesser?(value, root = @root)
    return true if root == nil
    if root.value == value && is_subtree_lesser?(value, root.lef) &&

  end

  def is_subtree_greater?(value, root = @root)
  end

  def is_bst?(root = @root)
  end
end

x = BinarySearcTree.new()
x.loop_insert('F')
x.loop_insert('D')
x.loop_insert('J')
x.insert_node('B')
x.insert_node('E')
x.insert_node('G')
x.insert_node('K')
x.append_node('A')
x.append_node('C')
x.append_node('I')
x.append_node('H')

p x.contains?('A')
p x.contains?('Z')
p x.find_min()
p x.find_min_recursion()
p x.find_max()
p x.find_max_recursion()
p x.root_height()
x.level_traversal()
x.preorder_traversal()
puts
x.inorder_traversal()
puts
x.posorder_traversal()
puts
