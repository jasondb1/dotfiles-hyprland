#!/usr/bin/env python
"""
    small script to check for unread count on imap inbox
"""
import imaplib

IMAPSERVER = 'smtp.mail.me.com'
USER = 'jasondb10@icloud.com'
PASSWORD = '~Dtiyp4a'

try:
    mail = imaplib.IMAP4_SSL(IMAPSERVER)
    mail.login(USER, PASSWORD)
    mail.select("inbox", True) # connect to inbox.
    return_code, mail_ids = mail.search(None, 'UnSeen')
    count = len(mail_ids[0].split(" "))
except:
    count = 0

print(count)

