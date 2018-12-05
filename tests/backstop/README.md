#Visual regression tests

Visual regression tests are powered by backstopjs and executed using a headless
chrome instance.

Ressources:
 - https://garris.github.io/BackstopJS/
 - https://github.com/garris/BackstopJS#the-backstopjs-workflow

## Run tests

Within the backstop folder: 

    # Run the tests. This puts a report in ...
    ./run.sh test
    
    # When the reference should be updated.
    ./run.sh reference

    # If you want to approve a failed test after some changes, run: 
    ./run.sh approve`

Or if you want to test/approve with a different URL:
    
    # Run the tests. This puts a report in ...
    BASE_URL=http://base_url.to.test ./run.sh test

    # If you want to approve a failed test after some changes, run: 
    BASE_URL=http://baseurl.to.test ./run.sh approve`
