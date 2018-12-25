class AvlTree
  #AVL is self balancing BST tree, named after its creators Adelson-Velskii and Landis.
  #Height diff between the left and right subtrees(the balance factor) is always in the
  #range (-1..1) giving us O(log2n) lookups.
  class Node 
    #node is helper class for representing element in the tree
    attr_accessor :value, :link_left, :link_right
    def initialize(value)
      @value = value
      @link_left = nil
      @link_right = nil
    end
  end
  #create empty tree, root is address to the first root element of the tree
  attr_accessor :root
  def initialize()
    @root = nil
  end
  #*** Utility methods ***
  def print_tree(root = @root, indent = "")
    return root if root == nil
    puts indent + "|" +root.value.to_s 
    print_tree(root.link_left, indent += "\s" * 4)
    print_tree(root.link_right, indent)
  end

  def find_min(root = @root) #return lowest value in tree
    return root if root == nil
    return root.value if root.link_left == nil
    find_min(root.link_left)
  end

  def find_max(root = @root) #return highest value in tree
    return root if root == nil
    return root.value if root.link_right == nil
    find_max(root.link_right)
  end

  def height(root = @root) #return height of current node
    return -1 if root == nil
    left = height(root.link_left)
    right = height(root.link_right)
    return [left, right].max + 1
  end

  def child_height(root) #return CHILD height of the current node
    return 0 if root == nil
    left = child_height(root.link_left)
    right = child_height(root.link_right)
    return [left, right].max + 1
  end
  # *** Balancing methods ***
  def balance(root)
    #to balance tree, keep track of blance factor of each node,
    #if BF is in range (-1..1) subtree is balanced
    balance_factor = child_height(root.link_left) - child_height(root.link_right)
    #if BF is greater then 1 subtree is left heavy
    if balance_factor == 2
      #first check height of grandchild, for possible double rotation
      if child_height(root.link_left.link_right) > child_height(root.link_left.link_left)
        #nodes are set root root->left->right, needs double rotation => left then right
        return rotate_left_right(root)
      end
      #nodes are set root->left->left, need single right rotation
      return rotate_right(root)
    #if BF is lesser then -1 subtree is right heavy
    elsif balance_factor == -2
      #first check height of grandchild, for possible double rotation
      if child_height(root.link_right.link_left) > child_height(root.link_right.link_right)
        #nodes are set root root->right->left, needs double rotation => right then left
        return rotate_right_left(root)
      end
      #nodes are set root->right->right, need single left rotation
      return rotate_left(root)
    end
    root 
  end

  def balance_2(root) #diffrent approch to balancing
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
  #rotations methods for balancing tree(4 scenarios)
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
  # *** Insert and delete element in / from tree ***
  def insert_node_with_balancing(value, root)
    if root == nil
      root = Node.new(value)
    elsif value < root.value
      root.link_left = insert_node_with_balancing(value, root.link_left)
    elsif value > root.value
      root.link_right = insert_node_with_balancing(value, root.link_right)
    else #value == root.value
      root.value == value
    end
    #after finding place in tree, check if tree is unbalnced and balance it 
    balance(root) 
  end

  def insert(value)
    @root = insert_node_with_balancing(value, @root)
  end

  def delete(value, root = @root)
    if root == nil
      return root
    elsif value < root.value
      root.link_left = delete(value, root.link_left)
    elsif value > root.value
      root.link_right = delete(value, root.link_right)
    else #value == root.value => FOUND metching value and ready for deleting
      if root.link_left == nil && root.link_right == nil #node is leaf
        root = nil
      elsif root.link_left == nil #node has 1 child
        root = root.link_right
      elsif root.link_right == nil 
        root = root.link_left
      elsif root.link_left != nil && root.link_right != nil #node has both children
        temp_node = find_min(root.link_right)
        root.value = temp_node.value
        root.link_right = delete_2(root.value, link_right)
      end
    end
    #after deleting element from tree, check if tree is unbalnced and balance it 
    (root == nil) ? root : balance(root)
  end
  #Searching
  def contains?(value, root = @root)
    return false if root == nil
    if value == root.value
      return true
    elsif value < root.value
      contains?(value, root.link_left)
    else
      contains?(value, root.link_right)
    end
  end

  def search(value, root = @root)
    return nil if root == nil
    if value == root.value
      return root
    elsif value < root.value
      search(value, root.link_left)
    else 
      search(value, root.link_right)
    end
  end
  #Traversing
  def level_order(root = @root) #breadth first strategy
    return root if root == nil
    container = Array.new()
    queue = Array.new()
    queue.push(root)
    until queue.empty?
      temp_node = queue.shift()
      container.push(temp_node.value)
      queue.push(temp_node.link_left) if temp_node.link_left != nil
      queue.push(temp_node.link_right) if temp_node.link_right != nil
    end
    container
  end
  #depth first strategys
  def preorder(root = @root, container = []) #breadth first strategy
    return root if root == nil
    container << root.value
    preorder(root.link_left, container)
    preorder(root.link_right, container)
    container
  end
  
  def inorder(root = @root, container = []) #breadth first strategy
    return root if root == nil
    inorder(root.link_left, container)
    container << root.value
    inorder(root.link_right, container)
    container
  end

  def postorder(root = @root, container = []) #breadth first strategy
    return root if root == nil
    postorder(root.link_left, container)
    postorder(root.link_right, container)
    container << root.value
    container
  end
  # *** Is tree BST and successor of current node ***
  def is_bst?(root = @root, min_value = - Float::INFINITY, max_value = Float::INFINITY)
    return true if root == nil
    if root.value > min_value &&
        root.value < max_value &&
          is_bst?(root.link_left, min_value, root.value) &&
            is_bst?(root.link_right, root.value, max_value)
      return true
    else
      return false
    end
  end

  def successor(value, root = @root)
    return root if root == nil
    target_pointer = search(value)
    if target_pointer.link_right != nil
      #if node has right child, lowest value in right subtree is successor(most left)
      return find_min(target_pointer.link_right)
    else
      successor = nil
      ancestor = root
      until target_pointer == ancestor
        if ancestor.value > target_pointer.value
          successor = ancestor.value
          ancestor = ancestor.link_left
        else
          ancestor = ancestor.link_right
        end
      end
      return successor
    end
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
puts "Tree min-value: #{avl.find_min()}, max_value: #{avl.find_max()}."
puts avl.level_order().join(' ')
puts avl.preorder().join(' ')
puts avl.inorder().join(' ')
puts avl.postorder().join(' ')

puts avl.successor(75)