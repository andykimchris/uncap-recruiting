### QUESTION: Explain the roles of user.rb, user_profile.rb, and user_permission.rb

user.rb
- Creates a founder and authenticates using devise. Saves information about a user and generates connections including their profile, organization statuses and application. It also handles authorization of a user by checking password validity and email confirmation. 

user_profile.rb
- Attaches information about a founder including their names, gender and avatars. Gender information is stored using abstract data structure OpenStruct to speed up attribute access.

user_permission.rb 
- Handles associations for a user i.e organizations a given user is part of and permissions they have access to. 

