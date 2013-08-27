Shoes.app title: "main" do
	
	#changing the background color randomly
	@caracters = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	@color = "#"
	for i in 0..2 do
		@rand_caract = @caracters[rand(@caracters.length)]
		@color << @rand_caract
	end
	background @color
	
	@all = stack(margin: 23) do
		stack(height: 102) do
			caption("Welcome :), ", stroke: white, font: "Trebuchet MS")
			para("we are going to make a list of things you want to do...", stroke: white)
		end

		@option
		@count = 1
		@options = []
		@rand_options = []

		@edit_line = flow(height: 43) do 
			@option = edit_line
			button "ok" do
				stack do
					append {@options.push(@option.text())}
					append {@list.replace @options.each {|opt| "#{opt}, " }}
					append {@count += 1}
					append {@option.focus()}
					append {@star.clear}
				end
			end
		end

		@li = stack do
			@list = para
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
		
		stack do
			button "advanced" do
				append {@all.clear}
				append {@options.each {|opt| para "* #{opt} \n"}}	
			end
		end

		flow(align: "right", width: 600) do
			inscription sub(em("color: #{@color}"))
		end
	end

	stack stack(margin: 23) do
		button "advanced" do
			append {@all.clear}
			append {@options.each {|opt| para "* #{opt} \n"}}	
		end
	end

end