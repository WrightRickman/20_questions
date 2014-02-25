QuestionTree.destroy_all

question1 = QuestionTree.create(message: "Is it a robot")
question2 = QuestionTree.create(message: "Is it an animal")

answer1 = QuestionTree.create(message: "Hedonism Bot")
answer2 = QuestionTree.create(message: "Armadillo")

question1.yes_id = answer1.id
question1.no_id = question2.id

question2.yes_id = answer2.id
question2.parent_id = question1.id

answer1.parent_id = question1.id
answer2.parent_id = question2.id

question1.save!
question2.save!
answer1.save!
answer2.save!