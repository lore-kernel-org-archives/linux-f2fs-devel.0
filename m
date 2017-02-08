From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: change recovery policy of xattr
	node block
Date: Wed, 8 Feb 2017 18:05:33 +0800
Message-ID: <299ccc45-5564-5471-c052-fc82474b9c5d@huawei.com>
References: <20170208093945.24681-1-yuchao0@huawei.com>
	<20170208093945.24681-2-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cbP8j-0002Ix-GE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 10:06:17 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cbP8X-00032a-TC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 10:06:17 +0000
In-Reply-To: <20170208093945.24681-2-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

This is really old topic, I just update and send the patch with last kernel.

As described in the patch, I think it is worth to change recovery policy of
xattr node block for improving performance of fsync.

And as you mentioned last time, xattr node is not updated frequently, so change
temperature of xattr node directly is not appropriate, I'm think that maybe we
can introduce new log for storing xattr node, so that, 'cold' xattr node will
not mixed with warm node.

How do you think?

Thanks,

On 2017/2/8 17:39, Chao Yu wrote:
> Currently, if we call fsync after updating the xattr date belongs to the
> file, f2fs needs to trigger checkpoint to keep xattr data consistent. But,
> this policy cause low performance as checkpoint will block most foreground
> operations and cause unneeded and unrelated IOs around checkpoint.
> 
> This patch will reuse regular file recovery policy for xattr node block,
> so, we change to write xattr node block tagged with fsync flag to warm
> area instead of cold area, and during recovery, we search warm node chain
> for fsynced xattr block, and do the recovery.
> 
> So, for below application IO pattern, performance can be improved
> obviously:
> - touch file
> - create/update/delete xattr entry in file
> - fsync file
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h     |  3 +--
>  fs/f2fs/file.c     |  3 ---
>  fs/f2fs/node.c     | 29 +++++++++++++++++------------
>  fs/f2fs/node.h     |  2 +-
>  fs/f2fs/recovery.c |  8 +++-----
>  fs/f2fs/xattr.c    |  2 --
>  6 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c9a97c369c4c..5c87d763a347 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -455,7 +455,6 @@ struct f2fs_inode_info {
>  	f2fs_hash_t chash;		/* hash value of given file name */
>  	unsigned int clevel;		/* maximum level of given file name */
>  	nid_t i_xattr_nid;		/* node id that contains xattrs */
> -	unsigned long long xattr_ver;	/* cp version of xattr modification */
>  	loff_t	last_disk_size;		/* lastly written file size */
>  
>  	struct list_head dirty_list;	/* dirty list for dirs and files */
> @@ -2125,7 +2124,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
>  void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
>  int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
>  void recover_inline_xattr(struct inode *inode, struct page *page);
> -void recover_xattr_data(struct inode *inode, struct page *page,
> +int recover_xattr_data(struct inode *inode, struct page *page,
>  			block_t blkaddr);
>  int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
>  int restore_node_summary(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a3808c49e326..120164815030 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -142,8 +142,6 @@ static inline bool need_do_checkpoint(struct inode *inode)
>  		need_cp = true;
>  	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
>  		need_cp = true;
> -	else if (F2FS_I(inode)->xattr_ver == cur_cp_version(F2FS_CKPT(sbi)))
> -		need_cp = true;
>  	else if (test_opt(sbi, FASTBOOT))
>  		need_cp = true;
>  	else if (sbi->active_logs == 2)
> @@ -169,7 +167,6 @@ static void try_to_fix_pino(struct inode *inode)
>  	nid_t pino;
>  
>  	down_write(&fi->i_sem);
> -	fi->xattr_ver = 0;
>  	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
>  			get_parent_ino(inode, &pino)) {
>  		f2fs_i_pino_write(inode, pino);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index ef3a4915f1bc..30bf6e31eb27 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -971,9 +971,6 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
>  
>  	f2fs_i_xnid_write(inode, 0);
>  
> -	/* need to do checkpoint during fsync */
> -	F2FS_I(inode)->xattr_ver = cur_cp_version(F2FS_CKPT(sbi));
> -
>  	set_new_dnode(&dn, inode, page, npage, nid);
>  
>  	if (page)
> @@ -2055,18 +2052,18 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
>  	f2fs_put_page(ipage, 1);
>  }
>  
> -void recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
> +int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
>  	nid_t new_xnid = nid_of_node(page);
>  	struct node_info ni;
> +	struct page *xpage;
>  
> -	/* 1: invalidate the previous xattr nid */
>  	if (!prev_xnid)
>  		goto recover_xnid;
>  
> -	/* Deallocate node address */
> +	/* 1: invalidate the previous xattr nid */
>  	get_node_info(sbi, prev_xnid, &ni);
>  	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
>  	invalidate_blocks(sbi, ni.blk_addr);
> @@ -2074,19 +2071,27 @@ void recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
>  	set_node_addr(sbi, &ni, NULL_ADDR, false);
>  
>  recover_xnid:
> -	/* 2: allocate new xattr nid */
> +	/* 2: update xattr nid in inode */
> +	remove_free_nid(sbi, new_xnid);
> +	f2fs_i_xnid_write(inode, new_xnid);
>  	if (unlikely(!inc_valid_node_count(sbi, inode)))
>  		f2fs_bug_on(sbi, 1);
> +	update_inode_page(inode);
> +
> +	/* 3: update and set xattr node page dirty */
> +	xpage = grab_cache_page(NODE_MAPPING(sbi), new_xnid);
> +	if (!xpage)
> +		return -ENOMEM;
> +
> +	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), PAGE_SIZE);
>  
> -	remove_free_nid(sbi, new_xnid);
>  	get_node_info(sbi, new_xnid, &ni);
>  	ni.ino = inode->i_ino;
>  	set_node_addr(sbi, &ni, NEW_ADDR, false);
> -	f2fs_i_xnid_write(inode, new_xnid);
> +	set_page_dirty(xpage);
> +	f2fs_put_page(xpage, 1);
>  
> -	/* 3: update xattr blkaddr */
> -	refresh_sit_entry(sbi, NEW_ADDR, blkaddr);
> -	set_node_addr(sbi, &ni, blkaddr, false);
> +	return 0;
>  }
>  
>  int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 29ff783eb9c3..d3d289306469 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -358,7 +358,7 @@ static inline bool IS_DNODE(struct page *node_page)
>  	unsigned int ofs = ofs_of_node(node_page);
>  
>  	if (f2fs_has_xattr_block(ofs))
> -		return false;
> +		return true;
>  
>  	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
>  			ofs == 5 + 2 * NIDS_PER_BLOCK)
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index e93316ea8d1b..d025aa83fb5b 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -378,11 +378,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  	if (IS_INODE(page)) {
>  		recover_inline_xattr(inode, page);
>  	} else if (f2fs_has_xattr_block(ofs_of_node(page))) {
> -		/*
> -		 * Deprecated; xattr blocks should be found from cold log.
> -		 * But, we should remain this for backward compatibility.
> -		 */
> -		recover_xattr_data(inode, page, blkaddr);
> +		err = recover_xattr_data(inode, page, blkaddr);
> +		if (!err)
> +			recovered++;
>  		goto out;
>  	}
>  
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index f7482635a57d..b50f6b581a71 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -458,8 +458,6 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>  	set_page_dirty(xpage);
>  	f2fs_put_page(xpage, 1);
>  
> -	/* need to checkpoint during fsync */
> -	F2FS_I(inode)->xattr_ver = cur_cp_version(F2FS_CKPT(sbi));
>  	return 0;
>  }
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
