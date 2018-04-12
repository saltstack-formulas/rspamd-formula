==============
rspamd-formula
==============

A SaltStack formula to install and configure `rspamd <https://rspamd.com>`_.

.. image:: https://travis-ci.org/saltstack-formulas/rspamd-formula.svg?branch=master

**NOTE**

See the full `Salt Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``rspamd``
----------

Installs the rspamd package, configures it and starts the associated rspamd service.

``rspamd.install``
------------------

Installs the rspamd package.

``rspamd.config``
----------------

Configures the rspamd package.

``rspamd.service``
-----------------

Manages the rspamd service.
