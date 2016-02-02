From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: delete unnecessary wait for page
 writeback
Date: Tue, 2 Feb 2016 11:58:02 -0800
Message-ID: <20160202195802.GA90590@jaegeuk.gateway>
References: <1454418327-3537-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aQh5b-0000eo-6h
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 19:58:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aQh5X-0001sg-JQ for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 19:58:15 +0000
Content-Disposition: inline
In-Reply-To: <1454418327-3537-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On Tue, Feb 02, 2016 at 09:05:27PM +0800, Yunlei He wrote:
> no need to wait inline file page writeback for no one
> use it, so this patch delete unnecessary wait.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/inline.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index fc4d298..ec44640 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -124,8 +124,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>  	if (err)
>  		return err;
>  
> -	f2fs_wait_on_page_writeback(page, DATA, true);
> -

I agreed.
But, I worried about any corner case.
How about adding f2fs_bug_on() here?

Thanks,

>  	if (PageUptodate(page))
>  		goto no_update;
>  
> -- 
> 1.9.1

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
