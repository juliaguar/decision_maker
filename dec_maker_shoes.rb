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
		if options_pros[opt] && options_cons[opt]
			option_values[opt] = options_pros[opt].length - options_cons[opt].length
		elsif options_cons[opt]
			option_values[opt] = 0 - options_cons[opt].length
		elsif options_pros[opt]
			option_values[opt] = options_pros[opt].length
		else
			option_values[opt] = 0
		end				
	end
	@rating_result.append do
		para "Your best option is:"
		para strong("#{option_values.max_by{|k,v| v}[0]}")
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
				@rating_result.append {para("FSM calculated for you: ", strong("#{suggestion} \n"))}
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
	@stack_height = 330
	@stack_width = 280
	flow do
		#stack on the top left: 
		@left = stack(margin: 10, width: @stack_width, height: @stack_height) do
			background "#59C" #"#44A"

			stack(height: 123) do
				para("Welcome :) ", stroke: white, font: "Trebuchet MS")
				para("FSM is here to help you with your decision. First step: list the things you can't decide... ", stroke: white)
			end

			@option
			@options = []
			@rand_options = []
			options_hash = Hash.new()

			@edit_line = flow(height: 53) do 
				@option = edit_line(width: 150)				
				@submit = button "ok" do
					stack do
						append {@list_capt.show()}
						append {@extend.show()}
						append {@options.push(@option.text())}
						append {@list.replace show_options(@options)}								
						append {@option.focus()}
					end
				end
			end

			@buttons = flow(height: 60) do
				button "suggset 1" do
					@rand_num = rand(@options.length)
					@rating_result.append {para "FSM suggests you: #{@options[@rand_num]}"}
				end

				button 'suggest > 1' do
					for i in 0..rand(@options.length)
						@rand_options << @options[rand(@options.length)]
					end
					@rating_result.append do
						para "FSM suggests you: "
						for i in 0..rand(@rand_options.length)
							para "#{@rand_options[i]}"
						end
					end 
				end 
			end

			#to append all the rating boxes for the rated decision
			flow do
				button "rate" do
					append {@rating_action.append {para "Go ahead, rate your options. The heigher you rate them, the more likely are they to be picked."}}
					append {create_list_boxes(@options, options_hash)}
				end #end of the rate button
			end #end of the flow for rate button

			@pro_cons = button "pro&cons"
=begin
			fill(white); stroke white; strokewidth 3; cap(:curve)
			line(0, (@stack_height - 40), (@stack_width*0.25), (@stack_height - 40)) # first straight
			line((@stack_width*0.25), (@stack_height - 40), (@stack_width*0.25 + 20), @stack_height) #first down
			line((@stack_width*0.25 + 5), (@stack_height - 40), (@stack_width*0.5), (@stack_height - 40)) #second straight
			line((@stack_width*0.5), (@stack_height - 40), (@stack_width*0.5 + 20), (@stack_height)) #second down
			line((@stack_width*0.5 + 5), (@stack_height - 40), (@stack_width*0.75), (@stack_height - 40)) #third straight
			line((@stack_width*0.75), (@stack_height - 40), (@stack_width*0.75 + 20), (@stack_height)) #third down
			line((@stack_width*0.75 + 5), (@stack_height - 40), (@stack_width), (@stack_height - 40)) #fourth straight

			flow(top: @stack_height - 40) do

			 inscription "pro&con", stroke: white
			 inscription "suggest 1"
			 inscription "suggest <"
			 inscription "rate"
			end
=end
		end #this is the end of the @left stack

		#stack on the top right
		@right_sidebar = stack(margin: 10, height: @stack_height, width: 200) do
			background "#8BD"
			@list_capt = caption "your list", :stroke => white
			@list_capt.hide()
			@list = para
			@ratings = para
			@cons = para
			@extend = flow(width: 70, top: @stack_height - 50) do
				inscription em("show more"), stroke: white
			end
			@extend.hide()
			@extend.click() do
				@stack_height += 100
				@right_sidebar.style(height: @stack_height)
				@left.style(height: @stack_height)
				@extend.style(top: @stack_height - 50)
			end
		end

		#rating actions 2. stack on the left
		@rating_action = stack(margin: 10, width: @stack_width) do
			#append all the pro & cons rating content on the left
			@pro_con_action = flow {}
			@check_options = flow {}
		end

		#show result of rating on the right
		@rating_result = stack(width: 200, margin: 13) do
			background "#59C"
		end

		options_pros = Hash.new
		options_cons = Hash.new 
		@checkboxes = []
		@pros_array = []
		@cons_array = []

		@pro_cons.click() do
			@right_sidebar.before(@ratings) {caption "pros", stroke: white}
			@right_sidebar.after(@ratings) {caption "cons", stroke: white}
			@pro_con_action.append do
				para "Select pro or con and add your pros/cons. Once you are finished click 'finish'. \n"
				para "\n"

				@pro = button "pro" do
					@con.hide()
					@check_options.append do
						show_check_options(@options, @checkboxes)
						@add = button "add" do 		#creates new entry in options_pros hash, with the options which are checked by user
							@pros_array.push(@proco_edit.text())
							for i in 0..@options.length - 1
								if @checkboxes[i].checked?()
									options_pros[@options[i]] = []
									options_pros[@options[i]].push(@proco_edit.text()) 
								end
							end
							@con.show()
							@ratings.replace @pros_array.collect {|pro| "#{pro} \n"}
							@check_options.clear()
						end #end of add button
					end #end of append to pro_con_action
				end
				@con = button "con"	do
					@pro.hide()
					@check_options.append do
						show_check_options(@options, @checkboxes)
						@add = button "add" do 		#creates new entry in options_cons hash, with the options which are checked by user
							@cons_array.push(@proco_edit.text())
							for i in 0..@options.length - 1
								if @checkboxes[i].checked?()
									options_cons[@options[i]] = []
									options_cons[@options[i]].push(@proco_edit.text()) 
								end
							end
							@pro.show()
							@cons.replace @cons_array.collect {|con| "#{con} \n"}
							@check_options.clear()
						end #end of add button
					end #end of pro_con_action append
				end	#end of con button
				
				para "\n"
				@proco_edit = edit_line(width: 112)
				para "\t"
				@eval_procon = button "finish" do
					best_option(@options, options_pros, options_cons)
				end
			end #end of the pro_cons.click() event
		end


	end #this is the end of the big flow 
end #this is the end of "Shoes.app"

