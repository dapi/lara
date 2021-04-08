# Lara bot


# Deploy

Initialize directory and configs structure

> bundle exec cap production systemd:puma:setup systemd:sidekiq:setup 
> bundle exec cap production config:set HOST=YOU_HOST

Deploy application

> bundle exec cap production deploy
