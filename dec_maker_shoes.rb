Shoes.app title: "main" do

	background "#9CC"
	
	flow do
		#stack on the top left: 
		@left = stack(margin: 13, width: 320, height: 300) do
			background "#ADC"
			stack(height: 102) do
				caption("Welcome :), ", stroke: white, font: "Trebuchet MS")
				para("we are going to make a list of things you want to do...", stroke: white)
			end

			@option
			@options = []
			@rand_options = []
			@ratings = []

			@edit_line = flow(height: 43) do 
				@option = edit_line
				@submit = button "ok" do
					stack do
						append {@options.push(@option.text())}
						stack do
							append do
								@list.replace @options.each {|opt| "#{opt} \n"}									
							end
						end
						append {@option.focus()}
					end
				end
			end

			@buttons = flow(height: 60) do
				button "suggset I" do
					@rand_num = rand(@options.length)
					para em("We suggest you: #{@options[@rand_num]}")
				end

				button 'suggest > I' do
					for i in 0..rand(@options.length)
						@rand_options << @options[rand(@options.length)]
					end
					stack do
						para em("We suggest you: ")
						for i in 0..rand(@rand_options.length)
							para "* #{@rand_options[i]}"
						end
					end 
				end 
			end

			#to append all the things for the advanced decision
			flow do
				button "advanced" do
					flow(margin: 23) do
						stack do
							para "rate your options: "	
						end
						append do
							flow(margin: 7) do
								for i in 0..@options.length - 1 
									@list_box = list_box :items => ["1", "2", "3"], width: 40
									para " #{i + 1}. #{@options[i]} \n"									
								end
							end
							#@options.each{ @list_box = list_box :items => ["1", "2", "3"], width: 80, margin: 7 }
						end
						#append {@ratings = button "submit", margin: 12 }
						@list_box.change() {para "#{@list_box.text()}"}
					end
				end #end of the advanced button
			end #end of the flow for advanced button

			@pro_cons = button "pro&cons"
		end #this is the end of the @left stack

		#stack on the top right
		stack(margin: 13, height: 300, width: 140) do
			background "#BDD"
			caption("your list", stroke: white)
			@list = para ""
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

