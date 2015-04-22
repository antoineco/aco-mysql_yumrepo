#mysql_yumrepo

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Credits](#credits)

##Overview

The mysql_yumrepo module installs the MySQL Community YUM repository on [RHEL variants](http://en.wikipedia.org/wiki/List_of_Linux_distributions#RHEL-based) including Fedora and SuSE Linux.

##Module description

MySQL Community repositories allow users to get access to the latest MySQL Community releases from Oracle, regardless of their OS version. This module only focuses on systems which use the YUM package manager, ie. RHEL variants and SuSE Linux.

The following repositories will be enabled by default:

* mysql-connectors-community
* mysql-tools-community
* mysql56-community

One can also enable these extra repositories:

* mysql55-community
* mysql57-community-dmr
* mysql-connectors-community-source
* mysql-tools-community-source
* mysql55-community-source
* mysql56-community-source
* mysql57-community-dmr-source

##Setup

mysql_yumrepo will affect the following parts of your system:

* MySQL Community YUM repositories
* MySQL GPG key

Including the main class is enough to get started. It will install the MySQL Community repositories described above.

```puppet
include ::mysql_yumrepo
```

####A couple of examples

Also enable the 'source' repository for MySQL 5.6

```puppet
class { '::mysql_yumrepo':
  enable_56_src => 1
}
```

Disable the GPG signature check

```puppet
class { '::mysql_yumrepo':
  …
  gpgcheck => 0
}
```

##Usage

####Class: `mysql_yumrepo`

Primary class and entry point of the module.

**Parameters within `mysql_yumrepo`:**

#####`gpgcheck`

Switch to perform or not GPG signature checks on repository packages. Defaults to '1'

#####`enable_connectors`

Enable MySQL Connectors repository. Defaults to '1'

#####`enable_tools`

Enable MySQL tools repository. Defaults to '1'

Note: not available on EL 5

#####`enable_55`

Enable MySQL 5.5 repository. Defaults to '0'

Note: only available on EL >= 6

#####`enable_56`

Enable MySQL 5.6 repository. Defaults to '1'

#####`enable_57`

Enable MySQL 5.7 repository. Defaults to '0'

Note: [MySQL 5.7](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/) is currently in development. For use at your own risk.

#####`enable_connectors_src`

Enable MySQL Connectors source repository. Defaults to '0'

#####`enable_tools_src`

Enable MySQL tools source repository. Defaults to '0'

Note: not available on EL 5

#####`enable_55_src`

Enable MySQL 5.5 source repository. Defaults to '0'

Note: only available on EL >= 6

#####`enable_56_src`

Enable MySQL 5.6 source repository. Defaults to '0'

#####`enable_57_src`

Enable MySQL 5.7 source repository. Defaults to '0'

##Credits

The `rpm_gpg_key` defined type was reused from the ['epel' module by Michael Stahnke](https://forge.puppetlabs.com/stahnma/epel) (stahnma).

Features request and contributions are always welcome!
