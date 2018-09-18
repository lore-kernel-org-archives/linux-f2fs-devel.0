From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Date: Tue, 18 Sep 2018 20:47:07 +0800
Message-ID: <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918021805.85032-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/18 10:18, Jaegeuk Kim wrote:
> This fixes wrong error report in f2fs_rename.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 98d3ab7c3ce6..d653be777529 100644
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

I didn't get what's the difference after moving initialization of 'err' here...

Thanks,

>  	if (new_inode) {
>  		err = dquot_initialize(new_inode);
>  		if (err)
> 
