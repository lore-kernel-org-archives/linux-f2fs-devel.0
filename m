From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: fix to flush all dirty inodes
 recovered in readonly fs
Date: Thu, 6 Sep 2018 11:13:57 +0800
Message-ID: <6a980c80-58b0-f3b4-39f5-f4ab1795993d@huawei.com>
References: <20180822091105.33973-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fxkkC-0006ue-GI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 03:14:08 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxkkA-002X8d-Sr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 03:14:08 +0000
In-Reply-To: <20180822091105.33973-1-yuchao0@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Ping,

On 2018/8/22 17:11, Chao Yu wrote:
> generic/417 reported as blow:
> 
> ------------[ cut here ]------------
> kernel BUG at /home/yuchao/git/devf2fs/inode.c:695!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 21697 Comm: umount Tainted: G        W  O      4.18.0-rc2+ #39
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> EIP: f2fs_evict_inode+0x556/0x580 [f2fs]
> Call Trace:
>  ? _raw_spin_unlock+0x2c/0x50
>  evict+0xa8/0x170
>  dispose_list+0x34/0x40
>  evict_inodes+0x118/0x120
>  generic_shutdown_super+0x41/0x100
>  ? rcu_read_lock_sched_held+0x97/0xa0
>  kill_block_super+0x22/0x50
>  kill_f2fs_super+0x6f/0x80 [f2fs]
>  deactivate_locked_super+0x3d/0x70
>  deactivate_super+0x40/0x60
>  cleanup_mnt+0x39/0x70
>  __cleanup_mnt+0x10/0x20
>  task_work_run+0x81/0xa0
>  exit_to_usermode_loop+0x59/0xa7
>  do_fast_syscall_32+0x1f5/0x22c
>  entry_SYSENTER_32+0x53/0x86
> EIP: f2fs_evict_inode+0x556/0x580 [f2fs]
> 
> It can simply reproduced with scripts:
> 
> Enable quota feature during mkfs.
> 
> Testcase1:
> 1. mkfs.f2fs /dev/zram0
> 2. mount -t f2fs /dev/zram0 /mnt/f2fs
> 3. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4k" -c "fsync"
> 4. godown /mnt/f2fs
> 5. umount /mnt/f2fs
> 6. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
> 7. umount /mnt/f2fs
> 
> Testcase2:
> 1. mkfs.f2fs /dev/zram0
> 2. mount -t f2fs /dev/zram0 /mnt/f2fs
> 3. touch /mnt/f2fs/file
> 4. create process[pid = x] do:
> 	a) open /mnt/f2fs/file;
> 	b) unlink /mnt/f2fs/file
> 5. godown -f /mnt/f2fs
> 6. kill process[pid = x]
> 7. umount /mnt/f2fs
> 8. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
> 9. umount /mnt/f2fs
> 
> The reason is: during recovery, i_{c,m}time of inode will be updated, then
> the inode can be set dirty w/o being tracked in sbi->inode_list[DIRTY_META]
> global list, so later write_checkpoint will not flush such dirty inode into
> node page.
> 
> Once umount is called, sync_filesystem() in generic_shutdown_super() will
> skip syncng dirty inodes due to sb_rdonly check, leaving dirty inodes
> there.
> 
> To solve this issue, during umount, add remove SB_RDONLY flag in
> sb->s_flags, to make sure sync_filesystem() will not be skipped.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v4:
> - fix to use set_sbi_flag.
> - clean up with f2fs_readonly.
>  fs/f2fs/checkpoint.c |  2 ++
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/recovery.c   | 14 +++++++++-----
>  fs/f2fs/super.c      |  3 +++
>  4 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0274446f585e..5f61e9b8c678 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -696,6 +696,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  	/* clear Orphan Flag */
>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>  out:
> +	set_sbi_flag(sbi, SBI_IS_RECOVERED);
> +
>  #ifdef CONFIG_QUOTA
>  	/* Turn quotas off */
>  	if (quota_enabled)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e100af9afe38..e9009e8d30e2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1091,6 +1091,7 @@ enum {
>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
> +	SBI_IS_RECOVERED,			/* recovered orphan/data */
>  };
>  
>  enum {
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 95511ed11a22..e3aa6eee7a8b 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -697,11 +697,15 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	/* let's drop all the directory inodes for clean checkpoint */
>  	destroy_fsync_dnodes(&dir_list);
>  
> -	if (!err && need_writecp) {
> -		struct cp_control cpc = {
> -			.reason = CP_RECOVERY,
> -		};
> -		err = f2fs_write_checkpoint(sbi, &cpc);
> +	if (need_writecp) {
> +		set_sbi_flag(sbi, SBI_IS_RECOVERED);
> +
> +		if (!err) {
> +			struct cp_control cpc = {
> +				.reason = CP_RECOVERY,
> +			};
> +			err = f2fs_write_checkpoint(sbi, &cpc);
> +		}
>  	}
>  
>  	kmem_cache_destroy(fsync_entry_slab);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ab9e0921f207..9587e57f8d93 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3215,6 +3215,9 @@ static void kill_f2fs_super(struct super_block *sb)
>  			};
>  			f2fs_write_checkpoint(sbi, &cpc);
>  		}
> +
> +		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && f2fs_readonly(sb))
> +			sb->s_flags &= ~SB_RDONLY;
>  	}
>  	kill_block_super(sb);
>  }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
