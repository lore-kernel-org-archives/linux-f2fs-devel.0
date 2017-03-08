From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: sync the enc name flags with disk
	level filename
Date: Wed, 8 Mar 2017 20:14:27 +0800
Message-ID: <42fdc9ab-96da-c087-e652-71df07be7508@huawei.com>
References: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
	<eda73163-e95f-6c40-05e1-673eba87a530@gmail.com>
	<7b158dd2-9b72-bf75-e0c0-29cb364d24ea@gmail.com>
	<f3794fb1-256b-049a-1146-cdffa5e8c5d5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1claUM-0000KD-Qa
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:14:42 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1claUK-0007m7-J7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:14:42 +0000
In-Reply-To: <f3794fb1-256b-049a-1146-cdffa5e8c5d5@gmail.com>
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

On 2017/3/6 16:11, Kinglong Mee wrote:
> A cross rename between two encrypted files, the disk level filenames
> aren't updated for the file_enc_name(to) checking.
> 
> Also, cross rename between encrypted file and non-encrypted file under
> a non-encrypted file, the enc name flags should update at same time
> as the disk level filename.
> 
> This patch,
> 1. make sure update the disk level filename in update_dent_inode,

Doesn't need to do this since tagging lost_pino is enough, later, fsync will
trigger checkpoint, and then nodes and dents will be persistent with checkpoint,
so after abnormal power off, roll-forward doesn't need to recover dent from
inode::filename.

Thanks,

> 2. a new function exchange_dent_inode for the disk-level filename update,
> 3. only set the enc name flags in init_inode_metadata.
> 
> v2, add the missing function define of exchange_dent_inode in f2fs.h
> 
> Fixes: e7d5545285ed ("f2fs crypto: add filename encryption for roll-forward recovery")
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/dir.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  fs/f2fs/f2fs.h   |  3 ++
>  fs/f2fs/inline.c |  2 --
>  fs/f2fs/namei.c  | 19 ++----------
>  4 files changed, 90 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 295a223..b1bb0b1 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -337,17 +337,93 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
>  int update_dent_inode(struct inode *inode, struct inode *to,
>  					const struct qstr *name)
>  {
> -	struct page *page;
> +	struct page *topage = NULL, *page;
> +	struct f2fs_inode *tori;
> +	struct qstr newname = *name;
> +	int err = 0;
>  
> -	if (file_enc_name(to))
> +	if (file_enc_name(to) && (inode == to))
>  		return 0;
>  
>  	page = get_node_page(F2FS_I_SB(inode), inode->i_ino);
>  	if (IS_ERR(page))
>  		return PTR_ERR(page);
>  
> -	init_dent_inode(name, page);
> +	file_clear_enc_name(inode);
> +	if (file_enc_name(to)) {
> +		topage = get_node_page(F2FS_I_SB(to), to->i_ino);
> +		if (IS_ERR(topage)) {
> +			f2fs_put_page(page, 1);
> +			return PTR_ERR(topage);
> +		}
> +
> +		tori = F2FS_INODE(topage);
> +		newname.name = tori->i_name;
> +		newname.len = tori->i_namelen;
> +
> +		file_set_enc_name(inode);
> +	}
> +
> +	init_dent_inode(&newname, page);
> +
>  	f2fs_put_page(page, 1);
> +	if (file_enc_name(to))
> +		f2fs_put_page(topage, 1);
> +
> +	return err;
> +}
> +
> +int exchange_dent_inode(struct inode *src, struct inode *dst,
> +			const struct qstr *srcname, const struct qstr *dstname)
> +{
> +	struct page *srcpage = NULL, *dstpage = NULL;
> +	char tmp_srcname[F2FS_NAME_LEN], tmp_dstname[F2FS_NAME_LEN];
> +	struct qstr new_srcname = *srcname;
> +	struct qstr new_dstname = *dstname;
> +
> +	if (src == dst)
> +		return 0;
> +
> +	srcpage = get_node_page(F2FS_I_SB(src), src->i_ino);
> +	if (IS_ERR(srcpage))
> +		return PTR_ERR(srcpage);
> +
> +	dstpage = get_node_page(F2FS_I_SB(dst), dst->i_ino);
> +	if (IS_ERR(dstpage)) {
> +		f2fs_put_page(srcpage, 1);
> +		return PTR_ERR(dstpage);
> +	}
> +
> +	f2fs_wait_on_page_writeback(srcpage, NODE, true);
> +	f2fs_wait_on_page_writeback(dstpage, NODE, true);
> +
> +	file_clear_enc_name(dst);
> +	if (file_enc_name(src)) {
> +		struct f2fs_inode *srcri = F2FS_INODE(srcpage);
> +
> +		memcpy(tmp_srcname, srcri->i_name, srcri->i_namelen);
> +		new_srcname.name = tmp_srcname;
> +		new_srcname.len = srcri->i_namelen;
> +
> +		file_set_enc_name(dst);
> +	}
> +
> +	file_clear_enc_name(src);
> +	if (file_enc_name(dst)) {
> +		struct f2fs_inode *dstri = F2FS_INODE(dstpage);
> +
> +		memcpy(tmp_dstname, dstri->i_name, dstri->i_namelen);
> +		new_dstname.name = tmp_dstname;
> +		new_dstname.len = dstri->i_namelen;
> +
> +		file_set_enc_name(src);
> +	}
> +
> +	init_dent_inode(&new_dstname, srcpage);
> +	init_dent_inode(&new_srcname, dstpage);
> +
> +	f2fs_put_page(srcpage, 1);
> +	f2fs_put_page(dstpage, 1);
>  
>  	return 0;
>  }
> @@ -435,9 +511,14 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>  		set_cold_node(inode, page);
>  	}
>  
> -	if (new_name)
> +	if (new_name) {
>  		init_dent_inode(new_name, page);
>  
> +		file_clear_enc_name(inode);
> +		if (f2fs_encrypted_inode(dir))
> +			file_set_enc_name(inode);
> +	}
> +
>  	/*
>  	 * This file should be checkpointed during fsync.
>  	 * We lost i_pino from now on.
> @@ -596,8 +677,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>  			err = PTR_ERR(page);
>  			goto fail;
>  		}
> -		if (f2fs_encrypted_inode(dir))
> -			file_set_enc_name(inode);
>  	}
>  
>  	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7e29249..ce24fe9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -440,6 +440,7 @@ struct f2fs_map_blocks {
>  #define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
>  #define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
>  #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
> +#define file_clear_enc_name(inode) clear_file(inode, FADVISE_ENC_NAME_BIT)
>  #define file_keep_isize(inode)	is_file(inode, FADVISE_KEEP_SIZE_BIT)
>  #define file_set_keep_isize(inode) set_file(inode, FADVISE_KEEP_SIZE_BIT)
>  
> @@ -2101,6 +2102,8 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>  			struct page *page, struct inode *inode);
>  int update_dent_inode(struct inode *inode, struct inode *to,
>  			const struct qstr *name);
> +int exchange_dent_inode(struct inode *src, struct inode *dst,
> +			const struct qstr *srcname, const struct qstr *dstname);
>  void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
>  			const struct qstr *name, f2fs_hash_t name_hash,
>  			unsigned int bit_pos);
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
> index 3231a0a..57050ff 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -779,8 +779,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	down_write(&F2FS_I(old_inode)->i_sem);
>  	file_lost_pino(old_inode);
> -	if (new_inode && file_enc_name(new_inode))
> -		file_set_enc_name(old_inode);
>  	up_write(&F2FS_I(old_inode)->i_sem);
>  
>  	old_inode->i_ctime = current_time(old_inode);
> @@ -917,17 +915,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	f2fs_lock_op(sbi);
>  
> -	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
> +	err = exchange_dent_inode(old_inode, new_inode,
> +				  &old_dentry->d_name, &new_dentry->d_name);
>  	if (err)
>  		goto out_unlock;
> -	if (file_enc_name(new_inode))
> -		file_set_enc_name(old_inode);
> -
> -	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
> -	if (err)
> -		goto out_undo;
> -	if (file_enc_name(old_inode))
> -		file_set_enc_name(new_inode);
>  
>  	/* update ".." directory entry info of old dentry */
>  	if (old_dir_entry)
> @@ -972,12 +963,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
>  		f2fs_sync_fs(sbi->sb, 1);
>  	return 0;
> -out_undo:
> -	/*
> -	 * Still we may fail to recover name info of f2fs_inode here
> -	 * Drop it, once its name is set as encrypted
> -	 */
> -	update_dent_inode(old_inode, old_inode, &old_dentry->d_name);
>  out_unlock:
>  	f2fs_unlock_op(sbi);
>  out_new_dir:
> 


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
