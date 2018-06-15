require "lazy_find/version"
require "lazy_find/active_record/finder_methods"

ActiveRecord::Base.extend(LazyFind::ActiveRecord::FinderMethods) if defined?(ActiveRecord)
