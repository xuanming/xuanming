module Freeze
  # Freeze version
  VERSION_MAJOR = 0
  VERSION_MINOR = 0
  VERSION_BUILD = 0
  VERSION_PRE   = nil
  VERSION       = [VERSION_MAJOR, VERSION_MINOR, VERSION_BUILD, VERSION_PRE].compact.join(".")
end
