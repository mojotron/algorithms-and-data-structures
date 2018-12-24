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
end

avl = AvlTree.new()
avl.insert('A')
avl.insert('B')
avl.insert('C')
avl.insert('D')
avl.insert('E')
avl.insert('F')
avl.insert('G')
avl.insert('H')
avl.insert('I')
avl.insert('J')
avl.insert('K')
avl.insert('L')
avl.insert('M')
avl.insert('N')
avl.balance2()
puts avl.level_traversal().join(' ')
puts avl.inorder_traversal().join(' ')
p avl.root


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