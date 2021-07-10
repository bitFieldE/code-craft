# user0の投稿
contents = [
  {
    title: "RailsでMarkdownのテキストをHTMLに変換する",
    rate: 5.0,
    content: "# gem 読み込み\n<br>\nGemfile に以下を追記し、bundle install します。\n\n```ruby\ngem 'redcarpet'\ngem 'rouge'\n```\n\n<br>\n\n# ヘルパー作成\n<br>\napp/helpers/ に markdown_helper.rb を作成します。\n<br>\n\n```ruby\nmodule MarkdownHelper\n  def markdown(text)\n    options = {\n      hard_wrap:       true,\n      space_after_headers: true,\n    }\n\n    extensions = {\n      autolink:           true,\n      no_intra_emphasis:  true,\n      fenced_code_blocks: true,\n    }\n\n    unless @markdown\n      renderer = Redcarpet::Render::HTML.new(options)\n      @markdown = Redcarpet::Markdown.new(renderer, extensions)\n    end\n\n    @markdown.render(text).html_safe\n  end\nend              \n```\n<br>\n\nviewでは以下の記述をすれば表示されます。\n\n```html\n<%= markdown(@post.content) %>\n```\n            "
    tags: ['HTML', 'Markdown']
  },
  {
    title: "Nuxt.js使ってみた",
    rate: 5.0,
    content: "# vue-cliをインストール\n\n<br>\n\n```shell\nnpm install -g vue-cli\n```\n\n<br>\n\n# プロジェクトの作成\n<br>\n\n```\nvue init nuxt-community/starter-template sample\n```\n\n<br>\n\n```\n? Project name sample\n? Project description Nuxt.js project\n? Author [UserName]\n```\n<br>\n必要なライブラリをインストールします。\n<br>\n\n```\ncd sample\nnpm install\n```\n\n<br>\n開発サーバーを起動。\n<br>\n\n```\nnpm run dev\n```\n\n<br>\nlocalhost:3000でNuxtのサンプルアプリが起動します。\n<br>\n\n```shell\n> sample@1.0.0 dev /Users/takeshi/projects/sample/sample\n> nuxt\n\n  nuxt:build App root: /Users/takeshi/projects/sample/sample +0ms\n  nuxt:build Generating /Users/takeshi/projects/sample/sample/.nuxt files... +1ms\n  nuxt:build Generating files... +49ms\n  nuxt:build Generating routes... +7ms\n  nuxt:build Building files... +21ms\n  nuxt:build Adding webpack middleware... +110ms\nBuild completed in 6.958s\n\n\n\n DONE  Compiled successfully in 6963ms                                                                        21:33:18\n\n\n OPEN  http://localhost:3000\n```\n"
    tags: ['Nuxt.js', 'Vue']
  },
  {
    title: "axiosを取り入れてみた",
    rate: 4.0,
    content: "Nuxt.jsでaxiosを導入するには@nuxtjs/axiosパッケージを追加します。\n<br>\n```bash\nnpm install --save @nuxtjs/axios\n```\n<br>\n@nuxtjs/axiosが有効になるように nuxt.config.jsの修正をする。\n\n```js\nmodule.exports = {\n\t・\n\t・\n\t・\n   /*\n   ** Nuxt.js modules\n   */\n\tmodules: \n\t[\n      \"@nuxtjs/axios\",\n\t],\n\t・\n\t・\n\t・\n};\n```\n\n<br>\n\npage/index.vue ファイルのscriptタグに下記を記載\n\n<br>\n\n```js\n<script>\n\texport default {\n\t\tasync asyncData({ $axios }) {\n\t\t\t// 取得先のURL\n\t\t\tconst url = \"https://qiita.com/api/v2/items\";\n\t\t\t// リクエスト（Get）\n\t\t\tconst response = await $axios.$get(url);\n\t\t\t// 配列で返ってくるのでJSONにして返却\n\t\t\treturn {\n\t\t\t\tposts: response\n\t\t\t};\n\t\t}\n\t};\n</script>\n```\n<br>\n\nQiitaのAPIにリクエストするようにしているので、\nそのまま実行すると、JSON形式でタイトルやURLが返却される。\n\n<br>\n\n```js\n<template>\n\t<div>\n\t\t<ul>\n\t\t \t<li v-for=\"(post, index) in posts\" :key=\"index\">\n\t\t \t\t<a :href=\"'post.url'\" target=\"_blank\" rel=\"noopener noreferrer\">{{ post.title }}</a>\n\t\t\t</li>\n\t\t</ul>\n\t</div>\n</template>\n```\n",
  },
  {
    title: "MySQL/Dockerエラーの対処法",
    rate: 5.0,
    content: "**非常に助かりました**\n\n[【MySQL】Unknown MySQL server host 'db' (-2)の対処法【Docker】](https://qiita.com/SyoInoue/items/2ed5b3017c517920ec09)"
  },
  {
    title: "[Rails]投稿のいいね数のランキング",
    rate: 4.0,
    content: "モデルにアソシエーションを定義\n++post.rb++\n```ruby\nclass Post < ApplicationRecord\n    belongs_to :user\n    has_many :likes, dependent: :destroy\n    has_many :liked_users, through: :likes, source: :user\nend\n```\n\n++user.rb++\n```ruby\nclass User < ApplicationRecord\n  has_many :posts,dependent: :destroy\n  has_many :likes, dependent: :destroy\n  has_many :liked_posts, through: :likes, source: :post\nend\n```\n\n++like.rb++\n```ruby\nclass Like < ApplicationRecord\n  belongs_to :post\n  belongs_to :user\nend\n```\n\n++app/controller/posts_controller.rb++\n```ruby\ndef index\n  @posts = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}\nend\n```"
    tags: ['Rails', 'ランキング機能']
  },
  {
    title: "",
    rate: 3.5,
    content: ""
  }
]

1.upto(10) do |idx|
  user = User.find_by(id: idx)
  post = Post.create(
    user: user,
    title: contents[0][:title],
    rate: contents[0][:rate],
    content: contents[0][:content]
  )
  post.save_tags()
end