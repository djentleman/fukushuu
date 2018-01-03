# 復習 (Fukushu)

-----

## Command Line Tool for building Japanese Vocab

### How to use

To use it, just clone the repo and run `fukushu.rb` with a vocab file as an argument - for example

`./fukushu.rb JLPT/N2.csv`

Its possible to build your own vocab files - they are just `.csv` files made up of 3 columns: `Japanese`, `Phonetic` and `English`. `Japanese` and `English` are fairly self explanitory - `Phonetic` is just the japanese word but in hiragana - for instance:

```
楽しい,たのしい,Fun
日本語,にほんご,Japanese
パーティー,ぱーてぃー,Party
```

The program comes with a load of JLPT vocab I parsed from the XML files [in this repo]. (thanks man :))


## 日本語の単語練習のためのコマンドラインツール

### 使い方

使い方は、このレポジトリをクローンして、引数として単語のファイルで、`fukushu.rb`というファイルを実行します。例えば：

`./fukushu.rb JLPT/N2.csv`

単語のファイルはCSVだけ、だから自分の単語ファイルを作成できます！単語ファイルが三つの列があります。`日本語`,と`ひらがな`と`英語`。
例のファイル：


```
楽しい,たのしい,Fun
日本語,にほんご,Japanese
パーティー,ぱーてぃー,Party
```

日本語能力試験の単語ファイルはもうこのリポジトルにあります。[そこ]で見つけました！（ありがとうｗ）

[in this repo]: https://github.com/tfreedman/JLPT-Flashcards
[そこ]: https://github.com/tfreedman/JLPT-Flashcards

