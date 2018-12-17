def make_tree_root(root)
  [root,[],[]]
end

def add_left(root, value)
  if root[1].empty?
    root[1] = [value,[],[]]
  else
    puts "left child not empty, move down the tree"
  end
  root
end

def add_right(root, value)
  if root[2].empty?
    root[2] = [value,[],[]]
  else
    puts "right child not empty, move down the tree"
  end
  root
end

def get_left(root)
  root[1]
end

def get_right(root)
  root[2]
end
#root lv 0
x = make_tree_root('A')
#lv 1
add_left(x, 'B')
add_right(x, 'C')
#lv 2
add_left(get_left(x), 'D')
add_right(get_left(x), 'E')
add_left(get_right(x), 'F')
add_right(get_right(x), 'G')
#lv 3
add_left(get_left(get_left(x)),'H')
add_right(get_left(get_left(x)),'I')
add_left(get_right(get_left(x)),'J')
add_right(get_right(get_left(x)),'K')
add_left(get_left(get_right(x)),'L')
add_right(get_left(get_right(x)),'M')
add_left(get_right(get_right(x)),'N')
add_right(get_right(get_right(x)),'O')
#lv 4
add_left(get_left(get_left(get_left(x))),'1')
add_right(get_left(get_left(get_left(x))),'2')
add_left(get_right(get_left(get_left(x))),'3')
add_right(get_right(get_left(get_left(x))),'4')
add_left(get_left(get_right(get_left(x))),'5')
add_right(get_left(get_right(get_left(x))),'6')
add_left(get_right(get_right(get_left(x))),'7')
add_right(get_right(get_right(get_left(x))),'8')
add_left(get_left(get_left(get_right(x))),'9')
add_right(get_left(get_left(get_right(x))),'10')
add_left(get_right(get_left(get_right(x))),'11')
add_right(get_right(get_left(get_right(x))),'12')
add_left(get_left(get_right(get_right(x))),'13')
add_right(get_left(get_right(get_right(x))),'14')
add_left(get_right(get_right(get_right(x))),'15')
add_right(get_right(get_right(get_right(x))),'16')
#test structure
my_tree = ['A', #root lv 0
  ['B', # lv 1
    ['D', #lv 2
      ['H', #lv 3
        ['1',[],[]], #lv 4
        ['2',[],[]]], #lv 4
      ['I', #lv 3
        ['3',[],[]], #lv 4
        ['4',[],[]]]], #lv 4
    ['E', #lv 2
      ['J', #lv 3
        ['5',[],[]], #lv 4
        ['6',[],[]]], #lv 4
      ['K', #lv 3
        ['7',[],[]], #lv 4
        ['8',[],[]]]]], #lv 4
  ['C', #lv 1
    ['F', #lv 2
      ['L', #lv 3
        ['9',[],[]], #lv 4
        ['10',[],[]]], #lv 4
      ['M', #lv 3
        ['11',[],[]], #lv 4
        ['12',[],[]]]], #lv 4
    ['G', #lv 2
      ['N', #lv 3
        ['13',[],[]], #lv 4
        ['14',[],[]]], #lv 4
      ['O', #lv 3
        ['15',[],[]], #lv 4
        ['16',[],[]]]]] #lv 4
]

puts (my_tree == x) ? "TEST PASSED" : "TEST FAILED"

