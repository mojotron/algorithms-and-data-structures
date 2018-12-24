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

  def inorder_traversal(root = @root, container = [])
    return if root == nil
    inorder_traversal(root.left, container)
    container << root.value
    inorder_traversal(root.right, container)
    container
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
    if root.value < value &&
        is_subtree_lesser?(value, root.left) &&
          is_subtree_lesser?(value, root.right)
      return true
    else
      return false
    end
  end

  def is_subtree_greater?(value, root = @root)
    return true if root == nil
    if root.value > value &&
        is_subtree_greater?(value, root.left) &&
          is_subtree_greater?(value, root.right)
      return true
    else
      return false
    end
  end

  def is_bts?(root = @root) #O(n^2)
    return true if root == nil
    if is_subtree_lesser?(root.value, root.left) &&
        is_subtree_greater?(root.value, root.right) &&
          is_bts?(root.left) && 
            is_bts?(root.right)
      return true
    else
      return false
    end
  end

  def is_bts2?(root = @root, min_value = '', max_value = '~~~~') #O(n)
    return true if root == nil
    if root.value > min_value && root.value < max_value &&
        is_bts2?(root.left, min_value, root.value) &&
          is_bts2?(root.right, root.value, max_value)
      return true
    else
      return false
    end

  end

  def is_bts3?(root = @root)
    list = inorder_traversal(root)
    (list == list.sort) ? true : false
  end

  def delete(value, root = @root)
    if root == nil
      return nil
    elsif value < root.value
      root.left = delete(value, root.left)
    elsif value > root.value 
      root.right = delete(value, root.right)
    else #value == root.value
      if root.left == nil && root.right == nil
        root = nil
      elsif root.left == nil
        root = root.right
      elsif root.right == nil
        root = root.left
      elsif root.left != nil && root.right != nil
        temp_value = find_min_recursion(root.right)
        root.value = temp_value
        root.right = delete(temp_value, root.right)
      end
    end
    root
  end

  def search(value, root = @root)
    if root == nil
      return nil
    elsif value < root.value
      search(value, root.left)
    elsif value > root.value
      search(value, root.right)
    elsif root.value == value
      return root
    end
  end

  def inorder_successor(value, root = @root)
    current = search(value, root)
    if current == nil
      return nil
    end
    if current.right != nil
      #1 case has right subtree
      temp_node = current.right
      until temp_node.left == nil
        temp_node = temp_node.left
      end
      return temp_node
      #or return find_min(current.right)
    else
      #case 2 no right subtree
      #walk the tree from root till current node, find deepest ancestor which
      #current node will be in lest ST
      successor = nil
      ancestor = root
      until ancestor == current
        if current.value < ancestor.value
          successor = ancestor #so far deepest node for which current node is in left
          ancestor = ancestor.left
        else
          ancestor = ancestor.right
        end
      end
      return successor
    end
  end

  #AVL implementation
  def child_height(root) #method for counting edges from child of current node (returns 0 insted -1)
    return 0 if root == nil
    left = child_height(root.left_child)
    right = child_height(root.right_child)
    return [left, right].max + 1
  end

  def balance_tree(node)
    left = child_height(node.left_child) 
    right = child_height(node.right_child)
    if left - right == 2
      if child_height(left.right_child) > child_height(left.left_child)
        return rotate_left_right(node.left)
      end
      return rotate_right(node)
    elsif right - left == 2
      if child_height(right.right_child) > child_height(right.left_child)
        return rotate_right_left(node.right)
      end
      return rotate_left(node)
    end
    node
  end

  def rotate_left(root)
    temp_root = root.right_child
    root.right_child = temp_root.left_child
    temp_root.left_child = root
    return temp_root
  end

  def rotate_right(root)
    temp_root = root.left_child
    root.left_child = temp_root.right_child
    temp_root.right_child = root
    return temp_root
  end

  def rotate_left_right(root)
    root.left_child = rotate_left(root.left_child)
    rotate_right(root)
  end

  def rotate_right_left(root)
    root.right_child = rotate_right(root.right_child)
    rotate_left(root)
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
p x.inorder_traversal().join(' ')
p x.inorder_successor('H')


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
