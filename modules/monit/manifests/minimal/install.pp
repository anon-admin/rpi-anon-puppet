class monit::minimal::install {
  
  package { "monit":
    ensure  => latest,
  }

}