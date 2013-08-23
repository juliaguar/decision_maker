Shoes.app title: "main" do
	
	#changing the background color randomly
	@caracters = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	@color = "#"
	for i in 0..2 do
		@random = rand(@caracters.length)
		@rand_caract = @caracters[@random]
		@color << @rand_caract
	end
	background @color

	stack do
		caption "Welcome :)
We are going to make a list of things you want to do..." 

	@option
	@count = 1
	@options = []

	flow height: 69 do 
		@option = edit_line
		button "ok" do
			stack do
				append {@options.push(@option.text())}
				append {para "[#{@count}] #{@option.text()}"}
				append {@count += 1}
				append {@option.focus()}
			end
		end
	end

	@suggest = button "suggset" do
		@rand_num = rand(@options.length)
		para "We suggest you to: #{@options[@rand_num]}"
	end
		
	#Learning shoes:

	#@shape = star(points: 5)
	#motion do |left, top|
		#@shape.move left, top
	#end

	#fill "#FFF"
	#@cricle = oval(left: rand(200), top: rand(200), radius: 10)

	#para "choose your weapon"
	#@coff = radio; para "coffee"
	#@mate = radio; para "mate"
			
	#@coff.click() {para "You seem to like coffee"}
	
	#para "choose a drifferent background: "
	#list_box items: ["black", "green", "blue", "red", "yellow", "orange", "white"]


	#image "U:/Dropbox/Photos/Helsinki/Auto_im_schnee.jpg"
	#@note = para "placeholder"

	#@submit.click {
	#	@note.replace para "#{@option.text()}"
	#}

	end
end