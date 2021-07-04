descriptions = [
  "C#エンジニア。Railsを独学してWebアプリを作成。セキュリティとデータベースの国家資格を保有。",
  "2019年8月エンジニアとして働いています。美大出身なので、担当領域は主にUI・UX。Qiitaには主に学習したことのノートとまとめを発信しています。",
  "プログラミングコミュニティでRailsやWeb開発のメンターをしていました。",
  "2017年からサーバサイドLaravel、フロントVue.jsの開発に従事しています。",
  "サイトを利用し、独学でUIデザインをしています。(時々グラフィックなども)未経験ですがUIデザインやWebデザインの方面での就職を検討中です。",
  "現在は地方公務員として働いており、未経験からのエンジニア転職を目指して勉強中です。",
  "普段受託でアプリ開発などを行っています。",
  "インフラもバックエンドもフロントエンドも書いています。 普段書いているのはPHP(Laravel)、JavaScript(Vue.js)です。",
  "30歳未経験からウェブエンジニアへの転職を目指しています。",
  "スマートフォンゲームの企画、開発、運営を行っております。",
  "Webデザイン技能検定3級。現在プログラミング（JS,PHP,SQL）やAdobeでデザインを勉強中。",
  "WordPress開発・LPコーディングなどに関する情報発信をしていきます。"
]

tags=[
  ["C", "Java", "Vim", "Cobol"],
  ["HTML", "CSS", "PhotoShop", "Webデザイン"],
  ["Web開発", "AWS", "Node.js", "GraphQL"],
  ["Firebase", "github", "Vue.js", "Docker"],
  ["Progate", "Python", "Django", "React.js"],
  ["コードレビュー", "AWS", "データベース"],
  ["Ruby", "Rails", "MySQL", "Docker"],
  ["C++", "CakePHP", "PostgreSQL", "CircleCI"],
  ["Java", "SpringBoot", "MySQL", "JWT"],
  ["インフラ", "Terraform", "CloudWatch", "Lambda"],
  ["MySQL", "PHP", "Adobe"],
  ["WordPress", "Photoshop", "JavaScript"]
]

0.upto(11) do |idx|
  user = User.create(
    name: [Gimei.name.kanji, Gimei.hiragana, Gimei.last.romaji][idx % 3],
    email: "user#{idx}@example.com",
    description: descriptions[idx],
    password: "password#{idx}",
    password_confirmation: "password#{idx}",
    admin: false
  )
  user.save_tags(tags[idx])
end

user = User.create(
  name: "guestuser",
  email: "guestuser@example.com",
  description: "ゲストユーザー",
  password: "guestuser",
  password_confirmation: "guestuser",
  admin: false
)
user.save_tags(tags[3])

admin_user = User.create(
  name: "Ryuhei",
  email: "ryuhei@example.com",
  description: "ゲストユーザー",
  password: "kameshimaryuhei",
  password_confirmation: "kameshimaryuhei",
  admin: true
)
admin_user.save_tags(["Ruby", "Rails", "nuxt.js", "AWS", "CircleCI"])