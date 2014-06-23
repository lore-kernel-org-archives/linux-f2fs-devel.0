From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: introduce f2fs_do_tmpfile for code
	consistency
Date: Mon, 23 Jun 2014 11:13:09 +0800
Message-ID: <000401cf8e91$2b93c3a0$82bb4ae0$@samsung.com>
References: <1403485976-29398-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Wyuht-0006jq-7f
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 03:14:09 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wyuhp-00049J-B6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 03:14:09 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7L00KJBQB9EO00@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 12:13:57 +0900 (KST)
In-reply-to: <1403485976-29398-1-git-send-email-jaegeuk@kernel.org>
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

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, June 23, 2014 9:13 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Chao Yu
> Subject: [PATCH 1/2] f2fs: introduce f2fs_do_tmpfile for code consistency
> 
> This patch adds f2fs_do_tmpfile to eliminate the redundant init_inode_metadata
> flow.
> Throught this, we can provide the consistent lock usage, e.g., fi->i_sem,  and
> this will enable better debugging stuffs.
> 
> Cc: Chao Yu <chao2.yu@samsung.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c   | 27 ++++++++++++++++++++++++---
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/namei.c | 30 ++++++++----------------------
>  3 files changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 09760d5..fe6aaca 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -337,8 +337,7 @@ static struct page *init_inode_metadata(struct inode *inode,
>  	struct page *page;
>  	int err;
> 
> -	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE) &&
> -			inode->i_nlink) {
> +	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
>  		page = new_inode_page(inode, name);
>  		if (IS_ERR(page))
>  			return page;
> @@ -364,7 +363,8 @@ static struct page *init_inode_metadata(struct inode *inode,
>  		set_cold_node(inode, page);
>  	}
> 
> -	init_dent_inode(name, page);
> +	if (name)
> +		init_dent_inode(name, page);
> 
>  	/*
>  	 * This file should be checkpointed during fsync.
> @@ -537,6 +537,27 @@ fail:
>  	return err;
>  }
> 
> +int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
> +{
> +	struct page *page;
> +	int err = 0;
> +
> +	down_write(&F2FS_I(inode)->i_sem);

Here I did not find nlink/pino/xattr_ver which we should protect by ->i_sem,
Am I missing something?

> +	page = init_inode_metadata(inode, dir, NULL);
> +	if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
> +		goto fail;
> +	}
> +	/* we don't need to mark_inode_dirty now */
> +	update_inode(inode, page);
> +	f2fs_put_page(page, 1);
> +
> +	update_parent_metadata(dir, inode, F2FS_I(dir)->i_current_depth);

Things we did in update_parent_metadata() is: 1.clear FI_NEW_INODE of inode flag,
2. update mtime&ctime of dir and mark it dirty.
IMO, we do not need the update op because we do not access/modify current dir
as we did normally through f2fs_add_link path.
So how about using clear_inode_flag instead of update_parent_metadata and leave
current dir as clean?

Thanks,
Yu

> +fail:
> +	up_write(&F2FS_I(inode)->i_sem);
> +	return err;
> +}
> +
>  /*
>   * It only removes the dentry from the dentry page,corresponding name
>   * entry in name page does not need to be touched during deletion.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 58df97e..ca421a8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1136,6 +1136,7 @@ void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
>  int update_dent_inode(struct inode *, const struct qstr *);
>  int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *);
>  void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *);
> +int f2fs_do_tmpfile(struct inode *, struct inode *);
>  int f2fs_make_empty(struct inode *, struct inode *);
>  bool f2fs_empty_dir(struct inode *);
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 0d55517..9de4ab3 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -494,7 +494,6 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t
> mode)
>  	struct super_block *sb = dir->i_sb;
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	struct inode *inode;
> -	struct page *page;
>  	int err;
> 
>  	inode = f2fs_new_inode(dir, mode);
> @@ -509,38 +508,25 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t
> mode)
>  	err = acquire_orphan_inode(sbi);
>  	if (err)
>  		goto out;
> +
> +	err = f2fs_do_tmpfile(inode, dir);
> +	if (err)
> +		goto release_out;
> +
>  	/*
>  	 * add this non-linked tmpfile to orphan list, in this way we could
>  	 * remove all unused data of tmpfile after abnormal power-off.
>  	 */
>  	add_orphan_inode(sbi, inode->i_ino);
> -
> -	page = new_inode_page(inode, NULL);
> -	if (IS_ERR(page)) {
> -		err = PTR_ERR(page);
> -		goto remove_out;
> -	}
> -
> -	err = f2fs_init_acl(inode, dir, page);
> -	if (err)
> -		goto unlock_out;
> -
> -	err = f2fs_init_security(inode, dir, NULL, page);
> -	if (err)
> -		goto unlock_out;
> -
> -	f2fs_put_page(page, 1);
>  	f2fs_unlock_op(sbi);
> 
>  	alloc_nid_done(sbi, inode->i_ino);
> -	mark_inode_dirty(inode);
>  	d_tmpfile(dentry, inode);
>  	unlock_new_inode(inode);
>  	return 0;
> -unlock_out:
> -	f2fs_put_page(page, 1);
> -remove_out:
> -	remove_orphan_inode(sbi, inode->i_ino);
> +
> +release_out:
> +	release_orphan_inode(sbi);
>  out:
>  	f2fs_unlock_op(sbi);
>  	clear_nlink(inode);
> --
> 1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
