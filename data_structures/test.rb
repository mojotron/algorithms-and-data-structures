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

  def print_tree(root = @root, indent = "")
    return nil if root == nil
    puts indent + root.value.to_s + "|"
    print_tree(root.link_left, indent += "\s\s|")
    print_tree(root.link_right, indent)
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

  def insert_node_with_balance(value, root)
    if root == nil
      root = Node.new(value)
    elsif value < root.value
      root.link_left = insert_node_with_balance(value, root.link_left)
    elsif value > root.value
      root.link_right = insert_node_with_balance(value, root.link_right)
    else #value == root.value
      root.value == value
    end
    balance(root)
  end

  def insert(value)
    @root = insert_node_with_balance(value, @root)
  end
  #balancing elements
  def height(root = @root)
    return -1 if root == nil
    left = height(root.link_left)
    right = height(root.link_right)
    return [left, right].max + 1
  end

  def child_height(root = @root) #helper method for balance method
    return 0 if root == nil
    left = child_height(root.link_left)
    right = child_height(root.link_right)
    return [left, right].max + 1
  end

  def balance(root = @root)
    #get balance factors of left and right child
    left_bf = child_height(root.link_left)
    right_bf = child_height(root.link_right)

    if left_bf - right_bf == 2
      if child_height(root.link_left.link_right) > child_height(root.link_left.link_left)
        #nodes are set root root->left->right, needs double rotation => left then right
        return rotate_left_right(root)
      end
      #nodes are set root->left->left, need single right rotation
      return rotate_right(root)
    elsif left_bf - right_bf == -2
      if child_height(root.link_right.link_left) > child_height(root.link_right.link_right)
        #nodes are set root root->right->left, needs double rotation => right then left
        return rotate_right_left(root)
      end
      #nodes are set root->right->right, need single left rotation
      return rotate_left(root)
    end
    root
  end

  def balance2(root)
    balance_factor = child_height(root.link_left) - child_height(root.link_right)
    if balance_factor == 2
      if root.link_left.link_left
        return rotate_right(root)
      elsif root.link_left.link_right
        return rotate_left_right(root)
      end
    elsif balance_factor == -2
      if root.link_right.link_right
        return rotate_right_left(root)
      elsif root.link_right.link_left
        return rotate_left(root)
      end
    end
    root
  end

  def rotate_left(root)
    temp_node = root.link_right
    root.link_right = temp_node.link_left
    temp_node.link_left = root
    temp_node
  end

  def rotate_right(root)
    temp_node = root.link_left
    root.link_left = temp_node.link_right
    temp_node.link_right = root
    temp_node
  end

  def rotate_left_right(root)
    root.link_left = rotate_left(root.link_left)
    rotate_right(root)
  end

  def rotate_right_left(root)
    root.link_right = rotate_right(root.link_right)
    rotate_left(root)
  end

  def delete(value, root = @root)
    if root == nil
      return root
    elsif value < root.value
      root.link_left = delete(value, root.link_left)
    elsif value > root.value
      root.link_right = delete(value, root.link_right)
    else #value == root.value
      if root.link_left == nil && root.link_right == nil
        root = nil
      elsif root.link_left == nil
        root = root.link_right
      elsif root.link_right == nil
        root = root.link_left
      elsif root.link_left != nil && root.link_right != nil
        temp_node = min_value(root.link_right)
        root.value = temp_node.value
        root.link_right = delete(root.value, root.link_right)
      end
    end
    (root == nil) ? root : balance(root)
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
avl.print_tree()
puts "Tree max value is: #{avl.max_value()}, and min value: #{avl.min_value()}"

