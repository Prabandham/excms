# ExCms
    A tailored CMS that supports multiple sites. Generally specific to the usage of Larks.

### Prerequisites

* Elixir 1.6.4
* Phoenix 1.3.0
* Postgres > 9
* nodejs and npm

### Installing

Make sure you have the above mentioned dependancies installed on your system.

Update the username and password to match your postgres setup.

`mix deps.get`

`mix deps.compile`

`mix do ecto.create, ecto.migrate`

`cd assets && npm install && cd ..`

`iex -S mix phx.server`

The application should now be running on PORT `4000`


### Ideology

We at [Larks](http://larks.in) have started undertaking a lot of HTML website building.

some of the mundane tasks that we face are.

1. Buying a domain and configuring it to a hosting provider.
2. Setting up SSL to our sites.
3. Constant content Updates.

This has to be done to a lot of clients _(around 15 of them)_.
Traditionaly we used to make development and ftp our code to the respective serves.

Along with this we also have to maintain and update our own site as well.

This led to the development of ExCms a customised CMS that will help us create/manage/host multiple websites
as well as our own :)

### FAQ's
---
Why not resuse exiting CMS solutions?

    We are a software development team, and we did not really like any of the existing solutions
    and we wanted something that was tailored to the way we work.

Why Elixir and Phoenix?

    Having spent a lot of time doing Ruby on Rails. We decided to check out Elixir mainly due to the speed and fault taularnce that it boasts.
    And having developed a couple of applications we are happy and saw that Elixir / Phoenix gives us the flexibility and rigidity that we need to build what we had in mind.

Can we use this?

    Yes, please be our guests. But this is kinda tailored to how we want to go about doing this. So get ready for a learning curve :)


### Screenshots
    COMING SOON

### Deployment

    Deployment is done using distillery and edeliver.

    We use the same server to do the build and deploy.

    each with a seperate user.
    So deploy will happen on the remote server with user builder
    and code will be deployed under user deploy.

    Initial deploy :-

        # Build the code on remote build host.
        mix edeliver build release production

        # Deploy the code to production.
        mix edeliver deploy release to production

        # Start server.
        mix edeliver start production

    Code upgrades :-

        # Set current version
        mix edeliver version production

        # Build the upgrade
        mix edeliver build upgrade production --verbose --with=version_number

        # Deploy the upgarade to production
        mix edeliver deploy upgrade to production

    Seeds :-
        If you have to run any seeds on the production machine like admin user.

        ssh to the production Node and cd to the $APP directory.
        bin/$APP remote_console

        This will put us in an iex shell. From where we can run commands to create / delete user.

    # Nginx config :- TODO

    # Backups :- TODO

    # SSL setup :- TODO

### Contributing
    NOT ACCEPTING ANY PR's YET :(

### Versoning
    We use SemVer for versioning.

### Acknowledgments
    - Abhishek M
    - Krishna S
    - Ashwin J
    - Raju B.M
    - Lohith B.N
    - Ankesh S


