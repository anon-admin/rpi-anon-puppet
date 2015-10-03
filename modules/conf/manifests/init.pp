# Class: conf
#
# This module manages conf
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class conf {

  contain conf::sysvinit
  include conf::cron
  include conf::apt

}

class group_root {
  group { "root":
    gid => 0,
  }
  
}
        
class conf_users {

  define conf_user_cleanFile($user,$file) {
    exec { "cp /etc/${file} ./${file} && grep -v \'^${user}:\' ./${file} >/etc/${file}":
      provider => shell,
      cwd      => '/root',
      onlyif   => "grep -q \'^${user}:\' /etc/${file}",
    }
  }
  
  define conf_user_delLocal {
    $user = $name
    conf_user_cleanFile{ "passwd $user":
      user => $user,
      file => "passwd",
    }
    conf_user_cleanFile{ "passwd- $user":
      user => $user,
      file => "passwd-",
    }
    conf_user_cleanFile{ "group $user":
      user => $user,
      file => "group",
    }
    conf_user_cleanFile{ "group- $user":
      user => $user,
      file => "group-",
    }
    
  }

}




