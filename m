From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: add new wraper function for reading
	inline data
Date: Fri, 19 Feb 2016 15:35:18 +0800
Message-ID: <01ce01d16ae8$32023f20$9606bd60$@samsung.com>
References: <1455850210-31439-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aWfbr-000838-AV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 07:36:15 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aWfbp-0005PL-A8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 07:36:15 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2S034V4AFX2L00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 16:36:05 +0900 (KST)
In-reply-to: <1455850210-31439-1-git-send-email-shawn.lin@rock-chips.com>
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
To: 'Shawn Lin' <shawn.lin@rock-chips.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Shawn,

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Friday, February 19, 2016 10:50 AM
> To: Jaegeuk Kim; Changman Lee
> Cc: Chao Yu; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Shawn Lin
> Subject: [PATCH] f2fs: add new wraper function for reading inline data
> 
> This patch add __read_inline_data which will no check
> PageUptodate and page->index. This can be reused by
> f2fs_convert_inline_page to reduce the redundant code
> copied from read_inline_data.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  fs/f2fs/inline.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index d27347e..39eeff1 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -42,15 +42,11 @@ bool f2fs_may_inline_dentry(struct inode *inode)
>  	return true;
>  }
> 
> -void read_inline_data(struct page *page, struct page *ipage)
> +static inline void __read_inline_data(struct page *page,
> +				      struct page *ipage)
>  {
>  	void *src_addr, *dst_addr;
> 
> -	if (PageUptodate(page))
> -		return;
> -
> -	f2fs_bug_on(F2FS_P_SB(page), page->index);
> -
>  	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
> 
>  	/* Copy the whole inline data block */
> @@ -61,6 +57,15 @@ void read_inline_data(struct page *page, struct page *ipage)
>  	kunmap_atomic(dst_addr);
>  	SetPageUptodate(page);
>  }
> +void read_inline_data(struct page *page, struct page *ipage)
> +{
> +	if (PageUptodate(page))
> +		return;
> +
> +	f2fs_bug_on(F2FS_P_SB(page), page->index);
> +
> +	__read_inline_data(page, ipage);
> +}
> 
>  bool truncate_inline_inode(struct page *ipage, u64 from)
>  {
> @@ -128,15 +133,8 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>  	if (PageUptodate(page))
>  		goto no_update;

Seems we can remove above check and below 'no_update' tag completely
if we use read_inline_data here.

So what about using read_inline_data to clean up codes in
f2fs_convert_inline_page?

Thanks,

> 
> -	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
> +	__read_inline_data(page, dn->inode_page);
> 
> -	/* Copy the whole inline data block */
> -	src_addr = inline_data_addr(dn->inode_page);
> -	dst_addr = kmap_atomic(page);
> -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
> -	flush_dcache_page(page);
> -	kunmap_atomic(dst_addr);
> -	SetPageUptodate(page);
>  no_update:
>  	set_page_dirty(page);
> 
> --
> 2.3.7
> 



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
