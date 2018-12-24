class AvlTree
  class Node
    attr_accessor :value, :link_left, :link_right
    def initialize(value)
      @value = value
      @link_left = nil
      @link_right = nil
    end
  end

  attr_accessor :root
  def initialize()
    @root = nil
  end

  def insert_node(value, root)
    if root == nil
      root = Node.new(value)
    elsif value < root.value
      root.link_left = insert_node(value, root.link_left)
    elsif value > root.value
      root.link_right = insert_node(value, root.link_right)
    elsif value == root.value
      return root
    end
    balance(root)
  end

  def insert(value)
    @root = insert_node(value, @root)
  end

  def height(root = @root)
    return -1 if root == nil
    left = height(root.link_left)
    right = height(root.link_right)
    return [left, right].max + 1
  end

  def child_height(root = @root)
    return 0 if root == nil
    left = child_height(root.link_left)
    right = child_height(root.link_right)
    return [left, right].max + 1
  end

  def balance(root)
    if child_height(root.link_left) - child_height(root.link_right) == 2
      if child_height(root.link_left.link_right) > child_height(root.link_left.link_left)
        #return puts "LEFT RIGHT"
        return rotate_left_right(root)
      end
      #return puts "LEFT LEFT"
      return rotate_right(root)
    elsif child_height(root.link_left) - child_height(root.link_right) == -2
      if child_height(root.link_right.link_left) > child_height(root.link_right.link_right)
        #return puts "RIGHT LEFT"
        return rotate_right_left(root)
      end
      #return puts 'RIGHT RIGHT'
      return rotate_left(root)
    end
    root
  end

  def balance2(root = @root)
    get_height = height(root)
    
    if get_height == 2 && root.link_left && root.link_left.link_left 
      return puts "LEFT LEFT"
    elsif get_height == 2 && root.link_left && root.link_left.link_right
      return puts "LEFT RIGHT"
    elsif get_height == 2 && root.link_right && root.link_right.link_right
      return puts 'RIGHT RIGHT'
    elsif get_height == 2 && root.link_right && root.link_right.link_left
      return puts "RIGHT LEFT"
    end
  end

  def rotate_left(root = @root)
    temp_root = root.link_right
    root.link_right = temp_root.link_left
    temp_root.link_left = root
    temp_root
  end

  def rotate_right(root = @root)
    temp_root = root.link_left
    root.link_left = temp_root.link_right
    temp_root.link_right = root
    temp_root
  end

  def rotate_left_right(root = @root)
    root.link_left = rotate_left(root.link_left)
    return rotate_right(root)
  end

  def rotate_right_left(root = @root)
    root.link_right = rotate_right(root.link_right)
    return rotate_left(root)
  end

  def inorder_traversal(root = @root, container = []) #depth first strategy
    return if root == nil
    inorder_traversal(root.link_left, container)
    container << root.value
    inorder_traversal(root.link_right, container)
    container
  end

  def level_traversal(root = @root) #breadth first strategy
    return nil if root == nil
    container = Array.new()
    queue = Array.new() #store addresses of nodes in queue
    queue.push(root)
    until queue.empty?
      temp_node = queue.shift()
      container << temp_node.value
      queue.push(temp_node.link_left) if temp_node.link_left != nil
      queue.push(temp_node.link_right) if temp_node.link_right != nil
    end
    container
  end

  def min_value(root = @root)
    return nil if root == nil
    return root.value if root.link_left == nil
    min_value(root.link_left)
  end

  def max_value(root = @root)
    return nil if root == nil
    return root.value if root.link_right == nil
    max_value(root.link_right)
  end

  def delete(value, root = @root)
    if root == nil
      return root
    elsif value < root.value
      root.link_left = delete(value, root.link_left)
    elsif value > root.value
      root.link_right = delete(value, root.link_right)
    else #value == root.value -> now we can delete that node
      #Case 1: current node is leaf
      if root.link_left == nil && root.link_right == nil
        root = nil
      #Case 2: current node has 1 child
      elsif root.link_left == nil
        root = root.link_right
      elsif root.link_right == nil
        root = root.link_right
      #Case 3: current node has both children
      else #root.link_left != nil && root.link_right != nil
        #first find min value in right side or max value in left side
        temp_node = min_value(root.link_right)
        #change value of current node with temp_node value
        root.value = temp_node
        #call recursivly delete method with changed value
        root.link_right = delete(root.value, root.link_right)
        #note-if choosing max value in left child, next step is 
        #root.link_left = delete(root.value, root.link_left)
      end
    end

    if root == nil
      return root
    else
      return balance(root)
    end
  end

  def print_tree(root = @root, indent = '')
    return nil if root == nil
    puts indent + root.value.to_s + "|"
    print_tree(root.link_left, indent += "\s\s|")
    print_tree(root.link_right, indent)
  end

end

avl = AvlTree.new()
avl.insert(100)
avl.insert(95)
avl.insert(90)
avl.insert(85)
avl.insert(80)
avl.insert(75)
avl.insert(70)
avl.insert(65)
avl.insert(60)
avl.delete(70)
avl.insert(55)
avl.insert(50)
avl.insert(45)
avl.delete(80)
avl.insert(40)
avl.insert(35)
avl.insert(30)
avl.delete(100)
avl.insert(25)
avl.insert(20)
avl.insert(15)
avl.delete(65)
avl.insert(10)
avl.insert(5)
avl.insert(1)
avl.insert(17)
avl.insert(28)
avl.insert(39)
avl.insert(66)
avl.insert(88)
#puts avl.inorder_traversal().join(' ')
#puts avl.level_traversal().join(' ')
#p avl.min_value()
#p avl.max_value()
#p avl.root
avl.print_tree()


=begin
def balance(root = @root)
    get_height = height(root)

    if get_height > 1
      if root.link_left
        if root.link_left.link_right
          return puts "left right"
        end
        return puts 'left left'
      elsif root.link_right
        if root.link_right.link_left
          return puts "right left"
        end
        return puts 'right right'
      end
    end
  end
=end