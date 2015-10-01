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

### Amazon S3 setup

_Please note that this information is incomplete and is due to be updated as
we flesh out our media functionality:_

This project requires an Amazon Web Services account, and uses the S3 cloud
container service for media file storage.

The relevant parameters must be defined in `settings.local.yml`.  See
`app/config/settings.yml`.

The application makes use of one bucket for incoming media files that need to be
transcoded, and another for the transcoded derivatives.  You should have an IAM
account with the necessary permissions on these buckets.  The incoming bucket
must have the following CORS configuration:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>POST</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>Content-Type</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

The incoming S3 bucket must also have a "policy" that allows the following
actions on `arn:aws:s3:::<the bucket name>/*`: `s3:GetObject`, `s3:PutObject`,
and `s3:DeleteObject`.


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
