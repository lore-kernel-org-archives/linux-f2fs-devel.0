From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: fix omitting to update inode page
Date: Tue, 27 Aug 2013 12:50:27 +0800
Message-ID: <521C3013.1070003@cn.fujitsu.com>
References: <1377520082-20526-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377520082-20526-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/26/2013 08:28 PM, Jaegeuk Kim wrote:

> The f2fs_set_link updates its parent inode number, so we should sync this to
> the inode block.
> Otherwise, the data can be lost after sudden-power-off.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/namei.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 4e47518..9e90d31 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -447,6 +447,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		else
>  			release_orphan_inode(sbi);
>  
> +		update_inode_page(old_inode):

':' --> ';'

>  		update_inode_page(new_inode);
>  	} else {
>  		err = f2fs_add_link(new_dentry, old_inode);
