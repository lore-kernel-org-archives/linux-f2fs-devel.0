From: Tastky <tastky@gmail.com>
Subject: [BUG] "kernel BUG at fs/f2fs/segment.c"
Date: Sat, 30 Nov 2013 18:26:20 +0100
Message-ID: <529A1FBC.2000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tastky@gmail.com>) id 1VmoJX-0007Ii-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 17:26:43 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VmoJW-0004eX-Cy
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 17:26:43 +0000
Received: by mail-bk0-f47.google.com with SMTP id mx12so4733542bkb.34
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 30 Nov 2013 09:26:36 -0800 (PST)
Received: from [192.168.1.188] (188-194-78-33-dynip.superkabel.de.
	[188.194.78.33])
	by mx.google.com with ESMTPSA id lr9sm11067192bkb.2.2013.11.30.09.26.34
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 30 Nov 2013 09:26:35 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

New USB stick, new partition, new broken file, new bug?

At first, I got this one consistently when trying to remove a certain 
ccache file. I don't recall there having been any crash during its creation.

The system would continue to run, but the process that tries to alter 
the file (and any subsequent ones trying to access the partition) would 
freeze indefinitely and become unkillable. Moving the file was fine, 
however.

Now the bug already happens when merely mounting the partition.

Happens both with 'pure' 3.12-rc2 and with rc2 that has the additional 
commits from f2fs.git applied (then in line 425, of course).

[  176.946443] kernel BUG at fs/f2fs/segment.c:214!
[  176.946453] invalid opcode: 0000 [#1] PREEMPT SMP
[  176.946484] Modules linked in: f2fs [...]
[  176.946693] CPU: 4 PID: 941 Comm: rm Not tainted 3.13.0-1-cu #1
[  176.946705] Hardware name: [...]
[  176.946723] task: ffff880407be8000 ti: ffff8803f22de000 task.ti: 
ffff8803f22de000
[  176.946764] RIP: 0010:[<ffffffffa10264de>]  [<ffffffffa10264de>] 
update_sit_entry+0x1ae/0x1c0 [f2fs]
[  176.946814] RSP: 0018:ffff8803f22dfce8  EFLAGS: 00010246
[  176.946827] RAX: 0000000000000002 RBX: ffff88009d688400 RCX: 
0000000000000000
[  176.946854] RDX: 0000000000000000 RSI: ffff88040783b742 RDI: 
ffff88009d688400
[  176.946868] RBP: ffff8803f22dfd20 R08: 00000000000578ff R09: 
0000000000000001
[  176.946897] R10: 0000000000000000 R11: ffffffff81894a80 R12: 
ffffc9001ddd3a40
[  176.946910] R13: 00000000ffffffff R14: 000000000000028c R15: 
0000000000000010
[  176.946923] FS:  00007f2e21a4b700(0000) GS:ffff88041f300000(0000) 
knlGS:0000000000000000
[  176.946938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  176.946949] CR2: 00007f2e215f28c2 CR3: 00000004093b8000 CR4: 
00000000001407e0
[  176.946976] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  176.946989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  176.947016] Stack:
[  176.947021]  ffff880409db8540 0000000000087069 ffff88009d688400 
0000000000058313
[  176.947037]  000000000000028c ffff880409db8578 ffff8803f22dfda8 
ffff8803f22dfd50
[  176.947053]  ffffffffa10279ca 0000000000000384 ffff8803f21a21c8 
0000000000000000
[  176.947083] Call Trace:
[  176.947092]  [<ffffffffa10279ca>] invalidate_blocks+0x5a/0x90 [f2fs]
[  176.947105]  [<ffffffffa1015e44>] 
truncate_data_blocks_range+0xb4/0x1a0 [f2fs]
[  176.947132]  [<ffffffffa1016363>] f2fs_truncate+0x413/0x4a0 [f2fs]
[  176.947145]  [<ffffffffa1017719>] f2fs_evict_inode+0x169/0x170 [f2fs]
[  176.947158]  [<ffffffff811a7660>] evict+0xb0/0x1b0
[  176.947181]  [<ffffffff811a7ec5>] iput+0xf5/0x190
[  176.947191]  [<ffffffff8119ce6e>] do_unlinkat+0x18e/0x2c0
[  176.947228]  [<ffffffff8119293a>] ? SyS_newfstatat+0x2a/0x40
[  176.947239]  [<ffffffff8119dceb>] SyS_unlinkat+0x1b/0x40
[  176.947264]  [<ffffffff814cd9ed>] system_call_fastpath+0x1a/0x1f
[  176.947286] Code: 41 f7 d7 ba 01 00 00 00 49 03 74 24 08 41 83 e7 07 
c4 62 01 f7 fa 44 89 fa f7 d2 0f be 0e 21 ca 44 85 f9 88 16 0f 85 23 ff 
ff ff <0f> 0b 0f 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
[  176.947454] RIP  [<ffffffffa10264de>] update_sit_entry+0x1ae/0x1c0 [f2fs]
[  176.947482]  RSP <ffff8803f22dfce8>
[  176.952488] ---[ end trace c52979080a2fdd18 ]---

fsck.f2fs -d 3 fails at the ccache file with:

fsck_chk_dentry_blk: 581] [  2] - no[0x91] 
name[0664f511326d6c4fbe5b0d2a903ed4-5381161.o] len[0x28] ino[0x338a09] 
type[0x1]

Assertion failed!
[fsck_chk_data_blk: 633] 0
  --> SIT bitmap is 0x0. blk_addr[0x58313]

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
