#!/usr/bin/ruby

def load_vocab_from_file(path)
	begin
		raw_contents = File.read(path).split("\n")
	rescue
		puts('no file found')
		return nil
	end
	# generate a 'word' hash for each line
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
		puts('enter vocab file')
		return
	end
	vocab = load_vocab_from_file(path)
	if vocab == [] then
		print('failed to load any vocab')
	end
	# lets to some practise!
end
	
main()

