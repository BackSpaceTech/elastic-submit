  # coffeelint: disable=max_line_length

exports.name = 'wikia'
exports.url = 'https://www.wikia.com/register'
exports.steps = [
  {
    command: 'create-profile'
    noHTML: false
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '#signupEmail'
  }
  {
    command: 'register'
    form: '#signupForm'
    email: '#signupEmail'
    username: '#signupUsername'
    password: '#signupPassword'
    submit: false
  }
  {
    command: 'click'
    selector: '#signupPassword'
  }
  {
    command: 'press-tab'
  }
  {
    command: 'random-number'
    selector: '#signupForm > div:nth-child(4) > div > input.fake-input.birth-month'
    min: 1
    max: 12
  }
  {
    command: 'press-tab'
  }
  {
    command: 'random-number'
    selector: '#signupForm > div:nth-child(4) > div > input.fake-input.birth-day'
    min: 1
    max: 28
  }
  {
    command: 'press-tab'
  }
  {
    command: 'random-number'
    selector: '#signupForm > div:nth-child(4) > div > input.fake-input.birth-year'
    min: 1960
    max: 1990
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'press-enter'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait-for'
    selector: '#fandomWelcome'
  }
  {
    command: 'save-account'
    sitename: false
  }
  {
    command: 'wait'
    value: 10000
  }
]
