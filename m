From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: About the superblock and checkpoint
Date: Sat, 18 Mar 2017 15:43:53 +0800
Message-ID: <aaccb4f4-fd84-e549-58a8-3b553f2fa9f6@gmail.com>
References: <edd824d4-eae7-4085-b975-812bd97292e7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp91w-0004Ip-7U
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 07:44:04 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp91v-0002ff-5x
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 07:44:04 +0000
Received: by mail-it0-f68.google.com with SMTP id r141so8012330ita.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 18 Mar 2017 00:44:03 -0700 (PDT)
In-Reply-To: <edd824d4-eae7-4085-b975-812bd97292e7@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Please ignore the warning messages, maybe there are some wrong steps when testing.
So sorry!

On 3/18/2017 14:49, Kinglong Mee wrote:
> When I make a filesystem on a disk partition (eg. /dev/sdd1), 
> but I mount the filesystem from /dev/sdd by mistake,
> f2fs print the following WARNING. I don't think user want them.
> 
> I have no idea to avoid or fix it?
> Should f2fs check both super block? or both checkpoint? 
> 
> Any comments are welcome.
> 
> [12456.030051] F2FS-fs (sdd): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> [12456.031270] F2FS-fs (sdd): Can't find valid F2FS filesystem in 1th superblock
> [12456.046173] F2FS-fs (sdd): Mount Device [ 0]:             /dev/sdd,     1023,        0 -    7ffff
> [12456.047112] F2FS-fs (sdd): Mount Device [ 1]:             /dev/sde,     1024,    80000 -    fffff
> [12456.048012] F2FS-fs (sdd): Mount Device [ 2]:             /dev/sdf,     1024,   100000 -   17ffff
> [12456.048856] F2FS-fs (sdd): IO Block Size:        4 KB
> [12456.084157] F2FS-fs (sdd): Found nat_bits in checkpoint
> [12456.138799] ------------[ cut here ]------------
> [12456.139303] WARNING: CPU: 0 PID: 8146 at fs/f2fs/node.c:1162 __get_node_page.part.34+0x1e9/0x330 [f2fs]
> [12456.140313] Modules linked in: f2fs(E) tun bridge stp llc fuse ip_set nfnetlink vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event snd_ens1371 gameport coretemp ppdev snd_ac97_codec crct10dif_pclmul ac97_bus crc32_pclmul snd_seq ghash_clmulni_intel intel_rapl_perf snd_pcm vmw_balloon joydev snd_rawmidi snd_timer snd_seq_device snd soundcore nfit parport_pc parport acpi_cpufreq tpm_tis tpm_tis_core shpchp tpm i2c_piix4 vmw_vmci nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs libcrc32c vmwgfx drm_kms_helper ttm drm crc32c_intel serio_raw e1000 mptspi scsi_transport_spi mptscsih mptbase ata_generic fjes pata_acpi
> [12456.144180] CPU: 0 PID: 8146 Comm: mount Tainted: G        W   E   4.10.0-f2fs+ #25
> [12456.144733] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
> [12456.145835] Call Trace:
> [12456.146391]  dump_stack+0x63/0x86
> [12456.146929]  __warn+0xcb/0xf0
> [12456.147466]  warn_slowpath_null+0x1d/0x20
> [12456.148013]  __get_node_page.part.34+0x1e9/0x330 [f2fs]
> [12456.148573]  get_node_page.part.35+0x12/0x20 [f2fs]
> [12456.149121]  get_node_page+0x1b/0x20 [f2fs]
> [12456.149677]  f2fs_iget+0x8f/0x7f0 [f2fs]
> [12456.150210]  f2fs_fill_super+0xb27/0x17c0 [f2fs]
> [12456.150744]  ? vsnprintf+0x274/0x500
> [12456.151255]  mount_bdev+0x178/0x1b0
> [12456.151770]  ? f2fs_commit_super+0xf0/0xf0 [f2fs]
> [12456.152267]  f2fs_mount+0x15/0x20 [f2fs]
> [12456.152780]  mount_fs+0x38/0x150
> [12456.153257]  ? __alloc_percpu+0x15/0x20
> [12456.153749]  vfs_kern_mount+0x67/0x130
> [12456.154223]  do_mount+0x1dd/0xc50
> [12456.154701]  ? _copy_from_user+0x4e/0x80
> [12456.155167]  ? memdup_user+0x4f/0x70
> [12456.155633]  SyS_mount+0x83/0xd0
> [12456.156139]  entry_SYSCALL_64_fastpath+0x1a/0xa9
> [12456.156617] RIP: 0033:0x7f01d30856fa
> [12456.157088] RSP: 002b:00007ffc63bcf718 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [12456.157576] RAX: ffffffffffffffda RBX: 000055e03b143050 RCX: 00007f01d30856fa
> [12456.158055] RDX: 000055e03b146730 RSI: 000055e03b145f40 RDI: 000055e03b143230
> [12456.158535] RBP: 000055e03b146050 R08: 0000000000000000 R09: 0000000000000013
> [12456.158993] R10: 00000000c0ed8000 R11: 0000000000000246 R12: 000055e03b145f80
> [12456.159449] R13: 0000000000000000 R14: 00007f01d3bf4a2e R15: 00000000ffffffff
> [12456.159910] ---[ end trace cac510ee4c757c87 ]---
> [12456.160699] F2FS-fs (sdd): Failed to read root inode
> [12456.164960] F2FS-fs (sdd): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> [12456.165389] F2FS-fs (sdd): Can't find valid F2FS filesystem in 1th superblock
> [12456.167452] F2FS-fs (sdd): Mount Device [ 0]:             /dev/sdd,     1023,        0 -    7ffff
> [12456.167855] F2FS-fs (sdd): Mount Device [ 1]:             /dev/sde,     1024,    80000 -    fffff
> [12456.168238] F2FS-fs (sdd): Mount Device [ 2]:             /dev/sdf,     1024,   100000 -   17ffff
> [12456.168625] F2FS-fs (sdd): IO Block Size:        4 KB
> [12456.178226] F2FS-fs (sdd): Found nat_bits in checkpoint
> [12456.193698] ------------[ cut here ]------------
> [12456.194057] WARNING: CPU: 0 PID: 8146 at fs/f2fs/node.c:1162 __get_node_page.part.34+0x1e9/0x330 [f2fs]
> [12456.194758] Modules linked in: f2fs(E) tun bridge stp llc fuse ip_set nfnetlink vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event snd_ens1371 gameport coretemp ppdev snd_ac97_codec crct10dif_pclmul ac97_bus crc32_pclmul snd_seq ghash_clmulni_intel intel_rapl_perf snd_pcm vmw_balloon joydev snd_rawmidi snd_timer snd_seq_device snd soundcore nfit parport_pc parport acpi_cpufreq tpm_tis tpm_tis_core shpchp tpm i2c_piix4 vmw_vmci nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs libcrc32c vmwgfx drm_kms_helper ttm drm crc32c_intel serio_raw e1000 mptspi scsi_transport_spi mptscsih mptbase ata_generic fjes pata_acpi
> [12456.197471] CPU: 0 PID: 8146 Comm: mount Tainted: G        W   E   4.10.0-f2fs+ #25
> [12456.197863] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
> [12456.198704] Call Trace:
> [12456.199107]  dump_stack+0x63/0x86
> [12456.199630]  __warn+0xcb/0xf0
> [12456.200042]  warn_slowpath_null+0x1d/0x20
> [12456.200504]  __get_node_page.part.34+0x1e9/0x330 [f2fs]
> [12456.200915]  get_node_page.part.35+0x12/0x20 [f2fs]
> [12456.201381]  get_node_page+0x1b/0x20 [f2fs]
> [12456.201792]  f2fs_iget+0x8f/0x7f0 [f2fs]
> [12456.202200]  f2fs_fill_super+0xb27/0x17c0 [f2fs]
> [12456.202647]  ? vsnprintf+0x274/0x500
> [12456.203041]  mount_bdev+0x178/0x1b0
> [12456.203521]  ? f2fs_commit_super+0xf0/0xf0 [f2fs]
> [12456.204002]  f2fs_mount+0x15/0x20 [f2fs]
> [12456.204445]  mount_fs+0x38/0x150
> [12456.204857]  ? __alloc_percpu+0x15/0x20
> [12456.205306]  vfs_kern_mount+0x67/0x130
> [12456.205686]  do_mount+0x1dd/0xc50
> [12456.206061]  ? _copy_from_user+0x4e/0x80
> [12456.206485]  ? memdup_user+0x4f/0x70
> [12456.206968]  SyS_mount+0x83/0xd0
> [12456.207532]  entry_SYSCALL_64_fastpath+0x1a/0xa9
> [12456.207910] RIP: 0033:0x7f01d30856fa
> [12456.208376] RSP: 002b:00007ffc63bcf718 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [12456.208762] RAX: ffffffffffffffda RBX: 000055e03b143050 RCX: 00007f01d30856fa
> [12456.209147] RDX: 000055e03b146730 RSI: 000055e03b145f40 RDI: 000055e03b143230
> [12456.209576] RBP: 000055e03b146050 R08: 0000000000000000 R09: 0000000000000013
> [12456.209943] R10: 00000000c0ed8000 R11: 0000000000000246 R12: 000055e03b145f80
> [12456.210359] R13: 0000000000000000 R14: 00007f01d3bf4a2e R15: 00000000ffffffff
> [12456.210764] ---[ end trace cac510ee4c757c88 ]---
> [12456.211604] F2FS-fs (sdd): Failed to read root inode
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
