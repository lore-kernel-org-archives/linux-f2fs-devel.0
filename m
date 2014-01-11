From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: move grabing orphan pages out of
 protection region
Date: Sat, 11 Jan 2014 09:27:55 +0800
Message-ID: <000001cf0e6c$77982430$66c86c90$@samsung.com>
References: <52CFC6BE.7020609@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1W1nNl-0001dM-Je
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jan 2014 01:29:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W1nNg-0001Zp-Im
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jan 2014 01:29:01 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MZ700IAUQS07520@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jan 2014 10:28:48 +0900 (KST)
In-reply-to: <52CFC6BE.7020609@cn.fujitsu.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'Kim' <jaegeuk.kim@samsung.com>
Cc: 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

Hi Gu,

> -----Original Message-----
> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> Sent: Friday, January 10, 2014 6:09 PM
> To: Kim
> Cc: fsdevel; linux-kernel; f2fs
> Subject: [f2fs-dev] [PATCH 1/3] f2fs: move grabing orphan pages out of protection region
> 
> Move grabing orphan block page out of protection region, and grab all
> the orphan block pages ahead.
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0d78bbe..af92c74 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -303,22 +303,25 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t
> start_blk)
>  {
>  	struct list_head *head;
>  	struct f2fs_orphan_block *orphan_blk = NULL;
> -	struct page *page = NULL;
>  	unsigned int nentries = 0;
> -	unsigned short index = 1;
> -	unsigned short orphan_blocks;
> +	unsigned short index;
> +	unsigned short orphan_blocks = (unsigned short)((sbi->n_orphans +
> +		(F2FS_ORPHANS_PER_BLOCK - 1)) / F2FS_ORPHANS_PER_BLOCK);
> +	struct page *page = NULL;
> +	struct page *pages[orphan_blocks];
>  	struct orphan_inode_entry *orphan = NULL;
> 
> -	orphan_blocks = (unsigned short)((sbi->n_orphans +
> -		(F2FS_ORPHANS_PER_BLOCK - 1)) / F2FS_ORPHANS_PER_BLOCK);
> +	for (index = 0; index < orphan_blocks; index++)
> +		pages[index] = grab_meta_page(sbi, start_blk + index);
> 
> +	index = 1;
>  	mutex_lock(&sbi->orphan_inode_mutex);
>  	head = &sbi->orphan_inode_list;
> 
>  	/* loop for each orphan inode entry and write them in Jornal block */
>  	list_for_each_entry(orphan, head, list) {
>  		if (!page) {
> -			page = grab_meta_page(sbi, start_blk);
> +			page = pages[index - 1];
>  			orphan_blk =
>  				(struct f2fs_orphan_block *)page_address(page);
>  			memset(orphan_blk, 0, sizeof(*orphan_blk));

It seems that we could remove the following code in write_orphan_inodes.
			start_blk++;

> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
