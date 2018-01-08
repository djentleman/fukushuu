#!/usr/bin/ruby

def flash_card_question(set1, set2, language)
	# pick random word from set 1
	word_idxs = (0..set1.length-1).sort_by { rand }[0..5]
	words = word_idxs.map { |x| set2[x] }
	# randomly pick a number to be answer
	answer = rand(0..5)
	puts(set1[word_idxs[answer]] + " -->")
	puts(words.map{ |x| (words.index(x)+1).to_s + ". " + x }.join("  "))
	user_answer = $stdin.gets.chomp
	begin
		if user_answer.to_i-1 == answer then
			if language == "en" then
				puts("Correct")
			else
				puts("正解！")
			end
			return true
		end
	rescue
		# user entered something silly
	end
	if language == "en" then
		puts("Incorrect")
	else
		puts("間違った！")
	end
	puts(words[answer])
	return false
end

def text_entry_question(set1, set2, language)
	word_idx = rand(0..set1.length-1)
	puts(set1[word_idx] + " -->")
	user_answer = $stdin.gets.chomp

	if user_answer == set2[word_idx] then
		if language == "en" then
			puts("Correct")
		else
			puts("正解！")
		end
		return true
	end
	if language == "en" then
		puts("Incorrect")
	else
		puts("間違った！")
	end
	puts(set2[word_idx])
	return false
end

def do_test(set1, set2, reps, flash, language)
	correct = 0
	(0..reps-1).each do |q_id|
		if q_id > 0 then
			puts("Current:" + correct.to_s + "/" + q_id.to_s)
		end
		if flash then
			resp = flash_card_question(set1, set2, language)
		else
			resp = text_entry_question(set1, set2, language)
		end
		if resp then
			correct = correct + 1
		end
	end
	puts("Final:" + correct.to_s + "/" + reps.to_s)
end

def load_vocab_from_file(path)
	begin
		raw_contents = File.read(path).split("\n")
	rescue
		puts("no file found")
		return nil
	end
	# generate a "word" hash for each line
	vocab = []
	raw_contents.each do |line|
		begin
			cols = line.split(",")
			word_hash = {"japanese" => cols[0], "phonetic" => cols[1], "english" => cols[2]}
			vocab << word_hash
		rescue
			# couldnt parse column
		end
	end
	return vocab
end

def main_loop(vocab)
	# menu
	# set language
	
	language = ""
	while language != "en" and language != "ja" do
		puts("Choose Language")
		puts("言語を選んでください")
		puts("1: English/英語")
		puts("2: Japanese/日本語")
		language_id = $stdin.gets.chomp

		if language_id == "1" then
			language = "en"
		elsif language_id == "2" then
			language = "ja"
		end
	end


	while true do
		type = ""
		while ((1..8).map { |x| x.to_s } + ["q"]).include?(type) == false do
			if language == "en" then
				puts("Pick Practise Type")
				puts("1: English -> Japanese (Multi Choice)")
				puts("2: English -> Japanese (Text Entry)")
				puts("3: Japanese -> English (Multi Choice)")
				puts("4: Japanese -> English (Text Entry)")
				puts("5: Japanese -> Phonetic (Multi Choice)")
				puts("6: Japanese -> Phonetic  (Text Entry)")
				puts("7: Phonetic -> Japanese (Multi Choice)")
				puts("8: Phonetic -> Japanese (Text Entry)")
				puts("q: Quit")
			elsif language == "ja" then
				puts("練習タイプを選んでください")
				puts("1: 英語 -> 日本語 (六つ答えから選ぶ)")
				puts("2: 英語 -> 日本語 (自由に答えを入力)")
				puts("3: 日本語 -> 英語 (六つ答えから選ぶ)")
				puts("4: 日本語 -> 英語 (自由に答えを入力)")
				puts("5: 日本語 -> ひらがな (六つ答えから選ぶ)")
				puts("6: 日本語 -> ひらがな  (自由に答えを入力)")
				puts("7: ひらがな -> 日本語 (六つ答えから選ぶ)")
				puts("8: ひらがな -> 日本語 (自由に答えを入力)")
				puts("q: 閉じる")
			end
			type = $stdin.gets.chomp
		end

		if type == "q" then
			return
		end


		reps = 0
		while reps == 0 do
			if language == "en" then
				puts("How Many Tests?")
			elsif language == "ja" then
				puts("問題数を入力してください")
			end
			reps = $stdin.gets.chomp.to_i
		end

		# get sets
		if type == "1" or type == "2" then
			set1 = vocab.map { |x| x['english'] }
			set2 = vocab.map { |x| x['japanese'] }
		end
		if type == "3" or type == "4" then
			set2 = vocab.map { |x| x['japanese'] }
			set1 = vocab.map { |x| x['english'] }
		end
		if type == "5" or type == "6" then
			set1 = vocab.map { |x| x['japanese'] }
			set2 = vocab.map { |x| x['phonetic'] }
		end
		if type == "7" or type == "8" then
			set2 = vocab.map { |x| x['phonetic'] }
			set1 = vocab.map { |x| x['japanese'] }
		end

		if type.to_i % 2 == 0 then
			# text entry test
			do_test(set1, set2, reps, false, language)
		else
			do_test(set1, set2, reps, true, language)
		end
	end
end



def main()
	path = ARGV[0]
	if path == nil then
		puts("enter vocab file")
		return
	end
	vocab = load_vocab_from_file(path)
	if vocab == [] or vocab == nil then
		puts("failed to load any vocab")
		return
	end
	main_loop(vocab)
end

main()

