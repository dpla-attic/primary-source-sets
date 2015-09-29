# primary-source-sets


Using Vagrant for development
-----------------------------

Prerequisites:

* [VirtualBox](https://www.virtualbox.org/) (Version 4.3)
* [Vagrant](http://www.vagrantup.com/) (Version 1.6)
* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest/) (`vagrant
  plugin install vagrant-vbguest`)
* [Ansible](http://www.ansible.com/) (Version 1.9 or greater;
  [installation instructions](http://docs.ansible.com/intro_installation.html))

For installation:

    vagrant up
    vagrant reload  # Because of o/s packages having been upgraded
    vagrant ssh
    cd /vagrant
    bundle install
    bundle exec rake db:migrate
    bundle exec rails s

Then access the application at http://localhost:3000/primary-source-sets/

You may re-run the provisioning with `vagrant provision`.  This will upgrade
operating system packages.

Subsequent development:
* Run `bundle update` as necessary

### When to use this and other DPLA project VMs

Note the existence of
[our automation project](https://github.com/dpla/automation) and its `pss` role
for this application.

This project's VM is best when you need to make quick iterative developments to
the code and want to re-run the test suite.  For a better representation of how
the whole stack will function in production, including how deployments will
work, use `automation`.

The application's configuration files will be managed by you in your working
copy, if you're using the local VM.  If you're using `automation`, and you want
it to "use local source," in other words, use this working copy as the source of
deployments, please be aware that the working copy's configuration files will be
copied into the `automation` VM, by design.


Sample data
-----------

To create a sample admin account for development and testing:

    rake primary_source_sets:samples:create_admin

This account will have username: 'sample@dp.la' and password: 'password'.
