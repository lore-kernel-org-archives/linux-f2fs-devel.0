From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: call set_page_dirty to attach i_wb
 for	cgroup
Date: Tue, 28 Jul 2015 18:29:38 +0800
Message-ID: <00e501d0c920$68398180$38ac8480$@samsung.com>
References: <1437870077-46892-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZK29R-000217-JM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:30:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZK29P-0005or-Lj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:30:25 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NS700NKR16GNA20@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 19:30:16 +0900 (KST)
In-reply-to: <1437870077-46892-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, July 26, 2015 8:21 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: call set_page_dirty to attach i_wb for cgroup
> 
> The cgroup attaches inode->i_wb via mark_inode_dirty and when set_page_writeback
> is called, __inc_wb_stat() updates i_wb's stat.
> 
> So, we need to explicitly call set_page_dirty->__mark_inode_dirty in prior to
> any writebacking pages.
> 
> This patch should resolve the following kernel panic reported by Andreas Reis.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=101801
> 
> --- Comment #2 from Andreas Reis <andreas.reis@gmail.com> ---
> BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
> IP: [<ffffffff8149deea>] __percpu_counter_add+0x1a/0x90
> PGD 2951ff067 PUD 2df43f067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 7 PID: 10356 Comm: gcc Tainted: G        W       4.2.0-1-cu #1
> Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper M5/G1.Sniper M5, BIOS
> T01 02/03/2015
> task: ffff880295044f80 ti: ffff880295140000 task.ti: ffff880295140000
> RIP: 0010:[<ffffffff8149deea>]  [<ffffffff8149deea>]
> __percpu_counter_add+0x1a/0x90
> RSP: 0018:ffff880295143ac8  EFLAGS: 00010082
> RAX: 0000000000000003 RBX: ffffea000a526d40 RCX: 0000000000000001
> RDX: 0000000000000020 RSI: 0000000000000001 RDI: 0000000000000088
> RBP: ffff880295143ae8 R08: 0000000000000000 R09: ffff88008f69bb30
> R10: 00000000fffffffa R11: 0000000000000000 R12: 0000000000000088
> R13: 0000000000000001 R14: ffff88041d099000 R15: ffff880084a205d0
> FS:  00007f8549374700(0000) GS:ffff88042f3c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000a8 CR3: 000000033e1d5000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Stack:
>  0000000000000000 ffffea000a526d40 ffff880084a20738 ffff880084a20750
>  ffff880295143b48 ffffffff811cc91e ffff880000000000 0000000000000296
>  0000000000000000 ffff880417090198 0000000000000000 ffffea000a526d40
> Call Trace:
>  [<ffffffff811cc91e>] __test_set_page_writeback+0xde/0x1d0
>  [<ffffffff813fee87>] do_write_data_page+0xe7/0x3a0
>  [<ffffffff813faeea>] gc_data_segment+0x5aa/0x640
>  [<ffffffff813fb0b8>] do_garbage_collect+0x138/0x150
>  [<ffffffff813fb3fe>] f2fs_gc+0x1be/0x3e0
>  [<ffffffff81405541>] f2fs_balance_fs+0x81/0x90
>  [<ffffffff813ee357>] f2fs_unlink+0x47/0x1d0
>  [<ffffffff81239329>] vfs_unlink+0x109/0x1b0
>  [<ffffffff8123e3d7>] do_unlinkat+0x287/0x2c0
>  [<ffffffff8123ebc6>] SyS_unlink+0x16/0x20
>  [<ffffffff81942e2e>] entry_SYSCALL_64_fastpath+0x12/0x71
> Code: 41 5e 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 55 49
> 89 f5 41 54 49 89 fc 53 48 83 ec 08 65 ff 05 e6 d9 b6 7e <48> 8b 47 20 48 63 ca
> 65 8b 18 48 63 db 48 01 f3 48 39 cb 7d 0a
> RIP  [<ffffffff8149deea>] __percpu_counter_add+0x1a/0x90
>  RSP <ffff880295143ac8>
> CR2: 00000000000000a8
> ---[ end trace 5132449a58ed93a3 ]---
> note: gcc[10356] exited with preempt_count 2
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good catch!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

BTW, is this commit facd126d961d ("f2fs: fix wrong f2fs_put_page call for an error case")
be submitted incorrectly? it seems not a good fix.

Thanks,


------------------------------------------------------------------------------
