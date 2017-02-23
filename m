From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: avoid reading NAT page by
	get_node_info
Date: Thu, 23 Feb 2017 19:47:29 +0800
Message-ID: <c911629f-7c6c-00d3-3d94-8c6a9a5fb0ca@huawei.com>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
	<20170214020644.18189-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgrs9-0003Cc-DM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:47:45 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgrs7-00084M-Vr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:47:45 +0000
In-Reply-To: <20170214020644.18189-3-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/14 10:06, Jaegeuk Kim wrote:
> We've not seen this buggy case for a long time, so it's time to avoid this
> unnecessary get_node_info() call which reading NAT page to cache nat entry.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e001d084667f..b63bdb85ad66 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1033,7 +1033,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
>  				unsigned int ofs, struct page *ipage)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	struct node_info old_ni, new_ni;
> +	struct node_info new_ni;
>  	struct page *page;
>  	int err;
>  
> @@ -1049,12 +1049,11 @@ struct page *new_node_page(struct dnode_of_data *dn,
>  		goto fail;
>  	}
>  
> -	get_node_info(sbi, dn->nid, &old_ni);
> -
> -	/* Reinitialize old_ni with new node page */
> -	f2fs_bug_on(sbi, old_ni.blk_addr != NULL_ADDR);

What about keeping get_node_info covered with CONFIG_F2FS_CHECK_FS for
consistence as we just introduce two new free nid caches, I think it will be
helpful for detecting bugs of these new codes.

Thanks,

> -	new_ni = old_ni;
> +	new_ni.nid = dn->nid;
>  	new_ni.ino = dn->inode->i_ino;
> +	new_ni.blk_addr = NULL_ADDR;
> +	new_ni.flag = 0;
> +	new_ni.version = 0;
>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>  
>  	f2fs_wait_on_page_writeback(page, NODE, true);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
