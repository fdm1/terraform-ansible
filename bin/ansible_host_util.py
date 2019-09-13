#! /usr/bin/env python3
import argparse
import json
import os
import subprocess

SCRIPT_PATH = os.getcwd()
ANSIBLE_SSH_USERS = dict(lightsail='ubuntu', digitalocean='root')
KNOWN_HOST_TYPES = ['lightsail', 'digitalocean']
KNOWN_ACTIONS = ['create', 'destroy', 'refresh', 'get_host_ip']
INVENTORY_DIR = os.path.join(SCRIPT_PATH, 'ansible', 'inventory')



def parse_args(argv=None):
    parser = argparse.ArgumentParser('andible-host-util')
    parser.add_argument('action', help=', '.join(KNOWN_ACTIONS))
    parser.add_argument('--host-type', help=', '.join(KNOWN_HOST_TYPES))
    parser.add_argument('--ip')
    args = parser.parse_args(args=argv)

    if args.action not in KNOWN_ACTIONS:
        raise Exception(f'Action {args.action} not allowed')

    if args.action != 'refresh':
        if args.host_type not in KNOWN_HOST_TYPES:
            raise Exception(f'Host type {args.host_type} not allowed')

    if args.action not in ['refresh', 'get_host_ip']:
        if not args.ip:
            raise Exception(f'Target IP needed')

    return args


def inventory_path(ip):
    return os.path.join(INVENTORY_DIR, ip)


def create_host(ip, host_type):
    with open(inventory_path(ip), 'w') as f:
        f.write(f'[{host_type}]\n')
        f.write(f'{ip} ansible_ssh_user={ANSIBLE_SSH_USERS.get(host_type)}')


def destroy_host(ip, _):
    path = inventory_path(ip)
    if os.path.exists(path):
        os.remove(path)
    else:
        print(f'{path} does not exist')


def get_terraform_output_hosts():
    host_ips = json.loads(subprocess.check_output(['terraform', 'output', '-json'])).get('host_ips')
    if host_ips:
        return host_ips.get('value')
    return {}


def refresh_hosts(_1, _2):
    applied_host_values = get_terraform_output_hosts()
    known_hosts = []
    for host_type in applied_host_values:
        for ip in applied_host_values.get(host_type):
            create_host(ip, host_type)
            known_hosts.append(ip)

    current_hosts = (path for path in os.listdir(INVENTORY_DIR) if path != '.gitkeep')
    for path in current_hosts:
        if path not in known_hosts:
            destroy_host(path, None)


def get_host_ip(_, host_type):
    applied_host_values = get_terraform_output_hosts()
    if host_type not in applied_host_values:
        print(f'{host_type} is not deployed')
        return
    ips = applied_host_values.get(host_type)
    if len(ips) == 1:
        print(ips[0])

    else:
        raise Exception('multiple ips found, deal with this at some point')


def main(argv=None):
    args = parse_args(argv=argv)
    action_mapping = dict(
        create=create_host,
        destroy=destroy_host,
        refresh=refresh_hosts,
        get_host_ip=get_host_ip,
    )
    action_mapping.get(args.action)(args.ip, args.host_type)


if __name__ == '__main__':
    main()
