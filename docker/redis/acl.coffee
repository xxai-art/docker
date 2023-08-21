#!/usr/bin/env coffee

> fs > existsSync
  @w5/uridir
  path > dirname join
  @w5/read
  @w5/write
  @w5/utf8/utf8e.js

ROOT = process.argv[2]
{env} = process

gen = (password,file)=>
  if not password
    return
  password = utf8e password.trim()
  HASH = (Buffer.from (await crypto.subtle.digest("SHA-256", password))).toString 'hex'

  PREFIX = "user default on sanitize-payload "
  USER = PREFIX+"##{HASH} ~* &* +@all"
  ACL = join ROOT,"data/#{file}/acl"

  li = []

  to_set = true

  if existsSync(ACL)
    acl = read(ACL).split('\n')
    for i from acl
      if to_set and i.startsWith(PREFIX)
        to_set = false
        li.push USER
      else if i
        li.push i

  if to_set
    li =[USER].concat(li)

  write ACL, li.join('\n')+'\n'


ENV = join ROOT, 'env'


gen env.REDIS_PASSWORD,'redis'
gen env.MQ_PASSWORD,'mq'
