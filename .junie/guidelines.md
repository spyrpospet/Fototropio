# Project Guidelines

* Backend: Ruby on Rails with hotwire
* Frontend: haml, stimulusjs, tailwindcss
* Database: PostgreSQL
* Testing: Minitest

# Instructions

* Do test driven development.
* Use Ruby on rails coding best practices and conventions.
* Use hotwire and stimulusjs best coding practices and conventions.
* Prefer object oriented programming.
* When you write haml dont use the default syntax like .foo but instead do %div{class:'foo'}
* Always check for bugs and if the code works.
* Always check for performance and security issues.
* The code must be clean, reusable, readable and easy to understand.
* For static text always use t(''), for dynamic text use t('foo', bar: 'baz)
* Always create integration tests, run them and fix any errors.
* To run test dont use "bin/rails" but instead use "rails"
* When editing or creating a feature also write integration and unit tests for it and run them.
* If meilisearch needs to run for testing you can use it by running "meilisaerch/meilisearch.exe"