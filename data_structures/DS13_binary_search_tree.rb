class BinarySearchTree
  #helper class Node - represents object(element) in the tree
  class Node
    #node has data container(value) and references for left and right chiled from current node
    attr_accessor :value, :link_left, :link_right
    def initialize(value)
      @value = value
      @link_left = nil
      @link_right = nil
    end
  end
  #tree instance is created with root(pointing to first element), which is nil until inserting first element
  attr_accessor :root
  def initialize()
    @root = nil
  end
  #insert element into tree using loop
  def insert_with_loop(value)
    new_node = Node.new(value)
    #if tree is empty root points to new element (node)
    if @root == nil 
      @root = new_node
      return
    end
    #if tree is not empty, traversal until method find appropriate place
    temp_node = @root
    while true 
      if value <= temp_node.value
        if temp_node.link_left == nil
          temp_node.link_left = new_node
          return
        else
          temp_node = temp_node.link_left
        end
      else #value > temp_node.value
        if temp_node.link_right == nil
          temp_node.link_right = new_node
          return
        else
          temp_node = temp_node.link_right
        end
      end
    end
  end
  #recursiv insert version 1
  def insert_node(value, root) 
    new_node = Node.new(value)
    if root == nil
      root = new_node
    elsif value <= root.value
      if root.link_left == nil
        root.link_left = new_node
      else
        insert_node(value, root.link_left)
      end
    else #value > root.value
      if root.link_right == nil
        root.link_right = new_node
      else
        insert_node(value, root.link_right)
      end
    end
    root
  end

  def insert(value) #insert node to instance of the tree
    @root = insert_node(value, @root)
  end
  #recursiv insert version 2
  def add_node(value, root)
    if root == nil
      root = Node.new(value)
    elsif value <= root.value
      root.link_left = add_node(value, root.link_left)
    else #value > root.value
      root.link_right = add_node(value, root.link_right)
    end
    root
  end

  def add(value)
    @root = add_node(value, @root)
  end
  #search for element into tree
  def contains?(value, root = @root)
    #NOTE if value are diff data type will throw error(if you searching for integer in tree of strings)
    return false if root == nil
    if root.value == value
      return true
    elsif value <= root.value
      contains?(value, root.link_left)
    else
      contains?(value, root.link_right)
    end
  end

  def search(value, root = @root)
    return nil if root == nil
    if value == root.value
      return root
    elsif value <= root.value
      search(value, root.link_left)
    else
      search(value, root.link_right)
    end
  end
  #find minimum and maximum value in the tree
  #minimmum value is in left most element in the tree, maximum value is in right most element
  def min_value_with_loop(root = @root)
    return nil if root == nil
    until root.link_left == nil
      root = root.link_left
    end
    root.value
  end

  def min_value(root = @root)
    return nil if root == nil
    return root.value if root.link_left == nil
    min_value(root.link_left)
  end

  def max_value_with_loop(root = @root)
    return nil if root == nil
    until root.link_right == nil
      root = root.link_right
    end
    root.value
  end

  def max_value(root = @root)
    return nil if root == nil
    return root.value if root.link_right == nil
    max_value(root.link_right)
  end
  #height of BST - number of edges from current node to leaf node(longest path)
  def height(root = @root)
    return -1 if root == nil
    left = height(root.link_left)
    right = height(root.link_right)
    return [left, right].max + 1
  end
  #BST traversal
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

  def preorder_traversal(root = @root, container = []) #depth first strategy
    return if root == nil
    container << root.value
    preorder_traversal(root.link_left, container)
    preorder_traversal(root.link_right, container)
    container
  end

  def inorder_traversal(root = @root, container = []) #depth first strategy
    return if root == nil
    inorder_traversal(root.link_left, container)
    container << root.value
    inorder_traversal(root.link_right, container)
    container
  end

  def postorder_traversal(root = @root, container = []) #depth first strategy
    return if root == nil
    postorder_traversal(root.link_left, container)
    postorder_traversal(root.link_right, container)
    container << root.value
    container
  end
  #checking if tree is BST
  #1.method is using helper method for checking are all nodes left from root lesser then current node.
  #Or are all nodes right from current greater then root node.
  def is_subtree_lesser?(value, root = @root)
    return true if root == nil
    if root.value <= value &&
        is_subtree_lesser?(value, root.link_left) &&
          is_subtree_lesser?(value, root.link_left) 
      return true
    else
      return false
    end
  end

  def is_subtree_greater?(value, root = @root)
    return true if root == nil
    if root.value > value &&
        is_subtree_greater?(value, root.link_left) &&
          is_subtree_greater?(value, root.link_right)
      return true
    else
      return false
    end
  end
  #O(n^2), costly approch
  def is_bst_1?(root = @root)
    return true if root == nil
    if is_subtree_lesser?(root.value, root.link_left) &&
        is_subtree_greater?(root.value, root.link_right) &&
          is_bst_1?(root.link_left) &&
            is_bst_1?(root.link_right)
      return true
    else
      return false
    end
  end
  #2.method, using ranges with infinity and - infinity
  def is_bst_2?(root = @root, min_value = "", max_value = "~~~~~") #O(n)
    #min_value = - Float::INFINITY, max_value = Float::INFINITY for integers
    return true if root == nil
    if root.value > min_value && 
        root.value < max_value &&
          is_bst_2?(root.link_left, min_value, root.value) &&
            is_bst_2?(root.link_right, root.value, max_value)
      return true
    else
      return false
    end
  end
  #3.method is using inorder traversal, inorder traversal returns sorted elements, if they are sorted
  #tree is BST
  def is_bst_3?(root = @root)
    return nil if root == nil
    node_list = inorder_traversal(root)
    (node_list == node_list.sort) ? true : false
  end
  #deleting node from the tree
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
    root
  end
  #find next grater value of input value
  def inorder_successor(value, root = @root)
    return nil if root == nil
    value_pointer = search(value)
    #Case 1: if node has right child, the most left element is successor
    if value_pointer.link_right != nil
      temp_node = value_pointer.link_right
      until temp_node.link_left == nil
        temp_node = temp_node.link_left
      end
      return temp_node
    else #Case 2: if node has no right child ancestor is successor
      successor = nil
      ancestor = root
      until ancestor == value_pointer
        if ancestor.value > value_pointer.value
          successor = ancestor
          ancestor = ancestor.link_left
        else
          #if anccestor atm doesn't have left child go right
          ancestor = ancestor.link_right
        end
      end
      return successor
    end
  end
end

bst = BinarySearchTree.new()
bst.add('F')
bst.add('D')
bst.add('J')
bst.add('B')
bst.add('E')
bst.add('G')
bst.add('K')
bst.add('A')
bst.add('C')
bst.add('I')
bst.add('H')

#bst.root.link_left.value = 'Z'
#p bts.search('D')
#p bts.max_value(bts.search('D'))
#p bst.height(bst.search('D'))
#puts bst.level_traversal().join(' ')
#puts bst.preorder_traversal().join(' ')
#puts bst.inorder_traversal().join(' ')
#puts bst.postorder_traversal().join(' ')
#p bst.is_bst_2?()
#puts bst.inorder_traversal().join(' ')
#bst.delete('F')
#puts bst.inorder_traversal().join(' ')
p bst.inorder_successor('H')
