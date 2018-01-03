#!/usr/bin/ruby

def flash_card_question(set1, set2)
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
			return true
		end
	rescue
		# user entered something silly
	end
	puts(words[answer])
	return false
end

def text_entry_question(set1, set2)
	word_idx = rand(0..set1.length-1)
	puts(set1[word_idx] + " -->")
	user_answer = $stdin.gets.chomp

	if user_answer == set2[word_idx] then
		return true
	end
	puts(set2[word_idx])
	return false
end

def do_test(set1, set2, reps, flash)
	correct = 0
	(0..reps-1).each do |q_id|
		if q_id > 0 then
			puts("Current:" + correct.to_s + "/" + q_id.to_s)
		end
		if flash then
			resp = flash_card_question(set1, set2)
		else
			resp = text_entry_question(set1, set2)
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
	# menu
	type = ""
	while ((1..8).map { |x| x.to_s } + ["q"]).include?(type) == false do
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
		puts("\n")
		type = $stdin.gets.chomp
	end

	if type == "q" then
		return
	end


	reps = 0
	while reps == 0 do
		puts("How Many Tests?")
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
		do_test(set1, set2, reps, false)
	else
		do_test(set1, set2, reps, true)
	end
end

main()

