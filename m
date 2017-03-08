From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't need to invalidate wrong node
 page
Date: Wed, 8 Mar 2017 20:17:00 +0800
Message-ID: <8fa2118d-1da0-29f6-a755-fd661333d05d@huawei.com>
References: <20170306215102.3807-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170306215102.3807-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/3/7 5:51, Jaegeuk Kim wrote:
> If f2fs_new_inode() is failed, the bad inode will invalidate 0'th node page
> during f2fs_evict_inode(), which doesn't need to do.

Hmm...should not allow other using of inode->i_ino in following codes of
f2fs_evict_inode, right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 24bb8213d974..ef8610bf950f 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -411,7 +411,10 @@ void f2fs_evict_inode(struct inode *inode)
>  	stat_dec_inline_dir(inode);
>  	stat_dec_inline_inode(inode);
>  
> -	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
> +	/* ino == 0, if f2fs_new_inode() was failed t*/
> +	if (inode->i_ino)
> +		invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
> +							inode->i_ino);
>  	if (xnid)
>  		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
>  	if (inode->i_nlink) {
> 
