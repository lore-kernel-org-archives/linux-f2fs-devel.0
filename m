From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: don't check inode's checksum if it
 was dirtied or writebacked
Date: Mon, 4 Sep 2017 09:33:25 +0800
Message-ID: <df6b44f0-ee25-f264-b105-e942586e5b39@huawei.com>
References: <20170901172511.7045-1-jaegeuk@kernel.org>
 <20170901172511.7045-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901172511.7045-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/2 1:25, Jaegeuk Kim wrote:
> If another thread already made the page dirtied or writebacked, we must avoid
> to verify checksum. If we got an error, we need to remove its uptodate as well.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/inode.c | 3 ++-
>  fs/f2fs/node.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index b4c401d456e7..c33b05aec1a1 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -153,7 +153,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
>  	struct f2fs_inode *ri;
>  	__u32 provided, calculated;
>  
> -	if (!f2fs_enable_inode_chksum(sbi, page))
> +	if (!f2fs_enable_inode_chksum(sbi, page) ||
> +			PageDirty(page) || PageWriteback(page))
>  		return true;
>  
>  	ri = &F2FS_NODE(page)->i;
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 388a00262a5f..fca87835a1da 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1187,9 +1187,9 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>  			nid, nid_of_node(page), ino_of_node(page),
>  			ofs_of_node(page), cpver_of_node(page),
>  			next_blkaddr_of_node(page));
> -		ClearPageUptodate(page);
>  		err = -EINVAL;
>  out_err:
> +		ClearPageUptodate(page);
>  		f2fs_put_page(page, 1);
>  		return ERR_PTR(err);
>  	}
> 
