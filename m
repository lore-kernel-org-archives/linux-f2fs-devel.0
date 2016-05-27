From: He YunLei <heyunlei@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: propagate error given by
 f2fs_find_entry
Date: Fri, 27 May 2016 12:48:48 +0800
Message-ID: <5747D1B0.2000006@huawei.com>
References: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/5/27 8:25, Jaegeuk Kim wrote:
> If we get ENOMEM or EIO in f2fs_find_entry, we should stop right away.
> Otherwise, for example, we can get duplicate directory entry by ->chash and
> ->clevel.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/dir.c    | 23 ++++++++++++++++-------
>   fs/f2fs/inline.c |  4 +++-
>   fs/f2fs/namei.c  |  5 +++++
>   3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 24d1308..ae37543 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -185,8 +185,13 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>   		/* no need to allocate new dentry pages to all the indices */
>   		dentry_page = find_data_page(dir, bidx);
>   		if (IS_ERR(dentry_page)) {
> -			room = true;
> -			continue;
> +			if (PTR_ERR(dentry_page) == -ENOENT) {
> +				room = true;
> +				continue;
> +			} else {
> +				*res_page = dentry_page;
> +				break;
> +			}
>   		}
>
>   		de = find_in_block(dentry_page, fname, namehash, &max_slots,
> @@ -223,19 +228,22 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
>   	struct fscrypt_name fname;
>   	int err;
>
> -	*res_page = NULL;
> -
>   	err = fscrypt_setup_filename(dir, child, 1, &fname);
> -	if (err)
> +	if (err) {
> +		*res_page = ERR_PTR(-ENOMEM);
>   		return NULL;
> +	}
>
>   	if (f2fs_has_inline_dentry(dir)) {
> +		*res_page = NULL;
>   		de = find_in_inline_dir(dir, &fname, res_page);
>   		goto out;
>   	}
>
> -	if (npages == 0)
> +	if (npages == 0) {
> +		*res_page = NULL;
>   		goto out;
> +	}
>
>   	max_depth = F2FS_I(dir)->i_current_depth;
>   	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
> @@ -247,8 +255,9 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
>   	}
>
>   	for (level = 0; level < max_depth; level++) {
> +		*res_page = NULL;
>   		de = find_in_level(dir, level, &fname, res_page);
> -		if (de)
> +		if (de || IS_ERR(*res_page))
>   			break;
>   	}

Hi, kim
	Here, we return NULL for the error of find_data_page, it means
the file looked up is not exist to vfs, but may be the file has already exist
behind the block read error. So maybe we 'd better reported the error to vfs.

Thanks.

>   out:
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 77c9c24..1eb3043 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -286,8 +286,10 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
>   	f2fs_hash_t namehash;
>
>   	ipage = get_node_page(sbi, dir->i_ino);
> -	if (IS_ERR(ipage))
> +	if (IS_ERR(ipage)) {
> +		*res_page = ipage;
>   		return NULL;
> +	}
>
>   	namehash = f2fs_dentry_hash(&name);
>
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 496f4e3..3f6119e 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -232,6 +232,9 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
>   	if (de) {
>   		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
> +	} else if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
> +		goto out;
>   	} else {
>   		err = __f2fs_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
>   		if (err)
> @@ -242,6 +245,8 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
>   	if (de) {
>   		f2fs_dentry_kunmap(dir, page);
>   		f2fs_put_page(page, 0);
> +	} else if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
>   	} else {
>   		err = __f2fs_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
>   	}
>
