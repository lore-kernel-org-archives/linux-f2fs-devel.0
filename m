From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: modify the readahead method
	in	ra_node_page()
Date: Tue, 01 Mar 2016 17:53:08 +0800
Message-ID: <00d301d173a0$40e228a0$c2a679e0$@samsung.com>
References: <001f01d172ba$b7dde070$2799a150$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aah0l-0001gj-Gz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 09:54:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aah0i-0006nF-94
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 09:54:35 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3C021ZFU5L2TD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 18:53:49 +0900 (KST)
In-reply-to: <001f01d172ba$b7dde070$2799a150$@samsung.com>
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
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Monday, February 29, 2016 2:30 PM
> To: 'Jaegeuk Kim'
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: modify the readahead method in ra_node_page()
> 
> ra_node_page() is used to read ahead one node page. Comparing to regular
> read, it's faster because it doesn't wait for IO completion.
> But if it is called twice for reading the same block, and the IO request
> from the first call hasn't been completed before the second call, the second
> call will have to wait until the read is over.
> 
> Here use the code in __do_page_cache_readahead() to solve this problem.
> It does nothing when someone else already puts the page in mapping. The
> status of page should be assured by whoever puts it there.
> This implement also prevents alteration of page reference count.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/node.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 511c0e7..6d8f107 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1080,12 +1080,11 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
>                 return;
>         f2fs_bug_on(sbi, check_nid_range(sbi, nid));
> 
> -       apage = find_get_page(NODE_MAPPING(sbi), nid);
> -       if (apage && PageUptodate(apage)) {
> -               f2fs_put_page(apage, 0);
> +       rcu_read_lock();
> +       apage = radix_tree_lookup(&NODE_MAPPING(sbi)->page_tree, nid);
> +       rcu_read_unlock();
> +       if (apage)
>                 return;
> -       }
> -       f2fs_put_page(apage, 0);

How about use trylock_page to avoid contention here?

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 26eb441..9cdb6f2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1085,15 +1085,14 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
        f2fs_bug_on(sbi, check_nid_range(sbi, nid));

        apage = find_get_page(NODE_MAPPING(sbi), nid);
-       if (apage && PageUptodate(apage)) {
+       if (!apage) {
+               apage = grab_cache_page(NODE_MAPPING(sbi), nid);
+               if (!apage)
+                       return;
+       } else if (PageUptodate(apage) || !trylock_page(apage)) {
                f2fs_put_page(apage, 0);
                return;
        }
-       f2fs_put_page(apage, 0);
-
-       apage = grab_cache_page(NODE_MAPPING(sbi), nid);
-       if (!apage)
-               return;

        err = read_node_page(apage, READA);
        f2fs_put_page(apage, err ? 1 : 0);

Thanks,

> 
>         apage = grab_cache_page(NODE_MAPPING(sbi), nid);
>         if (!apage)
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
