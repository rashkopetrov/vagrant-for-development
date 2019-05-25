
:construction: :construction: :construction: :construction:

## Summary

- [Introduction](#introduction)
- [Included Software](#included-software)
- [Installation & Setup](#installation-and-setup)

<a name="introduction"></a>
## Introduction

`vagrant-for-development` provides you a friendly development environment without requiring you to install PHP, a web servers, and any other server software on your local machine.

<a name="included-software"></a>
## Included Software

<table>
    <tr>
        <td>
            <ul>
                <li>Apache2</li>
                <li>Nginx</li>
                <li>PHP 7.0</li>
                <li>PHP 7.1</li>
                <li>PHP 7.2</li>
                <li>PHP 7.3</li>
                <li>PHPUnit 6.5</li>
            </ul>
        </td>
        <td>
            <ul>
                <li>Go</li>
                <li>Git</li>
                <li>NVM</li>
                <li>PHP Composer</li>
                <li>avahi</li>
                <li>wp-cli</li>
            </ul>
        </td>
        <td>
            <ul>
                <li>Mailhog</li>
                <li>Redis</li>
                <li>MySQL 8</li>
                <li>SQLite 3</li>
                <li>PostgreSQL 9</li>
            </ul>
        </td>
    </tr>
</table>

<a name="installation-and-setup"></a>
## Installation & Setup

### Requirements

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

### Installing

Clone the repository onto your host machine:
`git clone https://github.com/brutalenemy666/vagrant-for-development.git ~/DevBox`

Once you have cloned the repository, navigate to the DevBox directory `cd ~/DevBox` and run `bash ./init.sh`. The `config.json` file will be placed in the directory.

### Configuring

#### Setting Your VM

<table>
    <tr>
        <th>Key</th>
        <th>Default Value</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>name</td>
        <td>DevBox</td>
        <td>The name that appears in the VirtualBox GUI.</td>
    </tr>
    <tr>
        <td>box</td>
        <td>debian/stretch64</td>
        <td>This configures what box the machine will be brought up against. The default box much be debian based.</td>
    </tr>
    <tr>
        <td>hostname</td>
        <td>localhost</td>
        <td>The hostname the machine should have.</td>
    </tr>
    <tr>
        <td>boot_timeout</td>
        <td>120</td>
        <td>The time in seconds that Vagrant will wait for the machine to boot and be accessible. By default this is 300 seconds.</td>
    </tr>
    <tr>
        <td>check_for_update</td>
        <td>true</td>
        <td>If true, Vagrant will check for updates to the configured box on every vagrant up. If an update is found, Vagrant will tell the user.</td>
    </tr>
    <tr>
        <td>gui</td>
        <td>false</td>
        <td>By default, VirtualBox machines are started in headless mode, meaning there is no UI for the machines visible on the host machine.</td>
    </tr>
    <tr>
        <td>ip</td>
        <td>192.168.10.10</td>
        <td>Configures network IP on the machine.</td>
    </tr>
    <tr>
        <td>memory</td>
        <td>2048</td>
        <p>The memory the machine is allowed to use.</p>
    </tr>
    <tr>
        <td>cpus</td>
        <td>1</td>
        <td>The CPUs the machine is allowed to use.</td>
    </tr>
    <tr>
        <td>run_dpkg_installers_on</td>
        <td>provision</td>
        <td>Whether to attempt installation of new packages on `vagrant up`. The available options are `boot` and `provision`.</td>
    </tr>
    <tr>
        <td>run_dpkg_autoupdate</td>
        <td>provision</td>
        <td>Whether to update/upgrade the packages on `vagrant up`. The available options are `boot` and `provision`.</td>
    </tr>
</table>
