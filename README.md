# primary-source-sets

Reindexing PSS documents to Elasticsearch

Run the `pss-json-export.py` script against all sets (contents of s3://dpla-pss-json/)

Create a new index with filterable fields for keyword and time period values
```
curl -XPUT http://[ES_NODE]:9200/[INDEX]\?pretty -H "Content-Type: application/json" -d '
{
    "mappings":
    {
        "properties":
        {
            "about":
            {
                "type": "object",
                "properties":
                {
                    "disambiguatingDescription":
                    {
                        "type": "keyword",
                        "fields":
                        {
                            "not_analyzed":
                            {
                                "type": "keyword"
                            }
                        }
                    },
                    "name":
                    {
                        "type": "keyword",
                        "fields":
                        {
                            "not_analyzed":
                            {
                                "type": "keyword"
                            }
                        }
                    }
                }
            }
        }
    }
}'
```

Index documents from the ./sets/ directory 
```
find . -name "*updated_*.json" -type f | xargs -I{} sh -c 'echo "$1" "./$(basename ${1%.*}).${1##*.}"' -- {} | xargs -n 2 -P 8 sh -c 'curl -XPOST http://ES_NODE:9200/[INDEX]/doc -H "Content-Type: application/json" -d @"$0"'
```

Flop the alias to the new index
```
curl -XPOST http://[ES_NODE]:9200/_aliases -H 'Content-Type: application/json' -d '{"actions":[{"remove" : {"index" : "*", "alias" : "dpla_pss"}},{"add" : { "index" : "[INDEX]", "alias" : "dpla_pss" }}]}'
```

Test the indexing by getting the facet values for Time Period and Subject filters/facets/dropdowns 
```
curl -XGET http://[NODE]:9200/dpla_pss/_search\?pretty -H "Content-Type: application/json" \
-d '{
    "size": "1",
    "_source":
    {
        "includes":
        [
            "about.disambiguatingDescription", "about.name"
        ],
        "excludes":
        []
    },
    "query":
    {
        "match_all":
        {}
    },
    "aggs":
    {
        "disambiguatingDescriptionAgg":
        {
            "terms":
            {
                "field": "about.disambiguatingDescription"
            }
        }, "nameAgg":
        {
            "terms":
            {
                "field": "about.name"
            }
        }

    }
}'
```

Test sorting by dateCreated chronologically
```
curl -XGET http://[NODE]:9200/dpla_pss/_search\?pretty -H "Content-Type: application/json" \
-d '{
    "size": "500",
    "_source":
    {
        "includes":
        [
            "dateCreated", "name"
        ],
        "excludes":
        []
    },
    "query":
    {
        "match_all":
        {}
    },
    "sort" : [
        { "dateCreated" : {"order" : "desc"}}
    ]
}'
```


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

To install all gems:

    bundle install

Or, to install only the necessary gems:

    bundle install --deployment --without dpla_branding production

Finish installation:

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
account with the necessary permissions on these buckets.

The incoming bucket must have the following CORS configuration, which is managed
in Amazon's S3 Management Console.

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

The destination bucket (for transcoded derivatives and PDFs and images, too)
needs the following CORS configuration.

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>HEAD</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>Content-Type</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

The IAM account should have a Policy Document that makes the following
allowances.  Policy Documents are managed in Amazon's IAM Management Console.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject",
                "s3:GetBucketCORS"
            ],
            "Resource": [
                "arn:aws:s3:::incoming-bucket-name/*"
            ]
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject",
                "s3:GetBucketCORS"
            ],
            "Resource": [
                "arn:aws:s3:::destination-bucket-name/*"
            ]
        },
        {
            "Sid": "3",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::incoming-bucket-name"
        }
    ]
}
```

Note that the "Sid" values can be whatever you want them to be, as long as they
are unique within the Policy Document.  The strings `incoming-bucket-name` and
`destination-bucket-name` need to be replaced with the actual names of your
buckets.

Your destination bucket should have a CloudFront Distribution, i.e. should be
served up with Amazon's content delivery network. The Domain Name property of
that CloudFront Distribution is what goes into your `settings.local.yml` as
`aws`.`s3_cloudfront_domain`.

### Zencoder development setup

The zencoder-fetcher gem can be used during development to complete each
upload-and-transcoding operation.  It's necessary when your development
environment is behind a NAT firewall (the usual case) and Zencoder can't access
your notification endpoint.

In the shell that you'll be using during development that has access to the
application (e.g. http://localhost:3000/primary-source-sets/), do this:

The `zencoder-fetcher` gem should be installed with the `:development` group in
the `Gemfile`.  This will allow its `zencoder-fetcher` command to be run like
one of your `rake` or `rails` commands.  You could also install it somewhere
else that has access to your app by running `gem install zencoder-fetcher`.

Then you'll be able to run the command as follows:

```
zencoder_fetcher -u http://USER:PASSWORD@localhost:3000/primary-source-sets/video_notifications <API KEY>
```

... Where USER is zencoder.notification_user and PASSWORD is
zencoder.notification_pass in your `settings.yml`.

Substitute `video_notifications` for `audio_notifications` as necessary.

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

### ActionMailer setup

This project uses ActionMailer to send account-creation confirmation emails. We
use the [mailcatcher](http://mailcatcher.me/) gem in development to simulate a
mail server, rather than running a real one. Per [its
documentation](http://mailcatcher.me/), we do not include it in our Gemfile, and
you need to install it with `gem install mailcatcher`.

The mail settings for production are ActionMailer `smtp_settings` key/value
pairs.  There are defaults in `settings.yml` that can be overridden in
`settings.local.yml`.

If you're running in the development VM (with our Vagrantfile), you'll want to
invoke `mailcatcher` this way:
```
mailcatcher --http-ip 0.0.0.0
```
This ensures that the HTTP interface will be listening on the network interface
that is being forwarded to `localhost` on your host machine.

Testing
-------

To run rspec tests in your console:

    rake ci

To run jasmine tests in your console:

    rake jasmine:ci

To run a jasmine Webrick server on port 3001, from the console do:

    rake jasmine

and then go to `http://localhost:3001/` in your browser.  Whenever you reload the page, the tests are run again.


Create an initial admin account
-----------

To create an initial manager admin account, from the console do:

    Admin.new({ email: '[EMAIL]', password: '[PASSWORD]', password_confirmation: '[PASSWORD]', status: 2 }).save

Example:

    Admin.new({ email: 'example@email.com', password 'secret', password_confirmation: 'secret', status: 2 }).save

The output in the console will contain a web address to visit in order to activate the account.  Go to `[ROOT]/admins/sign_in` to log in.


Copyright & License
-------------------

* Copyright Digital Public Library of America, 2015 -- 2017
* License: MIT
