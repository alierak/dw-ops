#
# serverclass::admin
#
# Defines functionality for the configuration of the admin machines.
#
# Authors:
#      Mark Smith <mark@dreamwidth.org>
#
# Copyright (c) 2009 by Dreamwidth Studios, LLC.
#
# This program is free software; you may redistribute it and/or modify it under
# the same terms as Perl itself.  For a copy of the license, please reference
# 'perldoc perlartistic' or 'perldoc perlgpl'.
#

class iptables::dreamwidth::admin inherits iptables::dreamwidth {
    # open up incoming port 80, 443, 22
    Iptables::Rules["dreamwidth"] { allowed_ports => [ 80, 443, 22 ] }
}

class serverclass::admin inherits serverclass::dreamwidth {
    include iptables::dreamwidth::admin

    # make sure Apache is running
    service { "apache2":
        ensure => running,
        pattern => "/usr/sbin/apache2",
        hasstatus => true,
        hasrestart => true
    }
}
