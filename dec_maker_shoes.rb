#loop through options and show each in new line
def show_options(options)
	options.collect do |opt|
		"#{opt} \n"
	end
end

#creates a list of light boxes one after another for the length of @options
def create_list_boxes(options, options_hash)
	if options_hash.length < options.length && options_hash[options[options_hash.length]].nil?
		@list_box = list_box :items => ["1", "2", "3"], width: 40
		para "#{options[options_hash.length]} \n"
	else 
		@right_sidebar.after(@list) {caption "your ratings:"}
		for k in options_hash 
			@right_sidebar.append {para "#{k}"[2..-8] + ": \t" + "#{k}"[-3..-3]}
		end 
		subm_ratings = button "submit rating" do
			rating_array = []
			for opt in options
				options_hash[opt].to_i.times {rating_array.push(opt)} 
			end
			suggestion = rating_array[rand(rating_array.length)]
			para("FSM calculated for you: strong(*#{suggestion}*)", em(" (rating: #{options_hash[suggestion]})"), stroke: white) 
		end
	end

	@list_box.change() do
		options_hash[options[options_hash.length]] = @list_box.text()
		create_list_boxes(options, options_hash)	
	end
end

#main app
Shoes.app title: "main" do

	background "#89B"
	
	flow do
		#stack on the top left: 
		@left = stack(margin: 13, width: 320, height: 300) do
			background "#CCD"
			stack(height: 102) do
				caption("Welcome :), ", stroke: white, font: "Trebuchet MS")
				para("we are going to make a list of things you want to do...", stroke: white)
			end

			@option
			@options = []
			@rand_options = []
			options_hash = Hash.new()

			@edit_line = flow(height: 53) do 
				@option = edit_line				
				@submit = button "ok" do
					stack do
						append {@options.push(@option.text())}
						append {@list.replace show_options(@options)}								
						append {@option.focus()}
					end
				end
			end

			@buttons = flow(height: 60) do
				button "suggset 1" do
					@rand_num = rand(@options.length)
					para em("FSM suggests you: #{@options[@rand_num]}")
				end

				button 'suggest > 1' do
					for i in 0..rand(@options.length)
						@rand_options << @options[rand(@options.length)]
					end
					stack do
						para em("FSM suggests you: ")
						for i in 0..rand(@rand_options.length)
							para "* #{@rand_options[i]}"
						end
					end 
				end 
			end

			#to append all the rating boxes for the rated decision
			flow do
				button "rate" do
					"Go ahead, rate your options: "
					create_list_boxes(@options, options_hash)
				end #end of the rate button
			end #end of the flow for rate button

			@pro_cons = button "pro&cons"
		end #this is the end of the @left stack

		#stack on the top right
		@right_sidebar = stack(margin: 13, height: 300, width: 200) do
			background "#CCD"
			@right_cap = caption "your list"
			@list = para
		end

		@pro_cons.click() do
			para "your options: \n"
			for opt in @options do
				para "> #{opt} \n"
			end
			para "add pros and cons here: \n"
			@proco_edit = edit_line
			@pro = button "pro"
			@con = button "con"
		end

		@pros = []
		#@pro.click() do
		#	para "click"
			#@pros << @proco_edit.text()
		#end

	end #this is the end of the big flow 
end #this is the end of "Shoes.app"

