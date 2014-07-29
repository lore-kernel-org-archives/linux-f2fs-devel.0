From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 05/11] f2fs: add info of appended or updated
 data	writes
Date: Tue, 29 Jul 2014 19:38:21 +0800
Message-ID: <008101cfab21$b661b1c0$23251540$@samsung.com>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-5-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XC5kY-0001O7-F5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:39:22 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XC5kV-00077U-R1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:39:22 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9H00LHF1PBWY80@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 20:39:11 +0900 (KST)
In-reply-to: <1406328445-63707-5-git-send-email-jaegeuk@kernel.org>
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

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 26, 2014 6:47 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 05/11] f2fs: add info of appended or updated data writes
> 
> This patch introduces a inode number list in which represents inodes having
> appended data writes or updated data writes after last checkpoint.
> This will be used at fsync to determine whether the recovery information
> should be written or not.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/data.c       |  2 ++
>  fs/f2fs/f2fs.h       |  7 +++++++
>  fs/f2fs/inode.c      |  4 ++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d35094a..42a16c1 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -325,6 +325,44 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int
> type)
>  	spin_unlock(&sbi->ino_lock[type]);
>  }
> 
> +void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
> +{
> +	/* add new dirty ino entry into list */
> +	__add_ino_entry(sbi, ino, type);
> +}
> +
> +void remove_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
> +{
> +	/* remove dirty ino entry from list */
> +	__remove_ino_entry(sbi, ino, type);
> +}
> +
> +/* mode should be APPEND_INO or UPDATE_INO */
> +bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
> +{
> +	struct ino_entry *e;
> +	spin_lock(&sbi->ino_lock[mode]);
> +	e = radix_tree_lookup(&sbi->ino_root[mode], ino);
> +	spin_unlock(&sbi->ino_lock[mode]);
> +	return e ? true : false;
> +}
> +
> +static void release_dirty_inode(struct f2fs_sb_info *sbi)
> +{
> +	struct ino_entry *e, *tmp;
> +	int i;
> +
> +	for (i = APPEND_INO; i <= UPDATE_INO; i++) {
> +		spin_lock(&sbi->ino_lock[i]);
> +		list_for_each_entry_safe(e, tmp, &sbi->ino_list[i], list) {
> +			list_del(&e->list);
> +			radix_tree_delete(&sbi->ino_root[i], e->ino);
> +			kmem_cache_free(ino_entry_slab, e);
> +		}
> +		spin_unlock(&sbi->ino_lock[i]);
> +	}
> +}
> +
>  int acquire_orphan_inode(struct f2fs_sb_info *sbi)
>  {
>  	int err = 0;
> @@ -896,6 +934,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
> 
>  	if (unlikely(!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG))) {
>  		clear_prefree_segments(sbi);
> +		release_dirty_inode(sbi);
>  		F2FS_RESET_SB_DIRT(sbi);
>  	}
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 482313d..ec3c886 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -789,9 +789,11 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
>  			!is_cold_data(page) &&
>  			need_inplace_update(inode))) {
>  		rewrite_data_page(page, old_blkaddr, fio);
> +		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
>  	} else {
>  		write_data_page(page, &dn, &new_blkaddr, fio);
>  		update_extent_cache(new_blkaddr, &dn);
> +		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
>  	}
>  out_writepage:
>  	f2fs_put_dnode(&dn);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4454caa..ab36025 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -103,6 +103,8 @@ enum {
>  /* for the list of ino */
>  enum {
>  	ORPHAN_INO,		/* for orphan ino list */
> +	APPEND_INO,		/* for append ino list */
> +	UPDATE_INO,		/* for update ino list */
>  	MAX_INO_ENTRY,		/* max. list */
>  };
> 
> @@ -994,6 +996,8 @@ enum {
>  	FI_NO_EXTENT,		/* not to use the extent cache */
>  	FI_INLINE_XATTR,	/* used for inline xattr */
>  	FI_INLINE_DATA,		/* used for inline data*/
> +	FI_APPEND_WRITE,	/* inode has appended data */
> +	FI_UPDATE_WRITE,	/* inode has in-place-update data */
>  };
> 
>  static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
> @@ -1252,6 +1256,9 @@ struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
>  struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
>  int ra_meta_pages(struct f2fs_sb_info *, int, int, int);
>  long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
> +void add_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
> +void remove_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
> +bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
>  int acquire_orphan_inode(struct f2fs_sb_info *);
>  void release_orphan_inode(struct f2fs_sb_info *);
>  void add_orphan_inode(struct f2fs_sb_info *, nid_t);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index cafba3c..0e69aa9 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -296,6 +296,10 @@ void f2fs_evict_inode(struct inode *inode)
>  	sb_end_intwrite(inode->i_sb);
>  no_delete:
>  	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
> +	if (is_inode_flag_set(F2FS_I(inode), FI_APPEND_WRITE))
> +		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
> +	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
> +		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
>  out_clear:
>  	clear_inode(inode);
>  }
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
