# coffeelint: disable=max_line_length

exports.name = 'wikia'
exports.url = 'https://www.wikia.com/signin'
exports.steps = [
  {
    command: 'create-article'
    micro: false
    noHTML: true
    noLinks: false
  }
  {
    command: 'viewport-size'
    width: 840
    height: 480
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '#loginForm'
  }
  {
    command: 'login'
    form: '#loginForm'
    username: '#loginUsername'
    password: '#loginPassword'
    submit: false
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'click'
    selector: '#loginSubmit'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait-for'
    selector: 'body > div.top-nav > div > div.user-state.hide-for-mobile > div.authenticated > a'
  }
  {
    command: 'click'
    selector: 'body > div.top-nav > div > div.user-state.hide-for-mobile > div.authenticated > a'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait'
    selector: '#UserProfileMasthead > div.masthead-info > div.masthead-info-lower > ul.wikis > ul > li > a'
  }
  {
    command: 'click'
    selector: '#UserProfileMasthead > div.masthead-info > div.masthead-info-lower > ul.wikis > ul > li > a'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait'
    selector: '#WikiaUserPagesHeader > div > ul > li:nth-child(3) > a'
  }
  {
    command: 'click'
    selector: '#WikiaUserPagesHeader > div > ul > li:nth-child(3) > a'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait-for'
    selector: 'a[data-id="createblogpost"]'
  }
  {
    command: 'click'
    selector: 'a[data-id="createblogpost"]'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: 'input[name="wpTitle"]'
  }
  {
    command: 'title'
    selector: 'input[name="wpTitle"]'
  }
  {
    command: 'press-enter'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'if'
    selector: '#ca-edit'
  }
  {
    command: 'click'
    selector: '#ca-edit'
  }
  {
    command: 'end-if'
  }
  {
    command: 'wait-for'
    selector: '#wpTextbox1'
  }
  {
    command: 'body'
    selector: '#wpTextbox1'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'click'
    selector: '#wpSave'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: 'a:contains(Wiki Activity)'
  }
  {
    command: 'click'
    selector: 'a:contains(Wiki Activity)'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '#myhome-activityfeed > li:nth-child(1) > strong > a'
  }
  {
    command: 'save-href'
    selector: '#myhome-activityfeed > li:nth-child(1) > strong > a'
    domain: true
  }
  {
    command: 'click'
    selector: 'a[data-id="logout"]'
  }
  {
    command: 'wait'
    value: 10000
  }
]