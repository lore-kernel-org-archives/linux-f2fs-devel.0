From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 3/3] f2fs: introduce f2fs_cache_node_page()
 to add page into node_inode cache
Date: Thu, 05 Dec 2013 10:10:59 +0800
Message-ID: <001901cef15f$6fafea70$4f0fbf50$@samsung.com>
References: <001701cef15d$169a5a30$43cf0e90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VoOQi-0007VQ-Gy
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 02:12:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VoOQg-00076P-6e
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 02:12:40 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MXB00IOSA4UWY60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 11:12:30 +0900 (KST)
In-reply-to: <001701cef15d$169a5a30$43cf0e90$@samsung.com>
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
To: '???' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Thursday, December 05, 2013 9:55 AM
> To: ???
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 3/3] f2fs: introduce f2fs_cache_node_page() to add page into node_inode cache
> 
> This patch introduces f2fs_cache_node_page(), in this function, page which is
> readed ahead will be copy to node_inode's mapping cache.
> It will avoid rereading these node pages.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>

Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

I miss that, my mistake.

> ---
>  fs/f2fs/node.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 099f06f..5e2588f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1600,6 +1600,34 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
>  	return 0;
>  }
> 
> +/*
> + * f2fs_cache_node_page() copy updated page data to node_inode cache page.
> + */
> +void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page *page,
> +						nid_t nid)
> +{
> +	struct address_space *mapping = sbi->node_inode->i_mapping;
> +	struct page *npage;
> +
> +	npage = find_get_page(mapping, nid);
> +	if (npage && PageUptodate(npage)) {
> +		f2fs_put_page(npage, 0);
> +		return;
> +	}
> +	f2fs_put_page(npage, 0);
> +
> +	npage = grab_cache_page(mapping, nid);
> +	if (!npage)
> +		return;
> +
> +	memcpy(page_address(npage), page_address(page), PAGE_CACHE_SIZE);
> +
> +	SetPageUptodate(npage);
> +	f2fs_put_page(npage, 1);
> +
> +	return;
> +}
> +
>  int restore_node_summary(struct f2fs_sb_info *sbi,
>  			unsigned int segno, struct f2fs_summary_block *sum)
>  {
> @@ -1633,6 +1661,8 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
>  				sum_entry->version = 0;
>  				sum_entry->ofs_in_node = 0;
>  				sum_entry++;
> +				f2fs_cache_node_page(sbi, page,
> +					le32_to_cpu(rn->footer.nid));
>  			} else {
>  				err = -EIO;
>  			}
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> Sponsored by Intel(R) XDK
> Develop, test and display web and hybrid apps with a single code base.
> Download it for free now!
> http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
