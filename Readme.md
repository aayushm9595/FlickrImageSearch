
# FlickrImageSearch

Following project is an image search app, using flick API. 
Supported on latest XCode, Swift 5

Download link is configurable and can be key can be set in AppCredentials. 
It's left as singleton for all classes to share and update any information on it

The classes in model are structured as follows:-

<li>PhotoSearchRootResponse  (intial JSON response from data task)</li>
<li>PhotoSearchPageResponse (by default the response given is for page 1)</li>
--> This stores info about number of pages available on a given search, images perpage, total images and photos
<li> PhotoSearchModel (Actual Image to be displayed in cell)</li>

## Improvements That can be made

<li> Image Caching can be implemented further to improve loading time of previous searches </li>
<li> Custom Collection view layout can be implemented further to display cells in different height based on their aspect ratios inorder to improve layout </li>


