QuestionTree.destroy_all

question1 = QuestionTree.create(message: "Is it a robot?")
question2 = QuestionTree.create(message: "Is it an animal?")

answer1 = QuestionTree.create(message: "Yup. It's a robot.")
answer2 = QuestionTree.create(message: "Totes an animal.")

question1.yes_id = answer1.id
question1.no_id = question2.id

question2.yes_id = answer2.id

question1.save!
question2.save!