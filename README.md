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

1. git clone 
2. 引数として単語ファイルを指定し実行

```
# 1
$ git clone https://github.com/tekun43/fukushuu.git

# 2
$ ./fukushu.rb JLPT/N2.csv
```

単語のマスタファイルはcsvなので自由に単語ファイルを作成できます！  
単語のマスタファイルの例：  

`日本語`,`ひらがな`,`英語`  


```
楽しい,たのしい,Fun
日本語,にほんご,Japanese
パーティー,ぱーてぃー,Party
```

日本語能力試験の単語ファイルは、[ここ]で見つけました！（ありがとうｗ）

[in this repo]: https://github.com/tfreedman/JLPT-Flashcards
[ここ]: https://github.com/tfreedman/JLPT-Flashcards


