class package_sysvinit_ {
  package { "sysvinit":
  }

}

class package_apt_ {
  package { "apt":
  }

}


class package_wget_ {
  package { "wget":
  }

}

class package_cron_ {
  package { "cron":
  }

}
class service_cron_ inherits package_cron_{
  service { "cron":
  }

}