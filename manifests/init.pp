# paw_ansible_role_swap
# @summary Manage paw_ansible_role_swap configuration
#
# @param swap_file_path
# @param swap_file_size_mb
# @param swap_swappiness
# @param swap_file_state
# @param swap_file_create_command
# @param swap_test_mode
# @param par_tags An array of Ansible tags to execute (optional)
# @param par_skip_tags An array of Ansible tags to skip (optional)
# @param par_start_at_task The name of the task to start execution at (optional)
# @param par_limit Limit playbook execution to specific hosts (optional)
# @param par_verbose Enable verbose output from Ansible (optional)
# @param par_check_mode Run Ansible in check mode (dry-run) (optional)
# @param par_timeout Timeout in seconds for playbook execution (optional)
# @param par_user Remote user to use for Ansible connections (optional)
# @param par_env_vars Additional environment variables for ansible-playbook execution (optional)
# @param par_logoutput Control whether playbook output is displayed in Puppet logs (optional)
# @param par_exclusive Serialize playbook execution using a lock file (optional)
class paw_ansible_role_swap (
  String $swap_file_path = '/swapfile',
  String $swap_file_size_mb = '512',
  String $swap_swappiness = '60',
  String $swap_file_state = 'present',
  String $swap_file_create_command = 'dd if=/dev/zero of={{ swap_file_path }} bs=1M count={{ swap_file_size_mb }}',
  Boolean $swap_test_mode = false,
  Optional[Array[String]] $par_tags = undef,
  Optional[Array[String]] $par_skip_tags = undef,
  Optional[String] $par_start_at_task = undef,
  Optional[String] $par_limit = undef,
  Optional[Boolean] $par_verbose = undef,
  Optional[Boolean] $par_check_mode = undef,
  Optional[Integer] $par_timeout = undef,
  Optional[String] $par_user = undef,
  Optional[Hash] $par_env_vars = undef,
  Optional[Boolean] $par_logoutput = undef,
  Optional[Boolean] $par_exclusive = undef
) {
# Execute the Ansible role using PAR (Puppet Ansible Runner)
  $vardir = $facts['puppet_vardir'] ? {
    undef   => $settings::vardir ? {
      undef   => '/opt/puppetlabs/puppet/cache',
      default => $settings::vardir,
    },
    default => $facts['puppet_vardir'],
  }
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/ansible_role_swap/playbook.yml"

  par { 'paw_ansible_role_swap-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'swap_file_path'           => $swap_file_path,
      'swap_file_size_mb'        => $swap_file_size_mb,
      'swap_swappiness'          => $swap_swappiness,
      'swap_file_state'          => $swap_file_state,
      'swap_file_create_command' => $swap_file_create_command,
      'swap_test_mode'           => $swap_test_mode,
    },
    tags          => $par_tags,
    skip_tags     => $par_skip_tags,
    start_at_task => $par_start_at_task,
    limit         => $par_limit,
    verbose       => $par_verbose,
    check_mode    => $par_check_mode,
    timeout       => $par_timeout,
    user          => $par_user,
    env_vars      => $par_env_vars,
    logoutput     => $par_logoutput,
    exclusive     => $par_exclusive,
  }
}
