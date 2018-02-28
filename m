From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: in-memory inode checksum when
 checking consistency
Date: Wed, 28 Feb 2018 17:58:36 +0800
Message-ID: <bdf3d274-5819-25eb-9de7-fc8592962a65@huawei.com>
References: <20180226192843.26680-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eqyS8-001Qbd-PY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 09:55:12 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eqyS6-008tyl-Fi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 09:55:12 +0000
In-Reply-To: <20180226192843.26680-1-guoweichao@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/27 3:28, Weichao Guo wrote:
> Enable in-memory inode checksum to protect metadata blocks
> from in-memory scribbles only when checking consistency with
> no performance requirements.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/inode.c | 7 +++++++
>  fs/f2fs/node.c  | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 205add3d0f3a..b04129d23d21 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -159,8 +159,12 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
>  	struct f2fs_inode *ri;
>  	__u32 provided, calculated;
>  
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	if (!f2fs_enable_inode_chksum(sbi, page))
> +#else
>  	if (!f2fs_enable_inode_chksum(sbi, page) ||
>  			PageDirty(page) || PageWriteback(page))
> +#endif
>  		return true;
>  
>  	ri = &F2FS_NODE(page)->i;
> @@ -464,6 +468,9 @@ void update_inode_page(struct inode *inode)
>  		return;
>  	}
>  	update_inode(inode, node_page);
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	f2fs_inode_chksum_set(sbi, node_page);
> +#endif

> This gives a panic easily by fsstress. Could you please check it again?

Sorry, I missed some cases, it looks that we need to cover updating place of all
fields like i_addr, inline_xxx, footer with f2fs_inode_chksum_set.

Thanks,

>  	f2fs_put_page(node_page, 1);
>  }
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 177c438e4a56..2adeb74ae055 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1113,8 +1113,10 @@ static int read_node_page(struct page *page, int op_flags)
>  		.encrypted_page = NULL,
>  	};
>  
> -	if (PageUptodate(page))
> +	if (PageUptodate(page)) {
> +		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
>  		return LOCKED_PAGE;
> +	}
>  
>  	get_node_info(sbi, page->index, &ni);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
