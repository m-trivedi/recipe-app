### Introduction

Hi! I'm Mihir and I'm super excited to present my implementation of the Recipe App. I'm a senior graduating this May from the University of Wisconsin-Madison.

### Summary: Include screen shots or a video of your app highlighting its features

<img src = "https://raw.githubusercontent.com/m-trivedi/recipe-app/refs/heads/main/Screenshots/IMG_2482.PNG" style = "width: 300px;">
<img src = "https://raw.githubusercontent.com/m-trivedi/recipe-app/refs/heads/main/Screenshots/IMG_2483.PNG" style = "width: 300px;">

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized the networking and caching aspect of the project first since that would be the backbone of the project and help provide a good user experience. After implementing this, I moved on to testing the app to ensure that caching works as intended and that images are retrieved from the cache without performing networking calls. I also focussed on the UI and accessibilty and displayed the recipes as a list that could be searched, and clicked to view more information. Finally, I ensured smooth scrolling and transitions and pull-to-refresh logic.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent 4 hours on the project in multiple sessions, spending about 75% of my time on networking and caching, and the rest on UI, accesibility, and writing tests.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I made the decision to focus on refining the networking call to handle all edge cases and caching the data to disk correctly without relying on third-party solutions. I also utilized dependency injection to pass url provider to the api calls and to help with testing and scalability. I also wrote code that handles errors better and helps with debugging.

In order to focus more on networking and caching, I gave little time to UI animations and finished the UI with a basic list of recipes, and a second page for recipe details, buffering animation for loading, and search.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I believe some parts I could improve on if I had more time than provided would be to clean the cache, include more tests, and utilizing core data to persist informational data along with enabling features such as filtering recipes by cuisine, favouriting/saving recipes, and adding custom notes.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Thanks for inviting me to implement this app :)
