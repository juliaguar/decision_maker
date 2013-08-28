Shoes.app title: "main" do
	
	#changing the background color randomly
	@caracters = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	@color = "#"
	for i in 0..2 do
		@rand_caract = @caracters[rand(@caracters.length)]
		@color << @rand_caract
	end
	background @color
	
	flow do
		@left = stack(margin: 13, width: 350, height: 400) do
			background "#BBB"
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
							append {@list.replace @options.each {|opt| "#{opt}"} }							
						end
						append {@option.focus()}
						append {@star.clear}
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

			#nonsense animated star, because of fun
			@star = stack do
				@shape = star(points: 5, top: 30, left: 400, color: blue)
				animate(3) do |i|
		      @shape.top += (-20..20).rand
		      @shape.left += (-20..20).rand
		    end
		  end

		  #putting the advanced stuff where the main decision stuff is
			#stack do
			#	button "advanced" do
			#		append {@all.clear { @options.each {|opt| para "#{opt} "} }}
			#		append {@options.each{ list_box :items => ["1", "2", "3"] }}
			#	end
			#end

			#to append all the things for the advanced decision instead of trying to replace stuff
			flow do
				button "advanced" do
					flow(margin: 23) do
						stack do
							para "rate your options: "	
						end
						stack do
							flow do
								append {@options.each {|opt| para "| #{opt} "} }		
							end
						end 
						append {@options.each{ @list_box = list_box :items => ["1", "2", "3"], width: 40 }}
						append {@ratings = button "submit" }
						@list_box.change() {para "#{@list_box.text()}"}
					end
				end
			end

			@background = flow(align: "right", width: 600) do
				inscription sub(em("color: #{@color}"))
			end
			@background.click() {visit("/")} #this changes the background by reloading the page
		end #this is the end of the @left stack

		stack(margin: 13, height: 400, width: 200) do
			background "#999"
			@list = para ""
		end

	end #this is the end of the big flow 
end #this is the end of "Shoes.app"

