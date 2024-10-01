require 'awesome_print'
AwesomePrint.pry!

# turn of . shell commands in pry to allow for multi-line pasting such as:
#
# begin
# User
#   .where(status: 'active')
#   .where.not(email: nil)
#   .all
# end
Pry.commands.delete '.<shell command>'
