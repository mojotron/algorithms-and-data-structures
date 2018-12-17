class BinarySearchTree

  class Node
    attr_accessor :value, :left_child, :right_child
    def initialize(value)
      @value = value
      @left_child = nil
      @right_child = nil
    end
  end

  attr_accessor :root
  def initialize()
    @root = nil#Node.new(value)#create root with empty node, now we can use references to @root
  end

  def insert_with_loop(value)
    new_node = Node.new(value)
    if @root == nil
      @root = new_node
      return
    end
    temp_node = @root
    while true
      if value <= temp_node.value
        if temp_node.left_child == nil
          temp_node.left_child = new_node
          return
        else
          temp_node = temp_node.left_child
        end   
      elsif value > temp_node.value
        if temp_node.right_child == nil
          temp_node.right_child = new_node
          return
        else
          temp_node = temp_node.right_child
        end
      end
    end
  end

  def insert(root = @root, value)
    #require root to be empty node => @root = Node.new(nil), so referece can be valid
    if root.value == nil
      return root.value = value
    elsif value <= root.value
      if root.left_child == nil
        return root.left_child = Node.new(value)
      end
      insert(root.left_child,value)
    elsif value > root.value
      if root.right_child == nil
        return root.right_child = Node.new(value)
      end
      insert(root.right_child,value)
    end
  end

  def insert_node(value)
    @root = append_node(value)
  end

  def append_node(root = @root, value)
    #global variable @root must be nil
    if root == nil
      root = Node.new(value)
    elsif value <= root.value
      root.left_child = append_node(root.left_child, value)
    else
      root.right_child = append_node(root.right_child, value)
    end
    root
  end

  def contains?(root = @root, value)
    return false if root == nil
    if root.value == value
      return true
    elsif value <= root.value
      contains?(root.left_child, value)
    else 
      contains?(root.right_child, value)
    end
  end

  def search(root = @root, value)
    return nil if root == nil
    if root.value == value
      return root
    elsif value <= root.value
      search(root.left_child, value)
    else 
      search(root.right_child, value)
    end
  end

  def find_min(root = @root)
    return nil if root == nil
    until root.left_child == nil
      root = root.left_child
    end
    root.value 
  end

  def find_min_recursion(root = @root)
    return nil if root == nil
    if root.left_child == nil
      return root.value
    else
      find_min_recursion(root.left_child)
    end
  end

  def find_max(root = @root)
    return nil if root == nil
    until root.right_child == nil
      root = root.right_child
    end
    root.value
  end
  
  def find_max_recursion(root = @root)
    return nil if root == nil
    if root.right_child == nil
      return root.value
    else
      find_max_recursion(root.right_child)
    end
  end
  
  def find_height(root = @root)
    return -1 if root == nil
    left = find_height(root.left_child)
    right = find_height(root.right_child)
    return [left, right].max + 1
  end

  def breadth_first_traversal(root = @root)
    return nil if root == nil
    queue = Array.new()
    queue.push(root)
    while !queue.empty?()
      temp_node = queue.shift()
      print "#{temp_node.value.to_s} "
      queue.push(temp_node.left_child) if temp_node.left_child != nil
      queue.push(temp_node.right_child) if temp_node.right_child != nil
    end
    puts
  end

  def preorder_traversal(root = @root)
    return if root == nil
    print "#{root.value} "
    preorder_traversal(root.left_child)
    preorder_traversal(root.right_child)
  end

  def inorder_traversal(root = @root, arr = [])
    return if root == nil
    inorder_traversal(root.left_child, arr)
    arr << root.value
    inorder_traversal(root.right_child, arr)
    arr
  end

  def postorder_traversal(root = @root)
    return if root == nil
    postorder_traversal(root.left_child)
    postorder_traversal(root.right_child)
    print "#{root.value} "
  end
  #cheking if BT is BST
  def is_bst?(root = @root, min_value = '', max_value = '~~~~~~')
    return true if root == nil
    if root.value < max_value && root.value > min_value &&
      is_bst?(root.left_child, min_value, root.value) &&
        is_bst?(root.right_child, root.value, max_value)
      return true
    else
      return false
    end
  end

  def is_bst2?(root = @root)
    list = inorder_traversal(root)
    (list == list.sort) ? true : false
  end

  def delete(value, root = @root)
    if root == nil
      return nil
    elsif value < root.value
      root.left_child = delete(value, root.left_child)
    elsif value > root.value
      root.right_child = delete(value, root.right_child)
    else
      if root.left_child == nil && root.right_child == nil
        root = nil
      elsif root.left_child == nil
        root = root.right_child
      elsif root.right_child == nil
        root = root.left_child
      elsif root.left_child != nil && root.right_child != nil
        temp_node = find_min_recursion(root.right_child)
        root.value = temp_node
        root.right_child = delete(temp_node, root.right_child)
      end
    end
    root
  end

  def inorder_successor(value, root = @root)
    temp_node = search(value)
    return nil if temp_node == nil
    if temp_node.right_child != nil
      current = temp_node.right_child
      while current.left_child != nil
        current = current.left_child
      end
      return current
    else
      successor = nil
      ancestor = root
      while ancestor != temp_node
        if temp_node.value < ancestor.value
          successor = ancestor
          ancestor = ancestor.left_child
        else
          ancestor = ancestor.right_child
        end
      end
      return successor
    end
  end

end

x = BinarySearchTree.new()
x.insert_node('F')
x.insert_with_loop('D')
x.insert_node('J')
x.insert_with_loop('B')
x.insert_node('E')
x.insert_with_loop('G')
x.insert_node('K')
x.insert_with_loop('A')
x.insert_node('C')
x.insert_with_loop('I')
x.insert_node('H')
puts x.inorder_traversal().join(' ')
#x.delete('F')
#puts x.inorder_traversal().join(' ')
#p x.search('B')
p x.inorder_successor('F')

