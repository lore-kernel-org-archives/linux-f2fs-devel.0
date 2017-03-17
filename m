From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: cleanup the disk level filename
	updating
Date: Fri, 17 Mar 2017 15:04:24 +0800
Message-ID: <5632103e-5b06-d919-1f52-e997720924c6@huawei.com>
References: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
	<eda73163-e95f-6c40-05e1-673eba87a530@gmail.com>
	<7b158dd2-9b72-bf75-e0c0-29cb364d24ea@gmail.com>
	<f3794fb1-256b-049a-1146-cdffa5e8c5d5@gmail.com>
	<20170307193029.GA2499@jaegeuk.local>
	<71b63777-c504-30d2-014b-718eb31b62c3@gmail.com>
	<481d729a-c82f-0542-c73f-93c73fa9a3a8@gmail.com>
	<20170310022330.GA17988@jaegeuk.local>
	<89421365-280c-1659-e467-e5f736f55ab7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1colwG-0003WC-5W
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 07:04:40 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1colwE-0007zK-8c
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 07:04:40 +0000
In-Reply-To: <89421365-280c-1659-e467-e5f736f55ab7@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/3/10 16:28, Kinglong Mee wrote:
> As discuss with Jaegeuk and Chao,
> "Once checkpoint is done, f2fs doesn't need to update there-in filename at all."
> 
> The disk-level filename is used only one case,
> 1. create a file A under a dir
> 2. sync A
> 3. godown
> 4. umount
> 5. mount (roll_forward)
> 
> Only the rename/cross_rename changes the filename, if it happens,
> a. between step 1 and 2, the sync A will caused checkpoint, so that,
>    the roll_forward at step 5 never happens.
> b. after step 2, the roll_forward happens, file A will roll forward
>    to the result as after step 1.
> 
> So that, any updating the disk filename is useless, just cleanup it.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/dir.c    | 25 ++++---------------------
>  fs/f2fs/f2fs.h   |  2 --
>  fs/f2fs/file.c   |  8 --------
>  fs/f2fs/inline.c |  2 --
>  fs/f2fs/namei.c  | 29 -----------------------------
>  5 files changed, 4 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 8d5c62b..058c4f3 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -337,24 +337,6 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
>  	set_page_dirty(ipage);
>  }
>  
> -int update_dent_inode(struct inode *inode, struct inode *to,
> -					const struct qstr *name)
> -{
> -	struct page *page;
> -
> -	if (file_enc_name(to))
> -		return 0;
> -
> -	page = get_node_page(F2FS_I_SB(inode), inode->i_ino);
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> -
> -	init_dent_inode(name, page);
> -	f2fs_put_page(page, 1);
> -
> -	return 0;
> -}
> -
>  void do_make_empty_dir(struct inode *inode, struct inode *parent,
>  					struct f2fs_dentry_ptr *d)
>  {
> @@ -438,8 +420,11 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>  		set_cold_node(inode, page);
>  	}
>  
> -	if (new_name)
> +	if (new_name) {
>  		init_dent_inode(new_name, page);
> +		if (f2fs_encrypted_inode(dir))
> +			file_set_enc_name(inode);

Please check tmpfile path, we will skip here since new_name will be null, so if
we do not set enc_name flag in add_link, we will lose the flag for tmpfile which
will be linked to dents later.

Other parts look good to me.

Thanks,

> +	}
>  
>  	/*
>  	 * This file should be checkpointed during fsync.
> @@ -599,8 +584,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>  			err = PTR_ERR(page);
>  			goto fail;
>  		}
> -		if (f2fs_encrypted_inode(dir))
> -			file_set_enc_name(inode);
>  	}
>  
>  	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7edb3be..5dbc0c0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2093,8 +2093,6 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
>  			struct page **page);
>  void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>  			struct page *page, struct inode *inode);
> -int update_dent_inode(struct inode *inode, struct inode *to,
> -			const struct qstr *name);
>  void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
>  			const struct qstr *name, f2fs_hash_t name_hash,
>  			unsigned int bit_pos);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4ec764e..8c7923f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -110,20 +110,12 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>  {
>  	struct dentry *dentry;
>  
> -	if (file_enc_name(inode))
> -		return 0;
> -
>  	inode = igrab(inode);
>  	dentry = d_find_any_alias(inode);
>  	iput(inode);
>  	if (!dentry)
>  		return 0;
>  
> -	if (update_dent_inode(inode, inode, &dentry->d_name)) {
> -		dput(dentry);
> -		return 0;
> -	}
> -
>  	*pino = parent_ino(dentry);
>  	dput(dentry);
>  	return 1;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index e32a9e5..41fe27d 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -527,8 +527,6 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
>  			err = PTR_ERR(page);
>  			goto fail;
>  		}
> -		if (f2fs_encrypted_inode(dir))
> -			file_set_enc_name(inode);
>  	}
>  
>  	f2fs_wait_on_page_writeback(ipage, NODE, true);
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 25c073f..8906c9f 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -720,13 +720,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		if (err)
>  			goto put_out_dir;
>  
> -		err = update_dent_inode(old_inode, new_inode,
> -						&new_dentry->d_name);
> -		if (err) {
> -			release_orphan_inode(sbi);
> -			goto put_out_dir;
> -		}
> -
>  		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
>  
>  		new_inode->i_ctime = current_time(new_inode);
> @@ -779,8 +772,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	down_write(&F2FS_I(old_inode)->i_sem);
>  	file_lost_pino(old_inode);
> -	if (new_inode && file_enc_name(new_inode))
> -		file_set_enc_name(old_inode);
>  	up_write(&F2FS_I(old_inode)->i_sem);
>  
>  	old_inode->i_ctime = current_time(old_inode);
> @@ -917,18 +908,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	f2fs_lock_op(sbi);
>  
> -	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
> -	if (err)
> -		goto out_unlock;
> -	if (file_enc_name(new_inode))
> -		file_set_enc_name(old_inode);
> -
> -	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
> -	if (err)
> -		goto out_undo;
> -	if (file_enc_name(old_inode))
> -		file_set_enc_name(new_inode);
> -
>  	/* update ".." directory entry info of old dentry */
>  	if (old_dir_entry)
>  		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
> @@ -972,14 +951,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
>  		f2fs_sync_fs(sbi->sb, 1);
>  	return 0;
> -out_undo:
> -	/*
> -	 * Still we may fail to recover name info of f2fs_inode here
> -	 * Drop it, once its name is set as encrypted
> -	 */
> -	update_dent_inode(old_inode, old_inode, &old_dentry->d_name);
> -out_unlock:
> -	f2fs_unlock_op(sbi);
>  out_new_dir:
>  	if (new_dir_entry) {
>  		f2fs_dentry_kunmap(new_inode, new_dir_page);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
