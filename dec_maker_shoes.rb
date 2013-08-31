#loop through options and show each in new line
def show_options(options)
	options.collect do |opt|
		"#{opt} \n"
	end
end

#loop through options a check box and a option each in new line
def show_check_options(options, checkboxes)
	para "\n"
	for i in 0..options.length - 1
		checkboxes[i] = check()
		para "#{options[i]} \n"
	end
end

#takes in an array with options and two hashes with options as keys and pros and cons as values and returns the best option
def best_option(options, options_pros, options_cons)
	option_values = Hash.new
	for opt in options 
		option_values[opt] = options_pros[opt].length - options_cons[opt].length
	end
end

#creates a list of light boxes one after another for the length of @options
def create_list_boxes(options, options_hash)
	if options_hash.length < options.length && options_hash[options[options_hash.length]].nil?
		@rating_action.append do
			flow do
				@list_box = list_box :items => ["1", "2", "3"], width: 40
				para "#{options[options_hash.length]}"
			end
		end
		#@list_box = list_box :items => ["1", "2", "3"], width: 40
		#para "#{options[options_hash.length]} \n"
	else 
		@right_sidebar.before(@ratings) {caption "your ratings:"}
		@ratings.replace options_hash.collect { |k| "#{k}"[2..-8] + ": \t" + "#{k}"[-3..-3] + "\n"} 

		@rating_action.append do
			subm_ratings = button "submit rating" do
				rating_array = []
				for opt in options
					options_hash[opt].to_i.times {rating_array.push(opt)} 
				end
				suggestion = rating_array[rand(rating_array.length)]
				@rating_result.append {para("FSM calculated for you: ", strong("*#{suggestion}* \n"), stroke: white)}
			end
		end
	end

	@list_box.change() do
		options_hash[options[options_hash.length]] = @list_box.text()
		create_list_boxes(options, options_hash)	
	end
end

#main app
Shoes.app title: "main" do

	background "#57A"
	
	flow do
		#stack on the top left: 
		@left = stack(margin: 10, width: 300, height: 330) do
			background "#57A" #"#18C"

			fill "#555"
			oval(left: 140, top: 155, radius: 197, center: true)
			
			stack(height: 123) do
				caption("Welcome :), ", stroke: white, font: "Trebuchet MS")
				para("FSM is here to help you with your decision. First step: list the things you can't decide... ", stroke: white)
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
					append {@rating_instruction.show}
					append {create_list_boxes(@options, options_hash)}
				end #end of the rate button
			end #end of the flow for rate button

			@pro_cons = button "pro&cons"
		end #this is the end of the @left stack

		#stack on the top right
		@right_sidebar = stack(margin: 10, height: 330, width: 200) do
			background "#8BD"
			caption "your list"
			@list = para
			@ratings = para
		end

		#rating actions on the left
		@rating_action = stack(margin: 10, width: 300) do
			@rating_instruction = para "go ahead, rate your options :"
			@rating_instruction.hide()
		end

		#show result of rating on the right
		@rating_result = stack(width: 200, margin: 13) do
			background "#59C"
		end

		options_pros = Hash.new
		options_cons = Hash.new 
		@checkboxes = []

		@pro_cons.click() do
			para "add pros and cons here: \n"
			@proco_edit = edit_line
			@pro = button "pro" do
				@con.hide()
				show_check_options(@options, @checkboxes)
				@add = button "add" do 		#creates new entry in options_pros hash, with the options which are checked by user
					for i in 0..@options.length - 1
						if @checkboxes[i].checked?()
							options_pros[@options[i]] = []
							options_pros[@options[i]].push(@proco_edit.text()) 
						end
					end
					@con.show()
				end
			end
			@con = button "con"	do
				@pro.hide()
				show_check_options(@options, @checkboxes)
				@add = button "add" do 		#creates new entry in options_cons hash, with the options which are checked by user
					for i in 0..@options.length - 1
						if @checkboxes[i].checked?()
							options_cons[@options[i]] = []
							options_cons[@options[i]].push(@proco_edit.text()) 
						end
					end
					@pro.show()
				end
			end	
		end #end of the pro_cons.click() event
		
	end #this is the end of the big flow 
end #this is the end of "Shoes.app"

