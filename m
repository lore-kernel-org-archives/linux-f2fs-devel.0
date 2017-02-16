From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix multiple f2fs_add_link() calls
 having same name
Date: Thu, 16 Feb 2017 11:37:14 +0800
Message-ID: <05e24002-260a-a06e-10cb-cab6839d0330@huawei.com>
References: <20170214180345.2074-1-jaegeuk@kernel.org>
 <4fb2c86e-a50c-512f-2fa7-964540101138@huawei.com>
 <20170215013947.GA5332@jaegeuk.local> <20170216011601.GA15475@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170216011601.GA15475@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/16 9:16, Jaegeuk Kim wrote:
> On 02/14, Jaegeuk Kim wrote:
>> On 02/15, Chao Yu wrote:
>>> On 2017/2/15 2:03, Jaegeuk Kim wrote:
>>>> VFS uses f2fs_lookup() to decide f2fs_add_link() call during file creation.
>>>> But, if there is a race condition, f2fs_add_link() can be called multiple
>>>> times, resulting in multiple dentries with a same name. This patches fixes
>>>> it by adding __f2fs_find_entry() in f2fs_add_link() path.
>>>
>>> As during ->lookup, i_mutex will be held all the time, so there is no race
>>> condition in between different file creators?
>>
>> Hehe, yup.
>> I dropped this patch.
> 
> It turns out sdcardfs has a race condition between lookup and create, and it
> calls vfs_create() twice. Workaround by f2fs would be needed for whole AOSP as
> well. And I added to check current to avoid performance regression.
> 
> Thanks,
> 
>>From 2f433dbfa491550e666a3d08f5a59ac5bed42b0f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 14 Feb 2017 09:54:37 -0800
> Subject: [PATCH] f2fs: fix multiple f2fs_add_link() calls having same name
> 
> It turns out a stakable filesystem like sdcardfs in AOSP can trigger multiple
> vfs_create() to lower filesystem. In that case, f2fs will add multiple dentries
> having same name which breaks filesystem consistency.
> 
> Until upper layer fixes, let's work around by f2fs, which shows actually not
> much performance regression.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c  | 26 ++++++++++++++++++++++++--
>  fs/f2fs/f2fs.h |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 827c5daef4fc..4f5b3bb514c6 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -207,9 +207,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  		f2fs_put_page(dentry_page, 0);
>  	}
>  
> +	/* This is to increase the speed of f2fs_create */
>  	if (!de && room && F2FS_I(dir)->chash != namehash) {
>  		F2FS_I(dir)->chash = namehash;
>  		F2FS_I(dir)->clevel = level;
> +		F2FS_I(dir)->task = current;
>  	}

Hash collision can happen on different file names, here, assignment of .task
should be more accurately to prevent racing between lookup and creat, so how about:

if (!de && room) {
	.task = current;
	if (chash != namehash) {
		.chash = namehash;
		.clevel = level;
	}
}

Thanks,

>  
>  	return de;
> @@ -643,14 +645,34 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
>  				struct inode *inode, nid_t ino, umode_t mode)
>  {
>  	struct fscrypt_name fname;
> +	struct page *page = NULL;
> +	struct f2fs_dir_entry *de = NULL;
>  	int err;
>  
>  	err = fscrypt_setup_filename(dir, name, 0, &fname);
>  	if (err)
>  		return err;
>  
> -	err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
> -
> +	/*
> +	 * An immature stakable filesystem shows a race condition between lookup
> +	 * and create. If we have same task when doing lookup and create, it's
> +	 * definitely fine as expected by VFS normally. Otherwise, let's just
> +	 * verify on-disk dentry one more time, which guarantees filesystem
> +	 * consistency more.
> +	 */
> +	if (current != F2FS_I(dir)->task) {
> +		de = __f2fs_find_entry(dir, &fname, &page);
> +		F2FS_I(dir)->task = NULL;
> +	}
> +	if (de) {
> +		f2fs_dentry_kunmap(dir, page);
> +		f2fs_put_page(page, 0);
> +		err = -EEXIST;
> +	} else if (!IS_ERR(page)) {
> +		err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
> +	} else {
> +		err = PTR_ERR(page);
> +	}
>  	fscrypt_free_filename(&fname);
>  	return err;
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d263dade5e4c..cc22dc458896 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -454,6 +454,7 @@ struct f2fs_inode_info {
>  	atomic_t dirty_pages;		/* # of dirty pages */
>  	f2fs_hash_t chash;		/* hash value of given file name */
>  	unsigned int clevel;		/* maximum level of given file name */
> +	struct task_struct *task;	/* lookup and create consistency */
>  	nid_t i_xattr_nid;		/* node id that contains xattrs */
>  	loff_t	last_disk_size;		/* lastly written file size */
>  
> 
