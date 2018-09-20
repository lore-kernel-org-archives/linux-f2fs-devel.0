From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: report ENOENT correct in
 f2fs_rename
Date: Thu, 20 Sep 2018 14:14:25 +0800
Message-ID: <740d4c02-0fdd-d9bb-2079-2cb0947bf581@huawei.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/20 6:50, Jaegeuk Kim wrote:
> This fixes wrong error report in f2fs_rename.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Change log from v1:
>  - cover rename2 case
> 
>  fs/f2fs/namei.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 98d3ab7c3ce6..48f919469151 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	struct f2fs_dir_entry *old_entry;
>  	struct f2fs_dir_entry *new_entry;
>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
> -	int err = -ENOENT;
> +	int err;
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return -EIO;
> @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (err)
>  		goto out;
>  
> +	err = -ENOENT;

It should be assigned after dquot_initialize(), otherwise, err's value can
still be reset to 0 due to dquot_initialize().

>  	if (new_inode) {
>  		err = dquot_initialize(new_inode);
>  		if (err)
> @@ -1049,6 +1050,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (err)
>  		goto out;
>  
> +	err = -ENOENT;

We can remove err initialization like f2fs_rename()

int err;

Thanks,

>  	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
>  	if (!old_entry) {
>  		if (IS_ERR(old_page))
> 
