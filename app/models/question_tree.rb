class QuestionTree < ActiveRecord::Base

	def yes
		# finds the yes_id of the QuestionTree 
		QuestionTree.find(self.yes_id)
	end

	def no
		QuestionTree.find(self.no_id)
	end

	def self.load
		root = self.start_game 
		root.ask
		input = ""
	end

	def self.start_game
		root = QuestionTree.first
	end

	def ask
		if self.is_question?
			puts "#{self.message}?"
		else
			puts "Is it a #{self.message}?"
		end
	end

	def is_question?
		return false if self.yes_id.nil? && self.no_id.nil?
		true
	end

end
