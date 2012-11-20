# What's Rack::Store
Rack::Store is a Rack middleware what makes the env accessible anywhere while a request.

# Usage
```ruby
# config.ru
use Rack::Store

# In your rack application (e.g., Rails, Sinatra)
Rails.logger.debug "User-Agent: #{Rack::Store.env['HTTP_USER_AGENT']}"
```

# License
Rack::Store is released under the MIT license:
* www.opensource.org/licenses/MIT

Copyright (c) 2012 Issei Naruta