From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix multiple f2fs_add_link() calls
 having same name
Date: Wed, 15 Feb 2017 09:18:27 +0800
Message-ID: <4fb2c86e-a50c-512f-2fa7-964540101138@huawei.com>
References: <20170214180345.2074-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170214180345.2074-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/15 2:03, Jaegeuk Kim wrote:
> VFS uses f2fs_lookup() to decide f2fs_add_link() call during file creation.
> But, if there is a race condition, f2fs_add_link() can be called multiple
> times, resulting in multiple dentries with a same name. This patches fixes
> it by adding __f2fs_find_entry() in f2fs_add_link() path.

As during ->lookup, i_mutex will be held all the time, so there is no race
condition in between different file creators?

Thanks,

> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 827c5daef4fc..bc7c48839bec 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -643,14 +643,24 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
>  				struct inode *inode, nid_t ino, umode_t mode)
>  {
>  	struct fscrypt_name fname;
> +	struct page *page;
> +	struct f2fs_dir_entry *de;
>  	int err;
>  
>  	err = fscrypt_setup_filename(dir, name, 0, &fname);
>  	if (err)
>  		return err;
>  
> -	err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
> -
> +	de = __f2fs_find_entry(dir, &fname, &page);
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
> 
