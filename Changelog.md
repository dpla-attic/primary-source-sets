1.7.8 (24 Aug 2016)
---
* Pin DPLibary gem to v0.1
* Change gif it up link in main menu
* Track click through events with Google Analtyics

1.7.7 (29 Jul 2016)
---
* Add link to Searching DPLA in main nav

1.7.6 (7 Jul 2016)
---
* Add link to tech wiki in main nav

1.7.5 (6 Jul 2016)
---
* Remove nav links to bookshelf

1.7.4 (14 Jun 2016)
---
* Add view fragment caching

1.7.3 (2 Jun 2016)
---
* Fix order by db call for postgresql

1.7.2 (1 Jun 2016)
---
* Fix tag order in dropdown menu

1.7.1 (1 Jun 2016)
---
* SQL optimization & caching

1.7.0 (23 May 2016)
---
* Configure Rails cache_store
* Add support for cache_store sessions

1.6.3 (12 May 2016)
---
* Add .json views for set, source, and guide
* Embed JSON-LD in HTML
* Refactor DPLA item
* Inform user when item not available in DPLA

1.6.2 (4 May 2016)
---
* Add Twitter widget JavaScript library
* Add tests to application helper

1.6.1 (3 May 2016)
---
* Use CSS for dimensional manaipulations
* Custom language for auto-generated twitter post
* Fix set tile size and background color
* Add content jumplinks
* Fix link to apps in footer
* Allow basic controller tests to run
* Add error message for media if JavaScript is disabled

1.6.0 (20 Apr 2016)
---
* Enable SSL
* Change location of DPLibrary gem
* Render guide markdown on source show view
* Lock phantomjs gem to v1.9.8

1.5.5 (14 April 2016)
---
* Access external JavaScript files with https
* Add links to new objects in admin show views

1.5.4 (8 April 2016)
---
* Add missing javascript file on sets index view

1.5.3 (8 April 2016)
---
* Track use of hubs' materials in Google Analytics
* Add social media button to sets index view

1.5.2 (7 April 2016)
---
* Add social media share buttons
* Change descriptive text on sets index view
* Add analysis tools text on source show view
* Only show published sets in releated sets carousel
* Add checkboxes to add/remove guides and sets on author form
* Add spacing to tables in "Admin Info" sections of views
* New links for managing relationship between objects
* Update nav bar

1.5.1 (31 March 2016)
---
* Add admin username
* Valiate aggregation datatype
* User defer attribute with JavaScripts

1.5.0 (17 March 2016)
---
* Rename sequences table
* Change header text for related sets and sources

1.4.0 (16 March 2016)
---
* Add DPLibrary gem and API key setting
* Add ApiQuerier concern and provider link resource
* Add default thumbnails
* Allow admins to order tags within vocaubularie

1.3.3 (15 March 2016)
---
* Add back links on source pages
* Add URI validation and helper text to tag & vocab forms

1.3.2 (9 March 2016)
---
* Add carousel for related sets
* Order sets by published date by defualt
* Add posters for sets and guides
* Pin rake version to less than 11.0

1.3.1 (7 March 2016)
---
* Remove obsolete tag setting
* Tailor views for reviewers
* Update instructions to create admin account
* Add carousel of related sources
* Fix margins on mobile layout
* Refactor source_set model methods
* Add expansible menus on admin forms
* Hide resort button when filter selected
* Fix failing helper test

1.3.0 (27 January 2016)
---
* Add account management
* Add account permissions
* Fix CSS for Primary Source Sets header

1.2.7 (20 January 2016)
---
* Hyperlink Primary Source Sets header

1.2.6 (20 January 2016)
---
* Tweak CSS for tags

1.2.5 (19 January 2016)
---
* Add filter feature to public UI

1.2.4 (14 January 2016)
---
* Change working in sort by menu

1.2.3 (13 January 2016)
---
* Fix default settings
* Fix bug causing order and tags params to override one another

1.2.2 (13 January 2016)
---
* Render mobile layout
* Fix menu button for small windows
* Add meta elements to layout
* Order sets by date_created or year
* Show and filter by tags on public user interface

1.2.1 (11 January 2016)
---
* Fix double-encoding of characters in titles
* Remove obsolete data-turbolinks-track attributes
* Fix "404 Not Found" errors for assets

1.2.0 (4 January 2016)
---
* Replace lightbox2-rails with OpenSeadragon
* Move author list from helper to model concern
* Move source_name helper to source model
* Move javascripts to bottom of rendered HTML pages
* Add specs that test if views render
* Set up and run CodeClimate to check code coverage
* Correct json-ld examples
* Fix validation specs for media assets

1.1.5 (22 December 2015)
---
* Style admin forms
* Add copyright license

1.1.4 (21 December 2015)
---
* Publish all existing sets

1.1.3 (21 December 2015)
---
* Add unpublished attribute to source_sets
* Add date attribute to source_sets
* Update README with testing instructions
* Improve use of global vars in Jasmine tests
* Add tag and vocabulary tables
* Allow creation of media assets with specified sources
* Refactor methods out of ApplicaitonController

1.1.2 (8 December 2015)
---
* Reduce whitespace on guide UI
* Add save buttons to tops of forms

1.1.1 (7 December 2015)
---
* Update menu
* Do not return nil assets in Source#asset
* Fix title style and content spacing in UI

1.1.0 (3 November 2015)
---
* Add S3 documentation
* Set height and width for textareas
* Add title, description, and canonical link tags
* Remove dpla_frontend_assets gem

1.0.5 (20 October 2015)
---
* Add turnout gem

1.0.4 (20 October 2015)
---
* Fix education outreach link

1.0.3 (20 October 2015)
---
* Add education to top-level menu
* Small presentational changes to UI

1.0.2 (20 October 2015)
---
* Fix sign-in page server error

1.0.1 (19 October 2015)
---
* Small presentational changes to UI and static content

1.0.0 (19 October 2015)
---
* Allow public access
* Disable context menu on lightbox links

0.3.3 (16 October 2015)
---
* Additional styling for public-facing pages
* Breadcrumbs
* Image and PDF viewers
* Google analytics tracking
* Fix database dependencies

0.3.2 (15 October 2015)
---
* Jasmine for JavaScript specs
* Refactor JavaScript
* Add dpla-branded styling
* Order sources, sets, and assets on admin views
* Fix bugs related to data entry interfaces

0.2.0 (28 September 2015)
---
* CRUD interfaces for source, guide, author
* FriendlyID slugs for set, guide
* Tighten gem dependencies
* Authorization with devise gem
* Shallow routes for source, guide
* Add rubocop
* Add markdown fields
* Add credits, citation to source
* Update JSON-LD sample docs and add linter

0.1.0 (3 September 2015)
---

* Initial public release
