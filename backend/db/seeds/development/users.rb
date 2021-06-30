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
  "スマートフォンゲームの企画、開発、運営を行っております。"
]

0.upto(9) do |idx|
  User.create(
    name: [Gimei.name.kanji, Gimei.hiragana, Gimei.last.romaji][idx % 3],
    email: "user#{idx}@example.com",
    description: descriptions[idx],
    password: "password#{idx}",
    password_confirmation: "password#{idx}",
    admin: false
  )
end

User.create(
  name: "guestuser",
  email: "guestuser@example.com",
  description: "",
  password: "guestuser",
  password_confirmation: "guestuser",
  admin: false
)