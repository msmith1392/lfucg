@api
Feature: Add and Manage service guide content for the 'Needs Review' rss-feed view

@javascript
Scenario: Save content as a draft, check to see it IS NOT on page /content-needing-review,
  Edit content to 'needs review' and check that it IS on page /content-needing-review
  Given I am logged in as a user with the "administrator" role
  And I am on "/node/add/page"
  And I fill in "Title" with "apax"
  And I click on '.chosen-single' element
  And I fill in ".chosen-search input" element with "urban county council"
  And I press "List additional actions"
  And I press "Save and Create New Draft"
  Then the url should match "apax"
  ## Make sure the chosen widget worked
  And I should see the link "Urban County Council"
  And I am on "/content-needing-review"
  ## Make sure that 'apax' IS NOT showing in the display yet
  Then I should not see the link "apax"
  And I am on "/apax"
  And I click "Edit draft"
  And I press "List additional actions"
  And I press "Save and Request Review"
  When I am on "/content-needing-review"
  ## Make sure that 'apax' IS showing in the display
  Then I should see the link "apax"

#Scenario: Save content as 'Needs Review', check to see it IS on page /content-needing-review,
#Edit content to 'send back to draft' and check that it IS NOT on page /content-needing-review
#  Given I am logged in as a user with the "administrator" role
#  And I am on "/node/add/page"
#  And I fill in "Title" with "apaxsoftware"
#  And I click on '.chosen-single' element
#  And I fill in ".chosen-search input" element with "urban county council"
#  And I press "List additional actions"
#  And I press "Save and Request Review"
#  Then the url should match "apaxsoftware"
#  ## Make sure the chosen widget worked
#  And I should see the link "Urban County Council"
#  And I am on "/content-needing-review"
#  ## Make sure that 'apaxsoftware' IS showing in the display
#  Then I should see the link "apaxsoftware"
#  And I am on "/apaxsoftware"
#  And I click "Edit draft"
#  And I press "List additional actions"
#  And I press "Save and Publish"
#  When I am on "/content-needing-review"
#  ## Make sure that 'apaxsoftware' IS NOT showing in the display
#  Then I should not see the link "apaxsoftware"

#Scenario: Edit 'apax' and keep the content in review
#  Given I am logged in as a user with the "administrator" role
#  And I am on "/content-needing-review"
#  Then I should see the link "apax"
#  When I am on "/apax"
#  And I click "Edit Draft"
#  And I press "List additional actions"
#  And I press "Save and Keep in Review"
#  Then the url should match "apax"
#  ## Make sure 'apax' remained on the /content-needing-review rss view page display
#  When I am on "/content-needing-review"
#  Then I should see the link "apax"
#
#Scenario: Edit 'apax123' and publish the content
#  Given I am logged in as a user with the "administrator" role
#  And I am on "/content-needing-review"
#  Then I should see the link "apax123"
#  When I am on "/apax123"
#  And I click "Edit Draft"
#  And I press "List additional actions"
#  And I press "Save and Publish"
#  Then the url should match "apax"
#  ## Make sure 'apax123' did not remain on the /content-needing-review rss view page display
#  When I am on "/content-needing-review"
#  Then I should not see the link "apax123"
#
#Scenario: Edit 'apax' and send back to draft
#  Given I am logged in as a user with the "administrator" role
#  And I am on "/content-needing-review"
#  Then I should see the link "apax"
#  When I am on "/apax"
#  And I click "Edit Draft"
#  And I press "List additional actions"
#  And I press "Save and Send back to Draft"
#  Then the url should match "apax"
#  ## Make sure 'apax' did not remain on the /content-needing-review rss view page display
#  When I am on "/content-needing-review"
#  Then I should not see the link "apax"
