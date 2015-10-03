        
class userids::conf::users {

  define cleanFile($user,$file) {
    exec { "cp /etc/${file} ./${file} && grep -v \'^${user}:\' ./${file} >/etc/${file}":
      provider => shell,
      cwd      => '/root',
      onlyif   => "grep -q \'^${user}:\' /etc/${file}",
    }
  }
  
  define delLocal {
    $user = $name
    userids::conf::users::cleanFile{ "passwd $user":
      user => $user,
      file => "passwd",
    }
    userids::conf::users::cleanFile{ "passwd- $user":
      user => $user,
      file => "passwd-",
    }
    userids::conf::users::cleanFile{ "group $user":
      user => $user,
      file => "group",
    }
    userids::conf::users::cleanFile{ "group- $user":
      user => $user,
      file => "group-",
    }
    
  }

}




