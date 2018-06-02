class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Polina',
        username: 'ursapolly',
        avatar_url: 'https://img1.ak.crunchyroll.com/i/spire1/89bcf84b15a6cfbe05487ad5864504401488371587_large.png'
      ),
      User.new(
        id: 2,
        name: 'Irina',
        username: 'irrr'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Polina',
      username: 'ursapolly',
      avatar_url: 'https://img1.ak.crunchyroll.com/i/spire1/89bcf84b15a6cfbe05487ad5864504401488371587_large.png'
    )

    @questions = [
      Question.new(text: 'Как ты?', created_at: Date.parse('02.06.2018')),
      Question.new(text: 'Любимое время года?', created_at: Date.parse('02.06.2018'))
    ]

    @new_question = Question.new
  end
end
