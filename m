From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 2/2] f2fs: fix allocation failure
Date: Thu, 13 Oct 2016 13:49:07 -0700
Message-ID: <20161013204907.GC6363@jaegeuk>
References: <20161012161427.24419-1-chao@kernel.org>
 <20161012161427.24419-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161012161427.24419-2-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Oct 13, 2016 at 12:14:27AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> tests/generic/251 of fstest reports a f2fs bug in below message:
> 
> ------------[ cut here ]------------
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 109 Comm: kworker/u8:2 Tainted: G        W  O    4.8.0-rc4+ #22
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Workqueue: writeback wb_workfn (flush-251:1)
> task: f33c8000 task.stack: f33c6000
> EIP: 0060:[<f8992139>] EFLAGS: 00010246 CPU: 1
> EIP is at new_curseg+0x2c9/0x2d0 [f2fs]
> EAX: 000003f3 EBX: ee3e5000 ECX: 00000400 EDX: 000003f3
> ESI: 00000000 EDI: 00000008 EBP: f33c78c4 ESP: f33c7890
>  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> CR0: 80050033 CR2: b6706000 CR3: 2e8d70c0 CR4: 000406f0
> Stack:
>  eb29480c 00000004 f27a0290 000003f3 00000008 f33c78c0 00000001 eb294800
>  00000001 00000000 ee3e5000 f899dbb4 00000290 f33c7924 f89926d6 c10b42b6
>  00000246 00000000 eed513e8 00000246 f33c78e8 c10b7b4b f33c7924 c178c304
> Call Trace:
>  [<f89926d6>] allocate_segment_by_default+0x3c6/0x3d0 [f2fs]
>  [<f8992b3a>] allocate_data_block+0x13a/0x3c0 [f2fs]
>  [<f8992e4b>] do_write_page+0x8b/0x230 [f2fs]
>  [<f8993070>] write_node_page+0x20/0x30 [f2fs]
>  [<f898a156>] f2fs_write_node_page+0x1a6/0x340 [f2fs]
>  [<f898ca45>] sync_node_pages+0x4a5/0x590 [f2fs]
>  [<f897ea48>] write_checkpoint+0x218/0x720 [f2fs]
>  [<f898143d>] f2fs_gc+0x4cd/0x6b0 [f2fs]
>  [<f8990ebe>] f2fs_balance_fs+0x18e/0x1b0 [f2fs]
>  [<f8988017>] f2fs_write_data_page+0x197/0x6f0 [f2fs]
>  [<f89830fe>] f2fs_write_data_pages+0x28e/0x7e0 [f2fs]
>  [<c118b1cd>] do_writepages+0x1d/0x40
>  [<c1228cb5>] __writeback_single_inode+0x55/0x7e0
>  [<c1229b6b>] writeback_sb_inodes+0x21b/0x490
>  [<c1229f6c>] wb_writeback+0xdc/0x590
>  [<c122ae18>] wb_workfn+0xf8/0x690
>  [<c107c231>] process_one_work+0x1a1/0x580
>  [<c107c712>] worker_thread+0x102/0x440
>  [<c1082021>] kthread+0xa1/0xc0
>  [<c178f862>] ret_from_kernel_thread+0xe/0x24
> EIP: [<f8992139>] new_curseg+0x2c9/0x2d0 [f2fs] SS:ESP 0068:f33c7890
> 
> The reason is after f2fs enabled lazytime by default, when inode time is
> changed, we do not set this inode dirty through ->f2fs_dirty_inode, so
> itime updating will be delayed.
> 
> Finally it needs to update the dirty time of inode into inode page,
> and writeback the page, however, before that, we didn't count the inode
> as imeta data. So f2fs won't be aware of dirty metadata page count is
> exceeded watermark of GC, result in encountering panic when allocating
> free segment.
> 
> There is an easy way to produce this bug:
> 1. mount with lazytime option
> 2. fragment space
> 3. touch all files in the image
> 4. umount

I think modifying has_not_enough_secs() is enough like this.

---
 fs/f2fs/segment.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index fecb856..a6efb5c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -471,11 +471,12 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
 	if (test_opt(sbi, LFS))
 		return false;
 
-	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
+	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
 						reserved_sections(sbi) + 1);
 }
 
@@ -484,6 +485,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
 	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
 
@@ -491,7 +493,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 		return false;
 
 	return (free_sections(sbi) + freed) <=
-		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
+		(node_secs + 2 * dent_secs + imeta_secs +
+		reserved_sections(sbi) + needed);
 }
 
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
-- 
2.8.3

Thanks,

> 
> Introduce itime data type and related flow to trace & flush delayed
> updating inode to fix this issue.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 37 ++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h       |  5 +++++
>  fs/f2fs/file.c       |  1 +
>  fs/f2fs/namei.c      | 38 +++++++++++++++++++++++++++++++++
>  fs/f2fs/segment.h    | 11 ++++++----
>  fs/f2fs/super.c      | 59 +++++++++++++++++++++++++++++++++++++++++++++-------
>  6 files changed, 139 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d95fada..e27c64f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -928,6 +928,43 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
>  	return 0;
>  }
>  
> +int f2fs_sync_dirty_itime(struct f2fs_sb_info *sbi)
> +{
> +	struct list_head *head = &sbi->inode_list[DIRTY_ITIME];
> +	struct inode *inode;
> +	struct f2fs_inode_info *fi;
> +	s64 total = get_pages(sbi, F2FS_DIRTY_ITIME);
> +
> +	while (total--) {
> +		if (unlikely(f2fs_cp_error(sbi)))
> +			return -EIO;
> +
> +		spin_lock(&sbi->inode_lock[DIRTY_META]);
> +		if (list_empty(head)) {
> +			spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +			return 0;
> +		}
> +		fi = list_entry(head->next, struct f2fs_inode_info,
> +							gdirty_list);
> +		list_move_tail(&fi->gdirty_list, head);
> +		inode = igrab(&fi->vfs_inode);
> +		spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +		if (inode) {
> +			spin_lock(&inode->i_lock);
> +			if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> +				inode->i_state &= ~I_DIRTY_TIME;
> +				spin_unlock(&inode->i_lock);
> +				mark_inode_dirty_sync(inode);
> +			} else {
> +				spin_unlock(&inode->i_lock);
> +			}
> +
> +			iput(inode);
> +		}
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Freeze all the FS-operations for checkpoint.
>   */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5c19136..1f302ff 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -682,6 +682,7 @@ enum count_type {
>  	F2FS_DIRTY_META,
>  	F2FS_INMEM_PAGES,
>  	F2FS_DIRTY_IMETA,
> +	F2FS_DIRTY_ITIME,
>  	NR_COUNT_TYPE,
>  };
>  
> @@ -734,6 +735,7 @@ enum inode_type {
>  	DIR_INODE,			/* for dirty dir inode */
>  	FILE_INODE,			/* for dirty regular/symlink inode */
>  	DIRTY_META,			/* for all dirtied inode metadata */
> +	DIRTY_ITIME,			/* for all I_DIRTY_TIME taged inode */
>  	NR_INODE_TYPE,
>  };
>  
> @@ -1613,6 +1615,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  enum {
>  	FI_NEW_INODE,		/* indicate newly allocated inode */
>  	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
> +	FI_DIRTY_ITIME,		/* inode is dirtied due to time updating */
>  	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
>  	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
>  	FI_INC_LINK,		/* need to increment i_nlink */
> @@ -1968,6 +1971,7 @@ int update_inode_page(struct inode *);
>  int f2fs_write_inode(struct inode *, struct writeback_control *);
>  void f2fs_evict_inode(struct inode *);
>  void handle_failed_inode(struct inode *);
> +int f2fs_update_time(struct inode *, struct timespec *, int);
>  
>  /*
>   * namei.c
> @@ -2135,6 +2139,7 @@ void remove_ino_entry(struct f2fs_sb_info *, nid_t, int type);
>  void release_ino_entry(struct f2fs_sb_info *, bool);
>  bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
>  int f2fs_sync_inode_meta(struct f2fs_sb_info *);
> +int f2fs_sync_dirty_itime(struct f2fs_sb_info *);
>  int acquire_orphan_inode(struct f2fs_sb_info *);
>  void release_orphan_inode(struct f2fs_sb_info *);
>  void add_orphan_inode(struct inode *);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b46f6e1..88c8aeb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -777,6 +777,7 @@ const struct inode_operations f2fs_file_inode_operations = {
>  	.removexattr	= generic_removexattr,
>  #endif
>  	.fiemap		= f2fs_fiemap,
> +	.update_time	= f2fs_update_time,
>  };
>  
>  static int fill_zero(struct inode *inode, pgoff_t index,
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 300aef8..a219e93 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -18,6 +18,7 @@
>  
>  #include "f2fs.h"
>  #include "node.h"
> +#include "segment.h"
>  #include "xattr.h"
>  #include "acl.h"
>  #include <trace/events/f2fs.h>
> @@ -1074,6 +1075,39 @@ errout:
>  	return ERR_PTR(res);
>  }
>  
> +int f2fs_update_time(struct inode *inode, struct timespec *time, int flags)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int iflags = I_DIRTY_TIME;
> +
> +	if (flags & S_ATIME)
> +		inode->i_atime = *time;
> +	if (flags & S_VERSION)
> +		inode_inc_iversion(inode);
> +	if (flags & S_CTIME)
> +		inode->i_ctime = *time;
> +	if (flags & S_MTIME)
> +		inode->i_mtime = *time;
> +
> +	if (!(inode->i_sb->s_flags & MS_LAZYTIME) || (flags & S_VERSION))
> +		iflags |= I_DIRTY_SYNC;
> +
> +	if (iflags == I_DIRTY_TIME) {
> +		int itime_secs = get_blocktype_secs(sbi, F2FS_DIRTY_ITIME);
> +
> +		if (itime_secs >= 16 || (itime_secs >= 8 &&
> +				has_not_enough_free_secs(sbi, 0, 0))) {
> +			f2fs_sync_dirty_itime(sbi);
> +			mutex_lock(&sbi->gc_mutex);
> +			f2fs_gc(sbi, false);
> +			iflags |= I_DIRTY_SYNC;
> +		}
> +	}
> +
> +	__mark_inode_dirty(inode, iflags);
> +	return 0;
> +}
> +
>  const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
>  	.readlink       = generic_readlink,
>  	.get_link       = f2fs_encrypted_get_link,
> @@ -1085,6 +1119,7 @@ const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
>  	.listxattr	= f2fs_listxattr,
>  	.removexattr	= generic_removexattr,
>  #endif
> +	.update_time	= f2fs_update_time,
>  };
>  
>  const struct inode_operations f2fs_dir_inode_operations = {
> @@ -1108,6 +1143,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
>  	.listxattr	= f2fs_listxattr,
>  	.removexattr	= generic_removexattr,
>  #endif
> +	.update_time	= f2fs_update_time,
>  };
>  
>  const struct inode_operations f2fs_symlink_inode_operations = {
> @@ -1121,6 +1157,7 @@ const struct inode_operations f2fs_symlink_inode_operations = {
>  	.listxattr	= f2fs_listxattr,
>  	.removexattr	= generic_removexattr,
>  #endif
> +	.update_time	= f2fs_update_time,
>  };
>  
>  const struct inode_operations f2fs_special_inode_operations = {
> @@ -1134,4 +1171,5 @@ const struct inode_operations f2fs_special_inode_operations = {
>  	.listxattr	= f2fs_listxattr,
>  	.removexattr    = generic_removexattr,
>  #endif
> +	.update_time	= f2fs_update_time,
>  };
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index fecb856..116577e 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -471,12 +471,14 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
>  {
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	int itime_secs = get_blocktype_secs(sbi, F2FS_DIRTY_ITIME);
>  
>  	if (test_opt(sbi, LFS))
>  		return false;
>  
>  	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
> -						reserved_sections(sbi) + 1);
> +		imeta_secs + itime_secs + reserved_sections(sbi) + 1);
>  }
>  
>  static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
> @@ -484,14 +486,15 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  {
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> -
> -	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +	int itime_secs = get_blocktype_secs(sbi, F2FS_DIRTY_ITIME);
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		return false;
>  
>  	return (free_sections(sbi) + freed) <=
> -		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
> +		(node_secs + 2 * dent_secs + imeta_secs + itime_secs +
> +		reserved_sections(sbi) + needed);
>  }
>  
>  static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e38c9d2..93e3b07 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -620,16 +620,49 @@ static int f2fs_drop_inode(struct inode *inode)
>  	return generic_drop_inode(inode);
>  }
>  
> +int f2fs_set_inode_dirty_time(struct inode *inode)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +
> +	spin_lock(&sbi->inode_lock[DIRTY_META]);
> +	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
> +		spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +		return 0;
> +	}
> +
> +	if (is_inode_flag_set(inode, FI_DIRTY_ITIME)) {
> +		spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +		return 0;
> +	}
> +
> +	set_inode_flag(inode, FI_DIRTY_ITIME);
> +	list_add_tail(&F2FS_I(inode)->gdirty_list,
> +				&sbi->inode_list[DIRTY_ITIME]);
> +	inc_page_count(sbi, F2FS_DIRTY_ITIME);
> +	stat_inc_dirty_inode(sbi, DIRTY_ITIME);
> +	spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +
> +	return 1;
> +}
> +
>  int f2fs_inode_dirtied(struct inode *inode)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
>  	spin_lock(&sbi->inode_lock[DIRTY_META]);
> +	if (is_inode_flag_set(inode, FI_DIRTY_ITIME)) {
> +		clear_inode_flag(inode, FI_DIRTY_ITIME);
> +		list_del_init(&F2FS_I(inode)->gdirty_list);
> +		dec_page_count(sbi, F2FS_DIRTY_ITIME);
> +		stat_dec_dirty_inode(sbi, DIRTY_ITIME);
> +		goto mark_dirty;
> +	}
> +
>  	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  		return 1;
>  	}
> -
> +mark_dirty:
>  	set_inode_flag(inode, FI_DIRTY_INODE);
>  	list_add_tail(&F2FS_I(inode)->gdirty_list,
>  				&sbi->inode_list[DIRTY_META]);
> @@ -645,15 +678,23 @@ void f2fs_inode_synced(struct inode *inode)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
>  	spin_lock(&sbi->inode_lock[DIRTY_META]);
> -	if (!is_inode_flag_set(inode, FI_DIRTY_INODE)) {
> +	if (is_inode_flag_set(inode, FI_DIRTY_ITIME)) {
> +		clear_inode_flag(inode, FI_DIRTY_ITIME);
> +		list_del_init(&F2FS_I(inode)->gdirty_list);
> +		dec_page_count(sbi, F2FS_DIRTY_ITIME);
> +		stat_dec_dirty_inode(sbi, DIRTY_ITIME);
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  		return;
>  	}
> -	list_del_init(&F2FS_I(inode)->gdirty_list);
> -	clear_inode_flag(inode, FI_DIRTY_INODE);
> -	clear_inode_flag(inode, FI_AUTO_RECOVER);
> -	dec_page_count(sbi, F2FS_DIRTY_IMETA);
> -	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
> +
> +	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
> +		clear_inode_flag(inode, FI_DIRTY_INODE);
> +		clear_inode_flag(inode, FI_AUTO_RECOVER);
> +		list_del_init(&F2FS_I(inode)->gdirty_list);
> +		dec_page_count(sbi, F2FS_DIRTY_IMETA);
> +		stat_dec_dirty_inode(sbi, DIRTY_META);
> +	}
> +
>  	spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  }
>  
> @@ -670,8 +711,10 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
>  			inode->i_ino == F2FS_META_INO(sbi))
>  		return;
>  
> -	if (flags == I_DIRTY_TIME)
> +	if (flags == I_DIRTY_TIME) {
> +		f2fs_set_inode_dirty_time(inode);
>  		return;
> +	}
>  
>  	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
>  		clear_inode_flag(inode, FI_AUTO_RECOVER);
> -- 
> 2.10.1
