fs = require('fs')
consolex = require('./console-xtra')

# -------------------- Get random account ----------------------------

exports.getAccount = (accounts, accountType) ->
  # Random wordpress account details
  tempRandomAccount =
    username: ''
    password: ''
    site: ''
  tempAccArray = accounts.filter (el) ->
    el.accountType == accountType
  if (tempAccArray.length > 0)
    randomAcc = Math.floor(Math.random() * tempAccArray.length)
    tempRandomAccount.username = tempAccArray[randomAcc].loginID
    tempRandomAccount.password = tempAccArray[randomAcc].password
    tempRandomAccount.site = tempAccArray[randomAcc].siteName
  else
    tempRandomAccount.username = 'no accounts'
  tempRandomAccount  # Return a random account

# -------------------- Create new spun article ----------------------------

spinner = (x) ->
  tempStr = ''
  tempSpinner = x.split( /\{([^}]+)\}/ )
  y = 0
  while y < tempSpinner.length
    temp3 = tempSpinner[y].split( "|" )
    tempStr += temp3[Math.floor(temp3.length*Math.random())]
    ++y
  tempStr

spinnerLoop = (x) ->
  tempArray = []
  y = 0
  while y < x.length
    tempArray[y] = spinner(x[y])
    ++y
  tempArray

exports.getArticle = (articles, microBlog, noHTML) ->
  # Create spun article
  a = Math.floor(articles.length*Math.random())
  newArticle =
    title: ''
    body: ''
    keywords: []
    links: []
    images: []

  if a >= articles.length
    a = articles.length - 1

  # Spin article title
  consolex.log 'blue', 'Spinning title for article # ' + a + '...'
  newArticle.title = spinner(articles[a].title)

  # Spin article keywords
  consolex.log 'blue', 'Spinning keywords for article # ' + a + '...'
  newArticle.keywords = spinnerLoop(articles[a].keywords)

  # Spin article links
  consolex.log 'blue', 'Spinning links for article # ' + a + '...'
  newArticle.links = spinnerLoop(articles[a].links)

  # Spin article images
  consolex.log 'blue', 'Spinning images for article # ' + a + '...'
  newArticle.images = spinnerLoop(articles[a].images)

  # Spin article body / description
  consolex.log 'blue', 'Spinning body of article # ' + a + '...'
  if microBlog
    temp = articles[a].description
  else
    temp = articles[a].body
  newArticle.body = spinner(temp)
  if noHTML
    newArticle.body = newArticle.body.replace('<br>', '\n')

  # Insert random links
  consolex.log 'blue', 'Inserting random links in article # ' + a + '...'
  if !noHTML
    # Insert random links with random keywords in body
    tempIndex = 0
    while tempIndex < newArticle.keywords.length # Check for empty string
      if newArticle.keywords[tempIndex].trim().length == 0
        newArticle.keywords.splice(tempIndex, 1)
      ++tempIndex
    if newArticle.keywords.length == 0 # If no keywords
      newArticle.keywords[0] = 'here'
    if (newArticle.body.indexOf("#links#")) == -1 # No link tags
      newArticle.body += ' #links#'
    while (newArticle.body.indexOf("#links#")) != -1
      tempRandom = Math.floor(Math.random()*newArticle.links.length)
      randomLink = newArticle.links[tempRandom]
      tempRandom = Math.floor(Math.random()*newArticle.keywords.length)
      randomKeyword = newArticle.keywords[tempRandom]
      tempLink = ' <a href="' + randomLink.toString().trim() + '">' +
        randomKeyword.toString().trim() + '</a> '
      newArticle.body = newArticle.body.replace('#links#', tempLink)
  else
    # Remove link tags
    newArticle.body = newArticle.body.replace('#links#', ' ')
    # Insert random link at end of body
    temp = Math.floor(Math.random()*newArticle.links.length)
    randomLink = newArticle.links[temp]
    newArticle.body += (' ' + randomLink)

  # Add random image in a random position of body
  if !noHTML
    consolex.log 'blue', 'Inserting random image in article # ' + a + '...'
    temp = newArticle.body.length
    floatPos = ['style="float:right"','style="float:left"']
    randomFloat = Math.round(Math.random())
    randomPos = Math.ceil(Math.random() * temp)
    randomImage = Math.floor(Math.random() * newArticle.images.length)
    # Split body and insert image. Make sure not splitting a word
    while newArticle.body.charAt(randomPos-1) != ' '
      randomPos = Math.ceil(Math.random() * temp)
    temp1 = newArticle.body.slice(0, randomPos)
    temp2 = '<img src="' + newArticle.images[randomImage] + '" ' +
      floatPos[randomFloat] + '>'
    temp3 = newArticle.body.slice(randomPos, temp)
    newArticle.body = temp1 + temp2 + temp3

  consolex.log 'magenta', 'Created article: ' + newArticle.title
  newArticle # Return the article to submit

exports.getProfile = (profiles, noHTML) ->
  # Create spun profile
  a = Math.floor(profiles.length*Math.random())
  if a >= profiles.length
    a = profiles.length - 1
  newProfile =
    username: ''
    password: ''
    sitename: ''
    email: profiles[a].email
    profile: ''
    keywords: []
    links: []

  # Spin profile username
  consolex.log 'blue', 'Spinning username for profile # ' + a + '...'
  newProfile.username = spinner(profiles[a].username)

  # Spin profile password
  consolex.log 'blue', 'Spinning password for profile # ' + a + '...'
  newProfile.password = spinner(profiles[a].password)

  # Spin profile sitename
  consolex.log 'blue', 'Spinning sitename for profile # ' + a + '...'
  newProfile.sitename = spinner(profiles[a].sitename)

  # Spin profile keywords
  consolex.log 'blue', 'Spinning keywords for profile # ' + a + '...'
  newProfile.keywords = spinnerLoop(profiles[a].keywords)

  # Spin profile links
  consolex.log 'blue', 'Spinning links for profile # ' + a + '...'
  newProfile.links = spinnerLoop(profiles[a].links)

  # Spin profile
  consolex.log 'blue', 'Spinning profile # ' + a + '...'

  newProfile.profile = spinner(profiles[a].profile)
  if noHTML
    newProfile.profile = newProfile.profile.replace('<br>', '\n')

  # Insert random links
  consolex.log 'blue', 'Inserting random links in profile # ' + a + '...'
  if !noHTML
    # Insert random links with random keywords in profile
    tempIndex = 0
    while tempIndex < newProfile.keywords.length # Check for empty string
      if newProfile.keywords[tempIndex].trim().length == 0
        newProfile.keywords.splice(tempIndex, 1)
      ++tempIndex
    if newProfile.keywords.length == 0 # If no keywords
      newProfile.keywords[0] = 'here'
    if (newProfile.profile.indexOf("#links#")) == -1 # No link tags
      newProfile.profile += ' #links#'
    while (newProfile.profile.indexOf("#links#")) != -1
      tempRandom = Math.floor(Math.random()*newProfile.links.length)
      randomLink = newProfile.links[tempRandom]
      tempRandom = Math.floor(Math.random()*newProfile.keywords.length)
      randomKeyword = newProfile.keywords[tempRandom]
      tempLink = ' <a href="' + randomLink.toString().trim() + '">' +
        randomKeyword.toString().trim() + '</a> '
      newProfile.profile = newProfile.profile.replace('#links#', tempLink)
  else
    # Remove link tags
    newProfile.profile = newProfile.profile.replace('#links#', ' ')
    # Insert random link at end of body
    temp = Math.floor(Math.random()*newProfile.links.length)
    randomLink = newProfile.links[temp]
    newProfile.profile += (' ' + randomLink)

  consolex.log 'magenta', 'Created profile: ' + newProfile.username
  newProfile  # Return the profile to create
