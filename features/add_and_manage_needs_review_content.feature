@api
Feature: Add and Manage service guide content for the 'Needs Review' rss-feed view

@javascript
Scenario: Use chosen widget to select navigation topic and save content as a new 'Draft'
  Given I am logged in as a user with the "administrator" role
  And I am on "/node/add/page"
  And I fill in "Title" with randomized text "apax"
  And I click on '.chosen-single' element
  And I fill in ".chosen-search input" element with "urban county council"
  And I press "List additional actions"
  And I press "Save and Create New Draft"
  Then the url should match "apax"
  ## Make sure the chosen widget worked
  And I should see the link "Urban County Council"

Scenario: Check rss view page display to confirm that service guide 'apax' is not in the display
  Given I am logged in as a user with the "administrator" role
  And I am on /content-needing-review
  ## Make sure that 'apax' isn't showing in the display yet
  Then I should not see the link "apax"

Scenario: Edit recent service guide to have moderation status of 'Needs Review', and confirm it is in the page display
  Given I am logged in as a user with the "administrator" role
  And I visit "/apax"
  And I click "Edit Draft"
  And I press "List additional actions"
  And I press "Save and Request Review"
  When I visit "/content-needing-review"
  ## Make sure that 'apax' is showing in the display
  Then I should see the link "apax"

Scenario: Use chosen widget to select navigation topic and save content as 'Needs Review'
  Given I am logged in as a user with the "administrator" role
  And I am on "/node/add/page"
  And I fill in "Title" with randomized text "apax123"
  And I click on '.chosen-single' element
  And I fill in ".chosen-search input" element with "urban county council"
  And I press "List additional actions"
  And I press "Save and Request Review"
  Then the url should match "apax123"
  ## Make sure the chosen widget worked
  And I should see the link "Urban County Council"

Scenario: Check rss view page display to confirm that service guide 'apax123' is in the display
  Given I am logged in as a user with the "administrator" role
  And I am on /content-needing-review
  ## Make sure that 'apax123' is showing in the display
  Then I should see the link "apax123"

Scenario: Edit 'apax' and keep the content in review
  Given I am logged in as a user with the "administrator" role
  And I am on "/content-needing-review"
  Then I should see the link "apax"
  When I visit "/apax"
  And I click "Edit Draft"
  And I press "List additional actions"
  And I press "Save and Keep in Review"
  Then the url should match "apax"
  ## Make sure 'apax' remained on the /content-needing-review rss view page display
  When I visit "/content-needing-review"
  Then I should see the link "apax"

Scenario: Edit 'apax123' and publish the content
  Given I am logged in as a user with the "administrator" role
  And I am on "/content-needing-review"
  Then I should see the link "apax123"
  When I visit "/apax123"
  And I click "Edit Draft"
  And I press "List additional actions"
  And I press "Save and Publish"
  Then the url should match "apax"
  ## Make sure 'apax123' did not remain on the /content-needing-review rss view page display
  When I visit "/content-needing-review"
  Then I should not see the link "apax123"

Scenario: Edit 'apax' and send back to draft
  Given I am logged in as a user with the "administrator" role
  And I am on "/content-needing-review"
  Then I should see the link "apax"
  When I visit "/apax"
  And I click "Edit Draft"
  And I press "List additional actions"
  And I press "Save and Send back to Draft"
  Then the url should match "apax"
  ## Make sure 'apax' did not remain on the /content-needing-review rss view page display
  When I visit "/content-needing-review"
  Then I should not see the link "apax"
