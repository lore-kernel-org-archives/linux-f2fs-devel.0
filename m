From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix out-of-free problem caused by atomic write
Date: Thu, 26 Oct 2017 16:30:19 +0200
Message-ID: <20171026143019.GB67431@jaegeuk-macbookpro.roam.corp.google.com>
References: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/26, Yunlong Song wrote:
> f2fs_balance_fs only actives once in the commit_inmem_pages, but there
> are more than one page to commit, so all the other pages will miss the
> check. This will lead to out-of-free problem when commit a very large
> file. To fix it, we should do f2fs_balance_fs for each inmem page.

NAK, this breaks atomicity.

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 46dfbca..fa2c36b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -384,6 +384,9 @@ static int __commit_inmem_pages(struct inode *inode,
>  				unlock_page(page);
>  				break;
>  			}
> +			f2fs_unlock_op(sbi);
> +			f2fs_balance_fs(sbi, true);
> +			f2fs_lock_op(sbi);
>  			/* record old blkaddr for revoking */
>  			cur->old_addr = fio.old_blkaddr;
>  			last_idx = page->index;
> @@ -409,7 +412,6 @@ int commit_inmem_pages(struct inode *inode)
>  	int err;
>  
>  	INIT_LIST_HEAD(&revoke_list);
> -	f2fs_balance_fs(sbi, true);
>  	f2fs_lock_op(sbi);
>  
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> -- 
> 1.8.5.2
