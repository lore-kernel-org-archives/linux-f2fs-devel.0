From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] sload.f2fs: fix missing SSA updates
Date: Fri, 17 Mar 2017 19:00:55 +0800
Message-ID: <2acc4963-015d-83f0-f89a-83227dfb461d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1copd7-00043g-7k
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:01:09 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1copd5-00068p-9Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:01:09 +0000
Received: by mail-it0-f66.google.com with SMTP id g138so3259802itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 04:01:07 -0700 (PDT)
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

If sload many larger files to disk, the SSA that doesn't cached will be missed.

Mar 17 12:04:39 localhost kernel: ------------[ cut here ]------------
Mar 17 12:04:39 localhost kernel: kernel BUG at fs/f2fs/gc.c:899!
Mar 17 12:04:39 localhost kernel: invalid opcode: 0000 [#1] SMP
Mar 17 12:04:39 localhost kernel: Modules linked in: f2fs tun bridge stp llc fuse ip_set nfnetlink vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event snd_ens1371 gameport snd_ac97_codec coretemp ac97_bus crct10dif_pclmul crc32_pclmul ppdev snd_seq snd_pcm ghash_clmulni_intel intel_rapl_perf vmw_balloon snd_rawmidi joydev snd_timer snd_seq_device snd soundcore parport_pc parport nfit acpi_cpufreq tpm_tis tpm_tis_core shpchp vmw_vmci tpm i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc xfs libcrc32c vmwgfx drm_kms_helper ttm drm e1000 crc32c_intel mptspi scsi_transport_spi serio_raw mptscsih mptbase ata_generic pata_acpi fjes
Mar 17 12:04:39 localhost kernel: CPU: 0 PID: 6427 Comm: f2fs_gc-8:33 Tainted: G        W       4.10.0-f2fs+ #25
Mar 17 12:04:39 localhost kernel: Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
Mar 17 12:04:39 localhost kernel: task: ffff94ba7d998000 task.stack: ffffb6e4c2e50000
Mar 17 12:04:39 localhost kernel: RIP: 0010:do_garbage_collect+0xa39/0xb60 [f2fs]
Mar 17 12:04:39 localhost kernel: RSP: 0018:ffffb6e4c2e53cc0 EFLAGS: 00010213
Mar 17 12:04:39 localhost kernel: RAX: ffff94baa0427000 RBX: 0000000000000001 RCX: 0000000000000002
Mar 17 12:04:39 localhost kernel: RDX: 0000000000000000 RSI: fffff5e2c28109c0 RDI: fffff5e2c28109c0
Mar 17 12:04:39 localhost kernel: RBP: ffffb6e4c2e53dc0 R08: ffff94ba7dfc72f0 R09: fffff5e2c28109dc
Mar 17 12:04:39 localhost kernel: R10: 0000000000000040 R11: ffff94ba7dfc7238 R12: 0000000000000418
Mar 17 12:04:39 localhost kernel: R13: fffff5e2c28109c0 R14: 0000000000000417 R15: ffff94ba3c021000
Mar 17 12:04:39 localhost kernel: FS:  0000000000000000(0000) GS:ffff94babb600000(0000) knlGS:0000000000000000
Mar 17 12:04:39 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 17 12:04:39 localhost kernel: CR2: 00007fc42a0d7000 CR3: 00000000a7e94000 CR4: 00000000001406f0
Mar 17 12:04:39 localhost kernel: Call Trace:
Mar 17 12:04:39 localhost kernel: ? find_next_bit+0xb/0x10
Mar 17 12:04:39 localhost kernel: f2fs_gc+0x111/0x480 [f2fs]
Mar 17 12:04:39 localhost kernel: ? prepare_to_wait_event+0x79/0x160
Mar 17 12:04:39 localhost kernel: gc_thread_func+0x2d0/0x3f0 [f2fs]
Mar 17 12:04:39 localhost kernel: ? __schedule+0x273/0x860
Mar 17 12:04:39 localhost kernel: ? remove_wait_queue+0x70/0x70
Mar 17 12:04:39 localhost kernel: kthread+0x101/0x140
Mar 17 12:04:39 localhost kernel: ? f2fs_gc+0x480/0x480 [f2fs]
Mar 17 12:04:39 localhost kernel: ? kthread_park+0x90/0x90
Mar 17 12:04:39 localhost kernel: ret_from_fork+0x2c/0x40
Mar 17 12:04:39 localhost kernel: Code: 48 8d 84 24 90 00 00 00 48 89 c7 48 89 44 24 28 e8 7d cc ba e6 e9 17 fa ff ff 48 c7 c6 48 3f 84 c0 48 89 c7 e8 59 8d 9d e6 0f 0b <0f> 0b 48 c7 c6 48 3f 84 c0 4c 89 ff e8 46 8d 9d e6 0f 0b 8b b4
Mar 17 12:04:39 localhost kernel: RIP: do_garbage_collect+0xa39/0xb60 [f2fs] RSP: ffffb6e4c2e53cc0
Mar 17 12:04:39 localhost kernel: ---[ end trace 926d61b064ed1f2d ]---

Fixes: 767a93ea8b ("defrag.f2fs: fix missing SSA updates")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index c54bb95..b19b91a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1076,7 +1076,7 @@ void update_sum_entry(struct f2fs_sb_info *sbi, block_t blk_addr,
 							SUM_TYPE_DATA;
 
 	/* write SSA all the time */
-	if (type < SEG_TYPE_MAX) {
+	if (type <= SEG_TYPE_MAX) {
 		u64 ssa_blk = GET_SUM_BLKADDR(sbi, segno);
 		ret = dev_write_block(sum_blk, ssa_blk);
 		ASSERT(ret >= 0);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
