From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid stale fi->gdirty_list pointer
Date: Mon, 16 Oct 2017 09:56:56 +0800
Message-ID: <7a1ee4f5-78c3-fcb8-c4ef-97c7d49e5a07@huawei.com>
References: <20171013021411.25850-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013021411.25850-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/13 10:14, Jaegeuk Kim wrote:
> When doing fault injection test, f2fs_evict_inode() didn't remove gdirty_list
> which incurs a kernel panic due to wrong pointer access.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Minor thing, how about reverting judgment condition for readability?

if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
	f2fs_inode_synced()
else
	f2fs_bug_on()

Thanks,

> ---
>  fs/f2fs/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index f6db9d533ca4..1ae5396c97d6 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -535,6 +535,8 @@ void f2fs_evict_inode(struct inode *inode)
>  
>  	if (!is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
>  		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
> +	else
> +		f2fs_inode_synced(inode);
>  
>  	/* ino == 0, if f2fs_new_inode() was failed t*/
>  	if (inode->i_ino)
> 
