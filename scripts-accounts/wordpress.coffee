  # coffeelint: disable=max_line_length

exports.name = 'wordpress'
exports.url = 'https://wordpress.com/start?ref=homepage'
exports.steps = [
  {
    command: 'create-profile'
    noHTML: false
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait-for'
    selector: 'span[class="signup__steps"]'
  }
# Step 1 of 6
  {
    command: 'if'
    selector: 'svg[class="gridicon gridicons-briefcase survey-step__vertical__icon"]'
  }
  {
    command: 'click'
    selector: 'svg[class="gridicon gridicons-briefcase survey-step__vertical__icon"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'label:contains(Technology & Computing)'
  }
  {
    command: 'click'
    selector: 'label:contains(Technology & Computing)'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'h2:contains(A grid of my latest posts)'
  }
  {
    command: 'end-if'
  }
# Step 2 of 6
  {
    command: 'if'
    selector: 'h2:contains(A grid of my latest posts)'
  }
  {
    command: 'click'
    selector: 'h2:contains(A grid of my latest posts)'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'a[class="theme__active-focus"]'
  }
  {
    command: 'end-if'
  }
# Step 3 of 6
  {
    command: 'if'
    selector: 'a[class="theme__active-focus"]'
  }
  {
    command: 'click'
    selector: 'a[class="theme__active-focus"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'input[type="search"]'
  }
  {
    command: 'end-if'
  }
# Step 4 of 6
  {
    command: 'if'
    selector: 'input[type="search"]'
  }
  {
    command: 'profile-username'
    selector: 'input[type="search"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'button:contains(Select)'
  }
  {
    command: 'click'
    selector: 'button:contains(Select)'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'button:contains(Select Free)'
  }
  {
    command: 'end-if'
  }
# Step 5 of 6
  {
    command: 'if'
    selector: 'button:contains(Select Free)'
  }
  {
    command: 'click'
    selector: 'button:contains(Select Free)'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'input[name="email"]'
  }
  {
    command: 'end-if'
  }
# Step 6 of 6
  {
    command: 'if'
    selector: 'input[name="email"]'
  }
  {
    command: 'profile-email'
    selector: 'input[name="email"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'profile-password'
    selector: 'input[name="password"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'click'
    selector: 'button[type="submit"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'button[class="button email-confirmation__button is-primary"]'
  }
  {
    command: 'save-account'
    sitename: false
  }
  {
    command: 'wait'
    value: 60000
  }
]
