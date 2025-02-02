# @summary This is a repo class for apt
#
# @api private
class mongodb::repo::apt inherits mongodb::repo {
  # we try to follow/reproduce the instruction
  # from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

  include apt

  if($mongodb::repo::ensure == 'present' or $mongodb::repo::ensure == true) {
    apt::source { 'mongodb':
      location => $mongodb::repo::location,
      release  => $mongodb::repo::release,
      repos    => $mongodb::repo::repos,
      key      => {
        'id'      => $mongodb::repo::key,
        'server'  => $mongodb::repo::key_server,
        'options' => $mongodb::repo::aptkey_options,
      },
    }

    Apt::Source['mongodb'] -> Class['apt::update'] -> Package<| tag == 'mongodb_package' |>
  }
  else {
    apt::source { 'mongodb':
      ensure => absent,
    }
  }
}
