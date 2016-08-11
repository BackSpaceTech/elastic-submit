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
    value: 2000
  }
  {
    command: 'wait-for'
    selector: 'span[class="signup__steps"]'
  }
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
  {
    command: 'if'
    selector: 'input[type="search"]'
  }
  {
    command: 'sitename'
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
  {
    command: 'if'
    selector: 'button:contains(Select Free)'
  }


]
