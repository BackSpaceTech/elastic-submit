fs = require('fs')
consolex = require('./console-xtra')

exports.indexers = (filePath) ->
  # Load Indexer.txt
  tempIndexers = []
  status = ''
  if fs.exists(filePath) and fs.isFile(filePath)
    ins = fs.open(filePath, 'r')
    a = -1
    while !ins.atEnd()
      buffer = ins.readLine()
      temp = buffer.trim()
      if temp == '#name#'
        status = 'name'
        ++a
        tempIndexers[a] = {
          name: ''
          username: ''
          password: ''
          status: ''
        }
      else if temp == '#username#'
        status = 'username'
      else if temp == '#password#'
        status = 'password'
      else if temp == '#status#'
        status = 'status'
      else if status == 'name'
        tempIndexers[a].name = temp
        status = ''
      else if status == 'username'
        tempIndexers[a].username = temp
        status = ''
      else if status == 'password'
        tempIndexers[a].password = temp
        status = ''
      else if status == 'status'
        tempIndexers[a].status = temp
        status = ''
    ins.close()
    a = 0
    temp2 = 0
    tempIndexers2 = []
    for i in [0...tempIndexers.length]
      if tempIndexers[i].status.toLowerCase() == 'ok'
        tempIndexers2[temp2] = tempIndexers[i]
        ++temp2
    tempIndexers2 # Return Indexer
  else
    console.log 'Could not load ' + filePath

exports.services = (filePath) ->
  # Load Indexer.txt
  tempServices = []
  status = ''
  if fs.exists(filePath) and fs.isFile(filePath)
    ins = fs.open(filePath, 'r')
    a = -1
    while !ins.atEnd()
      buffer = ins.readLine()
      temp = buffer.trim()
      if temp == '#name#'
        status = 'name'
        ++a
        tempServices[a] = {
          name: ''
          status: ''
        }
      else if temp == '#status#'
        status = 'status'
      else if status == 'name'
        tempServices[a].name = temp
      else if status == 'status'
        tempServices[a].status = temp
    ins.close()
    a = 0
    tempServices # Return Articles
  else
    console.log 'Could not load ' + filePath

exports.accounts = (filePath) ->
  # Load accounts.csv
  tempAccounts = []
  if fs.exists(filePath) and fs.isFile(filePath)
    consolex.log 'blue', 'Loading user accounts...'
    ins = fs.open(filePath, 'r')
    a = 0
    while !ins.atEnd()
      buffer = ins.readLine()
      temp = buffer.split(/\s*,\s*/)
      tempAccounts[a] = {
        accountType: temp[0]
        loginID: temp[1]
        password: temp[2]
        siteName: temp[3]
      }
      ++a
    tempAccounts  # Return accounts
  else
    console.log 'Could not load ' + filePath

exports.articles = (filePath) ->
  # Load Articles.txt
  tempArticles = []
  articleStatus = ''
  firstLine = false
  if fs.exists(filePath) and fs.isFile(filePath)
    consolex.log 'blue', 'Loading articles...'
    ins = fs.open(filePath, 'r')
    a = -1
    while !ins.atEnd()
      buffer = ins.readLine()
      temp = buffer.trim()
      if temp == '#Title'
        articleStatus = 'title'
        ++a
        tempArticles[a] = {
          title: ''
          description: ''
          body: ''
          keywords: ''
          links: ''
          images: ''
        }
      else if temp == '#Body'
        articleStatus = 'body'
        firstLine = true
      else if temp == '#Keywords'
        articleStatus = 'keywords'
      else if temp == '#Links'
        articleStatus = 'links'
      else if temp == '#Images'
        articleStatus = 'images'
      else if articleStatus == 'title'
        tempArticles[a].title += temp
      else if articleStatus == 'body'
        if firstLine and temp != ''
          tempArticles[a].description = temp + '<br>'
          firstLine = false
        tempArticles[a].body += temp + '<br>'
      else if articleStatus == 'keywords'
        temp = buffer.split(/\s*,\s*/)
        tempArticles[a].keywords = temp
      else if articleStatus == 'links'
        temp = buffer.split(/\s*,\s*/)
        tempArticles[a].links = temp
      else if articleStatus == 'images'
        temp = buffer.split(/\s*,\s*/)
        tempArticles[a].images = temp
    ins.close()
    a = 0
    tempArticles # Return Articles
  else
    console.log 'Could not load ' + filePath

exports.profiles = (filePath) ->
  # Load Profiles.txt
  tempProfiles = []
  profileStatus = ''
  if fs.exists(filePath) and fs.isFile(filePath)
    consolex.log 'blue', 'Loading profiles...'
    ins = fs.open(filePath, 'r')
    a = -1
    while !ins.atEnd()
      buffer = ins.readLine()
      temp = buffer.trim()
      if temp == '#Username'
        profileStatus = 'username'
        ++a
        tempProfiles[a] = {
          username: ''
          password: ''
          email: ''
          profile: ''
          links: ''
          keywords: ''
        }
      else if temp == '#Password'
        profileStatus = 'password'
      else if temp == '#Email'
        profileStatus = 'email'
      else if temp == '#Sitename'
        profileStatus = 'sitename'
      else if temp == '#Profile'
        profileStatus = 'profile'
      else if temp == '#Keywords'
        profileStatus = 'keywords'
      else if temp == '#Links'
        profileStatus = 'links'
      else if profileStatus == 'username'
        tempProfiles[a].username += temp
      else if profileStatus == 'password'
        tempProfiles[a].password += temp
      else if profileStatus == 'email'
        tempProfiles[a].email += temp
      else if profileStatus == 'sitename'
        tempProfiles[a].sitename += temp
      else if profileStatus == 'profile'
        tempProfiles[a].profile += temp + '<br>'
      else if profileStatus == 'keywords'
        temp = buffer.split(/\s*,\s*/)
        tempProfiles[a].keywords = temp
      else if profileStatus == 'links'
        temp = buffer.split(/\s*,\s*/)
        tempProfiles[a].links = temp
    ins.close()
    a = 0
    tempProfiles # Return Profiles
  else
    console.log 'Could not load ' + filePath
