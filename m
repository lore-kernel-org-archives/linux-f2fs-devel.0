From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix to set superblock dirty correctly
Date: Mon, 29 Aug 2016 09:45:45 -0700
Message-ID: <20160829164545.GB94184@jaegeuk>
References: <1472390446-2425-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472390446-2425-1-git-send-email-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Sun, Aug 28, 2016 at 09:20:46PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> tests/generic/251 of fstest suit complains us with below message:
> 
> ------------[ cut here ]------------
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 2 PID: 7698 Comm: fstrim Tainted: G           O    4.7.0+ #21
> task: e9f4e000 task.stack: e7262000
> EIP: 0060:[<f89fcefe>] EFLAGS: 00010202 CPU: 2
> EIP is at write_checkpoint+0xfde/0x1020 [f2fs]
> EAX: f33eb300 EBX: eecac310 ECX: 00000001 EDX: ffff0001
> ESI: eecac000 EDI: eecac5f0 EBP: e7263dec ESP: e7263d18
>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> CR0: 80050033 CR2: b76ab01c CR3: 2eb89de0 CR4: 000406f0
> Stack:
>  00000001 a220fb7b e9f4e000 00000002 419ff2d3 b3a05151 00000002 e9f4e5d8
>  e9f4e000 419ff2d3 b3a05151 eecac310 c10b8154 b3a05151 419ff2d3 c10b78bd
>  e9f4e000 e9f4e000 e9f4e5d8 00000001 e9f4e000 ec409000 eecac2cc eecac288
> Call Trace:
>  [<c10b8154>] ? __lock_acquire+0x3c4/0x760
>  [<c10b78bd>] ? mark_held_locks+0x5d/0x80
>  [<f8a10632>] f2fs_trim_fs+0x1c2/0x2e0 [f2fs]
>  [<f89e9f56>] f2fs_ioctl+0x6b6/0x10b0 [f2fs]
>  [<c13d51df>] ? __this_cpu_preempt_check+0xf/0x20
>  [<c10b4281>] ? trace_hardirqs_off_caller+0x91/0x120
>  [<f89e98a0>] ? __exchange_data_block+0xd30/0xd30 [f2fs]
>  [<c120b2e1>] do_vfs_ioctl+0x81/0x7f0
>  [<c11d57c5>] ? kmem_cache_free+0x245/0x2e0
>  [<c1217840>] ? get_unused_fd_flags+0x40/0x40
>  [<c1206eec>] ? putname+0x4c/0x50
>  [<c11f631e>] ? do_sys_open+0x16e/0x1d0
>  [<c1001990>] ? do_fast_syscall_32+0x30/0x1c0
>  [<c13d51df>] ? __this_cpu_preempt_check+0xf/0x20
>  [<c120baa8>] SyS_ioctl+0x58/0x80
>  [<c1001a01>] do_fast_syscall_32+0xa1/0x1c0
>  [<c178cc54>] sysenter_past_esp+0x45/0x74
> EIP: [<f89fcefe>] write_checkpoint+0xfde/0x1020 [f2fs] SS:ESP 0068:e7263d18
> ---[ end trace 4de95d7e6b3aa7c6 ]---
> 
> The reason is: with below call stack, we will encounter BUG_ON during
> doing fstrim.
> 
> Thread A				Thread B
> - write_checkpoint
>  - do_checkpoint
> 					- f2fs_write_inode
> 					 - update_inode_page
> 					  - update_inode
> 					   - set_page_dirty
> 					    - f2fs_set_node_page_dirty
> 					     - inc_page_count
> 					      - percpu_counter_inc
> 					      - set_sbi_flag(SBI_IS_DIRTY)
>   - clear_sbi_flag(SBI_IS_DIRTY)
> 
> Thread C				Thread D
> - f2fs_write_node_page
>  - set_node_addr
>   - __set_nat_cache_dirty
>    - nm_i->dirty_nat_cnt++
> 					- do_vfs_ioctl
> 					 - f2fs_ioctl
> 					  - f2fs_trim_fs
> 					   - write_checkpoint
> 					    - f2fs_bug_on(nm_i->dirty_nat_cnt)
> 
> Fix it by setting superblock dirty correctly in do_checkpoint and
> f2fs_write_node_page.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 8 ++++++++
>  fs/f2fs/node.c       | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index cd0443d..1864078 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1153,6 +1153,14 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	clear_prefree_segments(sbi, cpc);
>  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
>  
> +	/*
> +	 * redirty superblock if metadata like node page or inode cache is
> +	 * updated during writting checkpoint.
> +	 */
> +	if (get_pages(sbi, F2FS_DIRTY_NODES) ||
> +			get_pages(sbi, F2FS_DIRTY_IMETA))
> +		set_sbi_flag(sbi, SBI_IS_DIRTY);

How about adding f2fs_bug_on(get_pages(sb, F2FS_DIRTY_DENTS)); ?

> +
>  	return 0;
>  }
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 8a28800..365c6ff 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1597,6 +1597,7 @@ static int f2fs_write_node_page(struct page *page,
>  	fio.old_blkaddr = ni.blk_addr;
>  	write_node_page(nid, &fio);
>  	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
> +	set_sbi_flag(sbi, SBI_IS_DIRTY);

It doesn't need to set this, right?

Thanks,

>  	dec_page_count(sbi, F2FS_DIRTY_NODES);
>  	up_read(&sbi->node_write);
>  
> -- 
> 2.7.2
