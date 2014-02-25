class QuestionTree < ActiveRecord::Base

	def yes
		# finds the yes_id of the QuestionTree 
		QuestionTree.find(self.yes_id)
	end

	def no
		QuestionTree.find(self.no_id)
	end

	def parent
		QuestionTree.find(self.parent_id)
	end

	def error_handler
		# Future regex
		puts "Please enter 'yes' or 'no'."
		input = gets.chomp

		return input
	end

	def self.load
		root = self.start_game 

		puts "Please think of a thing."

		root.ask
	end

	def self.start_game
		QuestionTree.first
	end

	def self.start_over
		puts "Would you like to play again?"

		input = gets.chomp 

		# ===== PLAY AGAIN =====
		if input == "yes"
			self.load
		elsif input == "no"
			puts "Thank you for playing."
		else
			puts "Please enter 'yes' or 'no'."

			QuestionTree.start_over
		end
	end

	def ask
		# ===== QUESTION OR ANSWER =====
		if self.is_question?
			puts "#{self.message}? Type 'yes' or 'no'."

			input = gets.chomp

			self.travel_tree(input)
		else
			puts "You were thinking of a(n) #{self.message}."
			puts "Were we correct?"

			input = gets.chomp

			# ===== DID WE GET THE ANSWER RIGHT? =====
			if input == "yes"
				puts "We're the best arou-ound!"

				QuestionTree.start_over

			elsif input == "no"
				QuestionTree.add_answer(self)

			else
				puts "Invalid answer."

				self.ask
			end
		end
	end

	def is_question?
		return false if self.yes_id.nil? && self.no_id.nil?
		true
	end

	def travel_tree(input)
		# ICEBOX - regex that shit
		if input == "yes"
			self.yes.ask
		elsif input == "no"
			self.no.ask
		else
			input = error_handler

			self.travel_tree(input)
		end
	end

	def self.add_answer(current_question)
		puts "Please enter what you were thinking of:"

		input = gets.chomp

		new_message = QuestionTree.create(message: input)

		new_message.save!

		QuestionTree.add_question(new_message, current_question)

		puts "self.add_answer current_question = #{current_question}"
	end

	def self.add_question(new_message, current_question)
		puts "What question would #{new_message.message} be the answer to, instead of #{current_question.message}?"

		question_input = gets.chomp

		new_question = QuestionTree.create(message: question_input, yes_id: new_message.id, no_id: current_question.id, parent_id: current_question.parent.parent.id)

		current_question.parent_id = new_question.id
		current_question.parent.parent.no_id = new_question.id

		new_message.parent_id = new_question.id

		current_question.save!
		current_question.parent.parent.save!
		new_message.save!
	end
end
