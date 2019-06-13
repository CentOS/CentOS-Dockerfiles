#  Official CentOS libvirtd docker container

Credits to
https://github.com/fuzzyhandle/libvirtd-in-docker
https://github.com/projectatomic/docker-image-examples/blob/master/rhel-libvirt/libvirtd/Dockerfile
http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/
The Container supports running qemu hypervisor out of the box. However to leverage hardware acceleration, the underlying host needs to support Visualization Technology (VT).

Running KVM in libvirtd in a container
For running VMs using hardware acceleration, the docker host will need to have have a processor flag to support nested visualization

Check your processor supports VT
For more info refer http://www.howtogeek.com/howto/linux/linux-tip-how-to-tell-if-your-processor-supports-vt/

Run

egrep ‘(vmx|svm)’ /proc/cpuinfo
The output should show vmx (in case of Intel Processor) or svm (in case of AMD Processor)

E.g.

flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
Enable the setting for Nested KVM
Assuming the processor supports VT, you can enable the VT support to nested VMs.

Create/Edit file /etc/modprobe.d/kvm-nested.conf with contents

options kvm_intel nested=1
Unload and reload the module

modprobe -r kvm_intel
modprobe kvm_intel
The output of this command is

cat /sys/module/kvm_intel/parameters/nested
should show

Y
Running the container
This image needs to be run in privileged mode

E.g.

docker run -d --privileged -d -e 'container=docker' -v /sys/fs/cgroup:/sys/fs/cgroup:rw centos/libvirtd
You can also forward ports to connect to the libvirtd service from remote machines

docker run -d --privileged -d -e 'container=docker'-p 10001:16509 -p 10002:22 -p 10003:5900  -v /sys/fs/cgroup:/sys/fs/cgroup:rw centos/libvirtd;
