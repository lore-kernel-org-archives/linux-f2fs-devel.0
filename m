From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200773] New: An issue was discovered in the Linux
 kernel through 4.17.3. There is a NULL pointer dereference in
 get_checkpoint_version() in fs/f2fs/checkpoint.c when mounting crafted f2fs
 image.
Date: Thu, 09 Aug 2018 08:33:36 +0000
Message-ID: <bug-200773-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fngO9-0004oe-9K
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 08:33:45 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fngO7-00Cfuk-5Q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 08:33:45 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6DB4E2A895
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Aug 2018 08:33:36 +0000 (UTC)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=200773

            Bug ID: 200773
           Summary: An issue was discovered in the Linux kernel through
                    4.17.3. There is a NULL pointer dereference in
                    get_checkpoint_version() in fs/f2fs/checkpoint.c when
                    mounting crafted f2fs image.
           Product: File System
           Version: 2.5
    Kernel Version: 4.4.146, through,  4.17.3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: datadancer@163.com
        Regression: No

Created attachment 277777
  --> https://bugzilla.kernel.org/attachment.cgi?id=277777&action=edit
The crafted f2fs image.

- Reproduce
#mkdir /tmp/mnt
#sudo mount -t f2fs f2fs.img /tmp/mnt

- Kernel message
#dmesg
[107073.517344] F2FS-fs (loop2): Magic Mismatch, valid(0xf2f52010) -
read(0xf2f52090)
[107073.517346] F2FS-fs (loop2): Can't find valid F2FS filesystem in 1th
superblock
[107073.517363] attempt to access beyond end of device
[107073.517364] loop2: rw=56, want=4104, limit=128
[107073.517379] BUG: unable to handle kernel NULL pointer dereference at
0000000000000094
[107073.517433] IP: [<ffffffffc0ddb918>] f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[107073.517456] PGD 0 

[107073.517467] Oops: 0002 [#1] PREEMPT SMP
[107073.517478] Modules linked in: f2fs uas usb_storage cfg80211 rfkill
hid_generic usbhid hid ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter
xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user
xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo dm_thin_pool
dm_persistent_data dm_bio_prison dm_bufio loop dm_mod intel_rapl
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel
x86_pkg_temp_thermal intel_powerclamp snd_hda_codec coretemp snd_hda_core
snd_hwdep iTCO_wdt iTCO_vendor_support kvm snd_pcm sg shpchp snd_timer lpc_ich
mfd_core mei_me mei ie31200_edac battery snd soundcore irqbypass evdev
acpi_cpufreq crct10dif_pclmul crc32_pclmul edac_core ghash_clmulni_intel
intel_cstate
[107073.517752]  serio_raw intel_uncore intel_rapl_perf pcspkr binfmt_misc fuse
parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto
ecb mbcache btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath
linear md_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel libata amdkfd
ehci_pci aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd
radeon psmouse xhci_pci i2c_algo_bit ttm i2c_i801 scsi_mod xhci_hcd ehci_hcd
i2c_smbus drm_kms_helper e1000e ptp usbcore pps_core usb_common drm wmi fan
thermal video button
[107073.517977] CPU: 5 PID: 4121 Comm: mount Tainted: G           O   
4.9.0-deepin13-amd64 #1 Deepin 4.9.57-1
[107073.518003] Hardware name: LENOVO ThinkCentre M8400T/MAHOBAY, BIOS
9SKT39AUS 08/07/2012
[107073.518024] task: ffff8d659f50b0c0 task.stack: ffffb1014ca44000
[107073.518040] RIP: 0010:[<ffffffffc0ddb918>]  [<ffffffffc0ddb918>]
f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[107073.518070] RSP: 0018:ffffb1014ca47bd0  EFLAGS: 00010246
[107073.518084] RAX: 0000000000000010 RBX: ffff8d65314d1000 RCX:
0000000000000000
[107073.518103] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff8d65314d1264
[107073.518122] RBP: ffff8d65314d1264 R08: 0000000000000000 R09:
0000000000010e48
[107073.518141] R10: 0000000000000000 R11: 0000000000000001 R12:
0000000000000000
[107073.518160] R13: ffffb1014ca47bf0 R14: ffff8d65314d1000 R15:
ffffffffc0dfe910
[107073.518180] FS:  00007f1b8eb5c480(0000) GS:ffff8d661dd40000(0000)
knlGS:0000000000000000
[107073.518201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[107073.518217] CR2: 0000000000000094 CR3: 0000000050c9b000 CR4:
00000000001406e0
[107073.518236] Stack:
[107073.518242]  ffffd45ac0c53480 ffff8d658dfd5898 0000000000000200
ffffffffc0ddbac1
[107073.518266]  ffff8d65314d1000 0000000000000002 0000020000000038
0000000000000200
[107073.518290]  ffffd45ac0c53480 0000000000000000 d7dafc5d1e926bb2
ffffb1014ca47cc0
[107073.518314] Call Trace:
[107073.518326]  [<ffffffffc0ddbac1>] ? __get_meta_page+0x171/0x1d0 [f2fs]
[107073.518347]  [<ffffffffc0ddbb64>] ? get_checkpoint_version+0x44/0x160
[f2fs]
[107073.518376]  [<ffffffffc0ddbcd2>] ? validate_checkpoint+0x52/0x290 [f2fs]
[107073.518398]  [<ffffffffc0ddcff1>] ? get_valid_checkpoint+0x81/0x470 [f2fs]
[107073.518427]  [<ffffffffad2299a3>] ? unlock_new_inode+0x43/0x70
[107073.518447]  [<ffffffffc0dd7fee>] ? f2fs_fill_super+0x6de/0x1140 [f2fs]
[107073.518468]  [<ffffffffc0dd7910>] ? f2fs_commit_super+0xf0/0xf0 [f2fs]
[107073.518487]  [<ffffffffad210e68>] ? mount_bdev+0x238/0x280
[107073.518502]  [<ffffffffad211806>] ? mount_fs+0x36/0x150
[107073.518518]  [<ffffffffad22f13a>] ? vfs_kern_mount+0x5a/0xf0
[107073.518534]  [<ffffffffad23163f>] ? do_mount+0x1cf/0xc70
[107073.518550]  [<ffffffffad1a72ea>] ? memdup_user+0x4a/0x70
[107073.518565]  [<ffffffffad23240e>] ? SyS_mount+0x7e/0xd0
[107073.518581]  [<ffffffffad61a3bb>] ? system_call_fast_compare_end+0xc/0x9b
[107073.519360] Code: 00 00 00 0f 1f 44 00 00 41 54 55 48 8d af 64 02 00 00 53
48 89 fb 41 89 f4 48 89 ef e8 32 e9 83 ec 48 8b 83 58 02 00 00 48 89 ef <83> 88
84 00 00 00 08 e8 9c e3 83 ec 48 8b 03 48 83 48 50 01 45 
[107073.521193] RIP  [<ffffffffc0ddb918>] f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[107073.522039]  RSP <ffffb1014ca47bd0>
[107073.522846] CR2: 0000000000000094
[107073.526126] ---[ end trace dd317e2b0c44bd8f ]---
[107073.526128] note: mount[4121] exited with preempt_count 1
[109127.673486] F2FS-fs (loop4): Magic Mismatch, valid(0xf2f52010) -
read(0xf2f52090)
[109127.673493] F2FS-fs (loop4): Can't find valid F2FS filesystem in 1th
superblock
[109127.673630] attempt to access beyond end of device
[109127.673636] loop4: rw=56, want=4104, limit=128
[109127.673665] BUG: unable to handle kernel NULL pointer dereference at
0000000000000094
[109127.675284] IP: [<ffffffffc0ddb918>] f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[109127.676893] PGD 0 

[109127.678439] Oops: 0002 [#2] PREEMPT SMP
[109127.679937] Modules linked in: f2fs uas usb_storage cfg80211 rfkill
hid_generic usbhid hid ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter
xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user
xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo dm_thin_pool
dm_persistent_data dm_bio_prison dm_bufio loop dm_mod intel_rapl
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel
x86_pkg_temp_thermal intel_powerclamp snd_hda_codec coretemp snd_hda_core
snd_hwdep iTCO_wdt iTCO_vendor_support kvm snd_pcm sg shpchp snd_timer lpc_ich
mfd_core mei_me mei ie31200_edac battery snd soundcore irqbypass evdev
acpi_cpufreq crct10dif_pclmul crc32_pclmul edac_core ghash_clmulni_intel
intel_cstate
[109127.689181]  serio_raw intel_uncore intel_rapl_perf pcspkr binfmt_misc fuse
parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto
ecb mbcache btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath
linear md_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel libata amdkfd
ehci_pci aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd
radeon psmouse xhci_pci i2c_algo_bit ttm i2c_i801 scsi_mod xhci_hcd ehci_hcd
i2c_smbus drm_kms_helper e1000e ptp usbcore pps_core usb_common drm wmi fan
thermal video button
[109127.698765] CPU: 3 PID: 5647 Comm: mount Tainted: G      D    O   
4.9.0-deepin13-amd64 #1 Deepin 4.9.57-1
[109127.700394] Hardware name: LENOVO ThinkCentre M8400T/MAHOBAY, BIOS
9SKT39AUS 08/07/2012
[109127.702086] task: ffff8d6613c67040 task.stack: ffffb10143c90000
[109127.703711] RIP: 0010:[<ffffffffc0ddb918>]  [<ffffffffc0ddb918>]
f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[109127.705424] RSP: 0018:ffffb10143c93bd0  EFLAGS: 00010246
[109127.707113] RAX: 0000000000000010 RBX: ffff8d65314d1800 RCX:
0000000000000000
[109127.708776] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff8d65314d1a64
[109127.710444] RBP: ffff8d65314d1a64 R08: 00000000000a4764 R09:
0000000000000005
[109127.712120] R10: ffff8d661dff9000 R11: ffffffffadea246e R12:
0000000000000000
[109127.713772] R13: ffffb10143c93bf0 R14: ffff8d65314d1800 R15:
ffffffffc0dfe910
[109127.715426] FS:  00007f14228b6480(0000) GS:ffff8d661dcc0000(0000)
knlGS:0000000000000000
[109127.717095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[109127.718767] CR2: 0000000000000094 CR3: 0000000098a28000 CR4:
00000000001406e0
[109127.720435] Stack:
[109127.722094]  ffffd45ac2321180 ffff8d65d52ca568 0000000000000200
ffffffffc0ddbac1
[109127.723779]  ffff8d65314d1800 0000000000000002 0000020000000038
0000000000000200
[109127.725469]  ffffd45ac2321180 0000000000000000 ad11ad5ae27c2849
ffffb10143c93cc0
[109127.727206] Call Trace:
[109127.728783]  [<ffffffffc0ddbac1>] ? __get_meta_page+0x171/0x1d0 [f2fs]
[109127.730429]  [<ffffffffc0ddbb64>] ? get_checkpoint_version+0x44/0x160
[f2fs]
[109127.730443]  [<ffffffffc0ddbcd2>] ? validate_checkpoint+0x52/0x290 [f2fs]
[109127.730456]  [<ffffffffc0ddcff1>] ? get_valid_checkpoint+0x81/0x470 [f2fs]
[109127.730461]  [<ffffffffad2299a3>] ? unlock_new_inode+0x43/0x70
[109127.730479]  [<ffffffffc0dd7fee>] ? f2fs_fill_super+0x6de/0x1140 [f2fs]
[109127.730483]  [<ffffffffc0dd7910>] ? f2fs_commit_super+0xf0/0xf0 [f2fs]
[109127.730486]  [<ffffffffad210e68>] ? mount_bdev+0x238/0x280
[109127.730487]  [<ffffffffad211806>] ? mount_fs+0x36/0x150
[109127.730489]  [<ffffffffad22f13a>] ? vfs_kern_mount+0x5a/0xf0
[109127.730490]  [<ffffffffad23163f>] ? do_mount+0x1cf/0xc70
[109127.730492]  [<ffffffffad1a72ea>] ? memdup_user+0x4a/0x70
[109127.730494]  [<ffffffffad23240e>] ? SyS_mount+0x7e/0xd0
[109127.730496]  [<ffffffffad61a3bb>] ? system_call_fast_compare_end+0xc/0x9b
[109127.730514] Code: 00 00 00 0f 1f 44 00 00 41 54 55 48 8d af 64 02 00 00 53
48 89 fb 41 89 f4 48 89 ef e8 32 e9 83 ec 48 8b 83 58 02 00 00 48 89 ef <83> 88
84 00 00 00 08 e8 9c e3 83 ec 48 8b 03 48 83 48 50 01 45 
[109127.730519] RIP  [<ffffffffc0ddb918>] f2fs_stop_checkpoint+0x28/0x60 [f2fs]
[109127.730519]  RSP <ffffb10143c93bd0>
[109127.730520] CR2: 0000000000000094
[109127.730521] ---[ end trace dd317e2b0c44bd90 ]---
[109127.730522] note: mount[5647] exited with preempt_count 1

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
