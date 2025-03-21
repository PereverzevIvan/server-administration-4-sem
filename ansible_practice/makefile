up:
	docker compose up -d

down:
	docker compose down

ansible:
	ansible-playbook -i inventory.yml --ask-pass --ask-become-pass playbook-common.yml

test:
	ansible-playbook -i inventory.yml --ask-pass test_playbook.yml


get_ip:
	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ansible_practice-srv-1
