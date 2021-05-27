# Lara bot


# Deploy

Initialize directory and configs structure

> bundle exec cap production systemd:puma:setup systemd:sidekiq:setup 
> bundle exec cap staging master_key:setup
> bundle exec cap production config:set HOST=$(SERVER_DOMAIN_OR_IP)

Deploy application

> bundle exec cap production deploy
