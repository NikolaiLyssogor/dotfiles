return {
	{
		"goolord/alpha-nvim",
		commit = "41283fb402713fc8b327e60907f74e46166f4cfd",
		pin = true,
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local session_lens = require("auto-session.session-lens")

			dashboard.section.header.val = {
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"                                                  ",
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			}
			-- dashboard.section.header.val = {
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                                                  ",
			-- 	"                      neovim.                     ",
			-- 	"",
			-- 	"",
			-- 	"",
			-- 	"",
			-- 	"",
			-- 	"",
			-- }

			local function set_toggle_light_dark_theme()
				local home = os.getenv("HOME")
				local filepath = home .. "/.config/nvim/.data/theme.txt"
				local readfile = io.open(filepath, "r")

				if readfile then
					local curr_theme = readfile:read("*l")
					curr_theme = string.gsub(curr_theme, "^%s*(.-)%s*$", "%1")
					if curr_theme == "dark" then
						vim.o.background = "light"
						vim.api.nvim_command("Catppuccin latte")
						local writefile = io.open(filepath, "w+")
						if writefile then
							writefile:write("light")
							writefile:close()
						else
							print("ERROR: Failed to open file when writing light theme")
						end
					elseif curr_theme == "light" then
						vim.o.background = "dark"
						vim.api.nvim_command("Catppuccin mocha")
						local writefile = io.open(filepath, "w+")
						if writefile then
							writefile:write("dark")
							writefile:close()
						else
							print("ERROR: Failed to open file when writing dark theme")
						end
					else
						print("ERROR: Theme file found unexpected setting " .. curr_theme)
					end
					readfile:close()
				else
					print("ERROR: Could not open " .. filepath .. " when setting theme.")
				end
			end

			-- Set menu
			dashboard.section.buttons.val = {
				-- dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
				dashboard.button("s", "󰉋  > Open session", session_lens.search_session),
				dashboard.button("p", "  > Package manager", ":Lazy<CR>"),
				dashboard.button("t", "󰔎  > Toggle theme", set_toggle_light_dark_theme),
				dashboard.button("q", "󰅚  > Quit NVIM", ":qa<CR>"),
			}

			-- put famous programming quotes here?
			local fortune = require("alpha.fortune")
			dashboard.section.footer.val = fortune({
				fortune_list = {
					{
						{
							"Control construction, copy, move, and destruction of objects.",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Define all essential operations or none.",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"By default, declare single-argument constructors explicit.",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Follow the standard-library container design.",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{ "", "", "— Bjarne Stroustrup, C++ Core Guidelines" },
						{ "", "", "— Bjarne Stroustrup, C++ Core Guidelines" },
						{ "", "", "— Bjarne Stroustrup, C++ Core Guidelines" },
						{
							"If a class is a container, giv e it an initializer-list constructor",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Avoid ‘‘naked’’ new and delete operations",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Declare a member function that does not modify the state of its object const",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Make a function a member only if it needs direct access to the representation of a class",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Prefer concrete classes over class hierarchies for performance-critical components",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"A concrete type is the simplest kind of class. Where applicable, prefer a concrete type over more complicated classes and over plain data structures",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Use header files to represent interfaces and to emphasize logical structure",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Avoid non-inline function definitions in headers",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Develop an error-handling strategy early in a design",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"If your function may not throw, declare it noexcept",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Let a constructor establish an invariant, and throw if it cannot",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Design your error-handling strategy around invariants",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Prefer pass-by-const-reference over plain pass-by-reference",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"A struct is simply a class with its members public by default",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						{
							"Avoid ‘‘naked’’ unions; wrap them in a class together with a type field",
							"",
							"— Bjarne Stroustrup, C++ Core Guidelines",
						},
						"Prefer class enums over ‘‘plain’’ enums to minimize surprises",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{
						"If a function may have to be evaluated at compile time, declare it constexpr",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{
						"You don’t hav e to know every detail of C++ to write good programs.",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{
						"Focus on programming techniques, not on language features.",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{
						"A function should perform a single logical operation",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{ "Use unsigned for bit manipulation only", "", "— Bjarne Stroustrup, C++ Core Guidelines" },
					{
						"Keep use of pointers simple and straightforward",
						"",
						"— Bjarne Stroustrup, C++ Core Guidelines",
					},
					{ "Use nullptr rather than 0 or NULL", "", "— Bjarne Stroustrup, C++ Core Guidelines" },
					{
						"Don’t say in comments what can be clearly stated in code",
						"",
						"— Bjarne Stroustrup,  C++ Core Guidelines",
					},
					{ "A computer is a bicycle for the mind.", "", "— Steve Jobs" },
					{
						"when you don't create things, you become defined by your tastes rather than ability. your tastes only narrow & exclude people. so create..",
						"",
						"— Why The Lucky Stiff",
					},
					{
						"Programs must be written for people to read, and only incidentally for machines to execute.",
						"",
						"— Harold Abelson, Structure and Interpretation of Computer Programs",
					},
					{
						"Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live",
						"",
						"— John Woods",
					},
					{
						"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the Universe trying to produce bigger and better idiots. So far, the Universe is winning.",
						"",
						"— Rick Cook, The Wizardry Compiled",
					},
					{
						"Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",
						"",
						"— Martin Fowler",
					},
					{
						"The best programs are written so that computing machines can perform them quickly and so that human beings can understand them clearly. A programmer is ideally an essayist who works with traditional aesthetic and literary forms as well as mathematical concepts, to communicate the way that an algorithm works and to convince a reader that the results will be correct.",
						"",
						"— Donald E. Knuth, Selected Papers on Computer Science",
					},
					{
						"I'm not a great programmer; I'm just a good programmer with great habits.",
						"",
						"— Kent Beck",
					},
					{
						"Truth can only be found in one place: the code.",
						"",
						"—Robert C. Martin, Clean Code: A Handbook of Agile Software Craftsmanship ",
					},
					{
						"Well, Mr. Frankel, who started this program, began to suffer from the computer disease that anybody who works with computers now knows about. It's a very serious disease and it interferes completely with the work. The trouble with computers is you *play* with them. They are so wonderful. You have these switches - if it's an even number you do this, if it's an odd number you do that - and pretty soon you can do more and more elaborate things if you are clever enough, on one machine. \nAfter a while the whole system broke down. Frankel wasn't paying any attention; he wasn't supervising anybody. The system was going very, very slowly - while he was sitting in a room figuring out how to make one tabulator automatically print arc-tangent X, and then it would start and it would print columns and then bitsi, bitsi, bitsi, and calculate the arc-tangent automatically by integrating as it went along and make a whole table in one operation. \nAbsolutely useless. We *had* tables of arc-tangents. But if you've ever worked with computers, you understand the disease - the *delight* in being able to see how much you can do. But he got the disease for the first time, the poor fellow who invented the thing.",
						"",
						"—Richard P. Feynman, Surely You're Joking, Mr. Feynman!: Adventures of a Curious Character ",
					},
					{ "How you look at it is pretty much how you'll see it", "", "— Rasheed Ogunlaru" },
					{
						"That's the thing about people who think they hate computers. What they really hate is lousy programmers.",
						"",
						"— Larry Niven",
					},
					{
						"A language that doesn't affect the way you think about programming is not worth knowing.",
						"",
						"— Alan J. Perlis",
					},
					{
						"On two occasions, I have been asked [by members of Parliament], 'Pray, Mr. Babbage, if you put into the machine wrong figures, will the right answers come out?' I am not able to rightly apprehend the kind of confusion of ideas that could provoke such a question.",
						"",
						"— Charles Babbage",
					},
					{
						"The most disastrous thing that you can ever learn is your first programming language.",
						"",
						"— Alan Kay",
					},
					{
						"The most important property of a program is whether it accomplishes the intention of its user.",
						"",
						"— C.A.R. Hoare",
					},
					{
						"A computer is like a violin. You can imagine a novice trying ﬁrst a phonograph and then a violin. The latter, he says, sounds terrible. That is the argument we have heard from our humanists and most of our computer scientists. Computer programs are good, they say, for particular purposes, but they aren’t ﬂexible. Neither is a violin, or a typewriter, until you learn how to use it.",
						"",
						"— Marvin Minsky",
					},
					{
						"Object-oriented programming offers a sustainable way to write spaghetti code. It lets you accrete programs as a series of patches.",
						"",
						"— Paul Graham, Hackers and Painters",
					},
					{
						"You Can't Write Perfect Software. Did that hurt? It shouldn't. Accept it as an axiom of life. Embrace it. Celebrate it. Because perfect software doesn't exist. No one in the brief history of computing has ever written a piece of perfect software. It's unlikely that you'll be the first. And unless you accept this as a fact, you'll end up wasting time and energy chasing an impossible dream.",
						"",
						"— Andrew Hunt, The Pragmatic Programmer: From Journeyman to Master",
					},
					{
						"I think that it’s extraordinarily important that we in computer science keep fun in computing. When it started out it was an awful lot of fun. Of course the paying customers got shafted every now and then and after a while we began to take their complaints seriously. We began to feel as if we really were responsible for the successful error-free perfect use of these machines. I don’t think we are. I think we’re responsible for stretching them setting them off in new directions and keeping fun in the house. I hope the ﬁeld of computer science never loses its sense of fun. Above all I hope we don’t become missionaries. Don’t feel as if you’re Bible sales-men. The world has too many of those already. What you know about computing other people will learn. Don’t feel as if the key to successful computing is only in your hands. What’s in your hands I think and hope is intelligence: the ability to see the machine as more than when you were ﬁrst led up to it that you can make it more.",
						"",
						"— Alan J. Perlis",
					},
					{
						"Remember that code is really the language in which we ultimately express the requirements. We may create languages that are closer to the requirements. We may create tools that help us parse and assemble those requirements into formal structures. But we will never eliminate necessary precision—so there will always be code.",
						"",
						"— Robert C. Martin",
					},
					{
						"Learning the art of programming, like most other disciplines, consists of first learning the rules and then learning when to break them.",
						"",
						"— Joshua Bloch, Effective Java : Programming Language Guide",
					},
					{
						"You are not reading this book because a teacher assigned it to you, you are reading it because you have a desire to learn, and wanting to learn is the biggest advantage you can have.",
						"",
						"— Cory Althoff, The Self-Taught Programmer: The Definitive Guide to Programming Professionally",
					},
					{
						"Everyone knows that debugging is twice as hard as writing a program in the first place. So if you're as clever as you can be when you write it, how will you ever debug it?",
						"",
						"— Brian Kernighan",
					},
					{
						"Programmers are not to be measured by their ingenuity and their logic but by the completeness of their case analysis.",
						"",
						"— Alan J. Perlis",
					},
					{
						"Progress is possible only if we train ourselves to think about programs without thinking of them as pieces of executable code.",
						"",
						"— Edsger W. Dijkstra",
					},
					{
						"Some of the best programming is done on paper, really. Putting it into the computer is just a minor detail.",
						"",
						"— Charles Petzold, Code: The Hidden Language of Computer Hardware and Software",
					},
					{
						"We see a lot of feature-driven product design in which the cost of features is not properly accounted. Features can have a negative value to customers because they make the products more difficult to understand and use. We are finding that people like products that just work. It turns out that designs that just work are much harder to produce that designs that assemble long lists of features.",
						"",
						"Douglas Crockford, JavaScript: The Good Parts",
					},
					{
						'Don\'t gloss over a routine or piece of code involved in the bug because you "know" it works. Prove it. Prove it in this context, with this data, with these boundary conditions.',
						"",
						"Andrew Hunt, The Pragmatic Programmer: From Journeyman to Master",
					},
					{
						"The issue of finding the best possible answer or achieving maximum efficiency usually arises in industry only after serious performance or legal troubles.",
						"",
						"Steven S. Skiena, The Algorithm Design Manual",
					},
					{ "I am committed to push my branch to the master", "", "Halgurd Hussein" },
					{
						"In games, the thing that matters most is the order of things. The game has an algorithm, but the player also must create a play algorithm in order to win. There is an order to any victory. There is an optimal way to play any game.",
						"",
						"— Gabrielle Zevin, Tomorrow, and Tomorrow, and Tomorrow",
					},
					{ "First, solve the problem. Then write the code.", "", "— John Johnson" },
					{
						"But the underlying capability of the computer era is actually programming—which almost none of us knows how to do. We simply use the programs that have been made for us, and enter our text in the appropriate box on the screen. We teach kids how to use software to write, but not how to write software. This means they have access to the capabilities given to them by others, but not the power to determine the value-creating capabilities of these technologies for themselves.",
						"",
						"— Douglas Rushkoff, Program or Be Programmed: Ten Commands for a Digital Age",
					},
					{
						"There is no such thing as ethical hacking, If it were ethical they wouldn't be teaching it. Because like it or not ethics is bad for business, They teach hacking so they could use it for profit. With the right sequence of zeros and ones we could, Equalize all bank accounts of planet earth tomorrow. Forget about what glass house gargoyles do with tech, How will you the human use tech to eliminate sorrow? In a world full of greedy edisons, be a humble Tesla, Time remembers no oligarch kindly no matter the status. Only innovators who get engraved in people's heart, Are the ones who innovate with a humane purpose. Innovate to bridge the gap, not exploit and cater to disparities. In a world run by algorithms of greed write a code that helps 'n heals.",
						"",
						"— Abhijit Naskar, Corazon Calamidad: Obedient to None, Oppressive to None",
					},
					{
						"Simplicity only makes sense in context. If I’m writing a parser with a team that understands parser generators, then using a parser generator is simple. If the team doesn’t know anything about parsing and the language is simple, a recursive descent parser is simpler.",
						"",
						"— Kent Beck, Extreme Programming Explained: Embrace Change",
					},
					{
						"One broken window, left unrepaired for any substantial length of time, instills in the inhabitants of the building a sense of abandonment—a sense that the powers that be don’t care about the building. So another window gets broken. People start littering. Graffiti appears. Serious structural damage begins. In a relatively short span of time, the building becomes damaged beyond the owner’s desire to fix it, and the sense of abandonment becomes reality.",
						"",
						"— Andrew Hunt, The Pragmatic Programmer: From Journeyman to Master",
					},
					{ "Anything that you do more than twice has to be automated.", "", "— Adam Stone" },
					{ "Whatcha doin' Frank, fishin'? Nope, just drowning worms.", "", "— Andrew Barger" },
					{
						"It’s just like planning a dinner. You have to plan ahead and schedule everything so it's ready when you need it. Programming requires patience and the ability to handle detail.",
						"",
						"— Grace Hopper",
					},
					{
						"Listening , Testing , Coding , Designing. That's all there is to software. Anyone who tells you different is selling something .",
						"",
						"— Kent Beck",
					},
					{
						"The programmer, like the poet, works only slightly removed from pure thought-stuff. He builds his castles in the air, from air, creating by exertion of the imagination. Few media of creation are so flexible, so easy to polish and rework, so readily capable of realizing grand conceptual structures.... Yet the program construct, unlike the poet's words, is real in the sense that it moves and works, producing visible outputs separate from the construct itself.",
						"",
						"— Frederick P. Brooks Jr., The Mythical Man Month",
					},
					{
						"Program testing can be a very effective way to show the presence of bugs, but it is hopelessly inadequate for showing their absence.",
						"",
						"— Edsger W. Dijkstra, The Humble Programmer",
					},
					{
						"Why is programming fun? What delights may its practitioner expect as his reward? First is the sheer joy of making things. As the child delights in his first mud pie, so the adult enjoys building things, especially things of his own design. I think this delight must be an image of God’s delight in making things, a delight shown in the distinctness and newness of each leaf and each snowflake.",
						"",
						"— Frederick P. Brooks Jr., The Mythical Man-Month",
					},
					{
						"Why is programming fun? What delights may its practitioner expect as his reward? ... Second is the pleasure of making things that are useful to other people. Deep within, we want others to use our work and to find it helpful. In this respect the programming system is not essentially different from the child’s first clay pencil holder “for Daddy’s office.”",
						"",
						"— Frederick P. Brooks Jr., The Mythical Man-Month",
					},
					{
						"Why is programming fun? What delights may its practitioner expect as his reward? ... Third is the fascination of fashioning complex puzzle-like objects of interlocking moving parts and watching them work in subtle cycles, playing out the consequences of principles built in from the beginning. The programmed computer has all the fascination of the pinball machine or the jukebox mechanism, carried to the ultimate.",
						"",
						"— Frederick P. Brooks Jr., The Mythical Man-Month",
					},
					{
						"Why is programming fun? What delights may its practitioner expect as his reward? ... Fourth is the joy of always learning, which springs from the nonrepeating nature of the task. In one way or another the problem is ever new, and its solver learns something; sometimes practical, sometimes theoretical, and sometimes both.",
						"",
						"— Frederick P. Brooks Jr., The Mythical Man-Month",
					},
					{
						"Programming, when stripped of all its circumstantial irrelevancies, boils down to no more and no less than very effective thinking so as to avoid unmastered complexity, to very vigorous separation of your many different concerns.",
						"",
						"— Edsger W. Dijkstra",
					},
					{
						"Small minds are concerned with the extraordinary, great minds with the ordinary",
						"",
						"— Blaise Pascal",
					},
				},
			})

			-- Send config to alpha
			alpha.setup(dashboard.opts)
		end,
	},
}
