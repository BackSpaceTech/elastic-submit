  # coffeelint: disable=max_line_length

exports.name = 'tumblr'
exports.url = 'https://www.tumblr.com/register'
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
    selector: 'span.signup_get_started_btn.active'
  }
  {
    command: 'click'
    selector: 'span.signup_get_started_btn.active'
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'wait-for'
    selector: 'input[type="email"]'
  }
  {
    command: 'profile-email'
    selector: 'input[type="email"]'
  }
  {
    command: 'press-tab'
  }
  {
    command: 'profile-password'
    selector: 'input[type="password"]'
  }
  {
    command: 'press-tab'
  }
  {
    command: 'profile-username'
    selector: 'input[name="tumblelog[name]"]'
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'click'
    selector: 'button:contains(Sign up)'
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'wait-for'
    selector: 'input[name="user[age]"]'
  }
  {
    command: 'random-number'
    selector: 'input[name="user[age]"]'
    min: 18
    max: 60
  }
  {
    command: 'click'
    selector: 'input[name="user[tos]"]'
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'click'
    selector: 'button:contains(Next)'
  }
  {
    command: 'wait-for'
    selector: 'div[class="recaptcha-checkbox-checkmark"]'
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'click'
    selector: 'div[class="recaptcha-checkbox-checkmark"]'
  }
  {
    command: 'wait'
    value: 2000
  }
]
