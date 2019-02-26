class DisjoinSet
  attr_accessor :parents
  def initialize(vertices)
    @parents = {}
    vertices.each_with_index do |vertex, id|
      @parents[vertex] = id
    end
  end

  def find(vertex)
    @parents[vertex]
  end

  def union(a, b)
    return puts 'cycle found' if @parents[a] == @parents[b]
    @parents[b] = find(a)
  end
end

vertices = ('A'..'E').to_a

x = DisjoinSet.new(vertices)
x.union('A','B')
x.union('A','D')
x.union('D','E')
x.union('B','C')
x.union('A','F')
x.union('E','F')
p x.parents


