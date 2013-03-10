# IO::AccessLazy  [![Build Status](https://travis-ci.org/zonuexe/ruby-io-access_lazy.png?branch=develop)](https://travis-ci.org/zonuexe/ruby-io-access_lazy) [![Code Climate](https://codeclimate.com/github/zonuexe/ruby-io-access_lazy.png)](https://codeclimate.com/github/zonuexe/ruby-io-access_lazy)

 * <del>さいふおとした。<strong>泣いてる</strong>。</del>
 * <ins>回収された<del>らしい</del>。世の中捨てたもんじゃない ヾ(〃＞＜)ﾉﾞ☆</ins>

## Installation

Add this line to your application's Gemfile:

    gem 'io-access_lazy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install io-access_lazy

## 日本語でおｋ (Japanese)

 * IOオブジェクトから任意の行を遅延して取得します
 * シェルスクリプティングだと `head(1)` とか `tail(1)` を使ってやるイメージです
   * *タブンネ*

## Usage

```ruby
fp = open("hoge.txt", 'r')
fp.read
# => "A
# B
# C
# D
# E
# F
# G
# H"
fp_lazy = IO::AccessLazy.new(fp)
line5 = fp_lazy[5]
# => "F"
line2_6 = fp_lazy[2..4]
# => ["C\n", "D\n", "E\n"]
line3_l = fp_lazy[3..-1]
# => ["D\n", "E\n", "F\n", "G\n", "H\n"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
