# user0の投稿
#contents = [
#  {
#    title: "deviseの使い方",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#  {
#    title: "",
#    rate: rand(3.0, 5.0),
#    content: ""
#  },
#]
1.upto(10) do |idx|
  user = User.find_by(id: idx)
#  Post.create(
#    user: user,
#    title: 
#  )
end