Just run vagrant up  

our app foodie:http://localhost:8080/  

Missible features:   
1 our image upload only allow jpeg, jpg, png, and gif. mulitple pic can be selected and uploaded  
2 our service features signup email confirmation, the guest access is set for 10 days to allow easy marking, 
the emails can be traced using mailcatcher, we did not provide this because this is not part of our project
and mailcatcher has to be ran at local machine.  
3. only posts display hex url address to avoid tracking of post ID  
4. our service feature fully functional user authentication, account edition and deletion.  
5. our service features strong stypes on form to provide better security.  

Problem: When adding friends, after clicking the search button, the add firend control panel doesn't show up
and requires click on the provided refresh button. This problem is caused by caching and only happens when running in vagrant.
The function works without bug in local development.


google map API key = AIzaSyBTcV5mNObqk8XvaK9ZMnXbD6EFhB0lK1s
