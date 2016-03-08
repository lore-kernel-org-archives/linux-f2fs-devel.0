From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: modify the readahead method in
 ra_node_page()
Date: Mon, 7 Mar 2016 18:29:33 -0800
Message-ID: <20160308022933.GC44902@jaegeuk.gateway>
References: <001f01d172ba$b7dde070$2799a150$@samsung.com>
	<00d301d173a0$40e228a0$c2a679e0$@samsung.com>
	<000c01d17431$53dd5a10$fb980e30$@samsung.com>
	<56D83CD2.2060107@kernel.org>
	<001b01d17824$4c22f450$e468dcf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ad7P5-000420-7w
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Mar 2016 02:29:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ad7P3-0007JB-TH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Mar 2016 02:29:43 +0000
Content-Disposition: inline
In-Reply-To: <001b01d17824$4c22f450$e468dcf0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>
Cc: 'Chao Yu' <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

> > >>>  fs/f2fs/node.c |    9 ++++-----
> > >>>  1 file changed, 4 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 511c0e7..6d8f107
> > >>> 100644
> > >>> --- a/fs/f2fs/node.c
> > >>> +++ b/fs/f2fs/node.c
> > >>> @@ -1080,12 +1080,11 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
> > >>>                 return;
> > >>>         f2fs_bug_on(sbi, check_nid_range(sbi, nid));
> > >>>
> > >>> -       apage = find_get_page(NODE_MAPPING(sbi), nid);
> > >>> -       if (apage && PageUptodate(apage)) {
> > >>> -               f2fs_put_page(apage, 0);
> > >>> +       rcu_read_lock();
> > >>> +       apage = radix_tree_lookup(&NODE_MAPPING(sbi)->page_tree, nid);
> > >>> +       rcu_read_unlock();
> > >>> +       if (apage)
> > >>>                 return;
> > >>> -       }
> > >>> -       f2fs_put_page(apage, 0);
> > >>
> > >> How about use trylock_page to avoid contention here?
> > >
> > > I thought about that, but after I saw the __do_page_cache_readahead(),
> > > I think that's better.
> > > they works almost the same, but it reduces the performance by altering
> > > reference count and trying to lock the page.
> > >
> > > The only difference between this two methods is how to deal a page
> > 
> > Concurrent threads can both pass the rcu lookuping at the same time, and then they will be serialized by grab_cache_page invoking,
> > which altering second thread to read node page synchronously instead of reading asynchronously. IMO, we can afford to reference
> > and trylock which takes litte overhead of CPU in order to avoid potential synchronously readahead for node page.
> 
> My point is that this patch can avoid potential synchronously readahead for node page without taking such overhead.
> The difference is very small and the method has already been used in vfs codes.

Let me go with Fan's patch at this moment.
Then, it'd good to investigate how contention occurs here later.

Thanks,

> 
> > 
> > Thanks,
> > 
> > > which is left unlock and not uptodate in mapping. I think only cause
> > > of such page seems to be IO error, and it's too rare to call for optimization.
> > >
> > >>
> > >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 26eb441..9cdb6f2
> > >> 100644
> > >> --- a/fs/f2fs/node.c
> > >> +++ b/fs/f2fs/node.c
> > >> @@ -1085,15 +1085,14 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
> > >>         f2fs_bug_on(sbi, check_nid_range(sbi, nid));
> > >>
> > >>         apage = find_get_page(NODE_MAPPING(sbi), nid);
> > >> -       if (apage && PageUptodate(apage)) {
> > >> +       if (!apage) {
> > >> +               apage = grab_cache_page(NODE_MAPPING(sbi), nid);
> > >> +               if (!apage)
> > >> +                       return;
> > >> +       } else if (PageUptodate(apage) || !trylock_page(apage)) {
> > >>                 f2fs_put_page(apage, 0);
> > >>                 return;
> > >>         }
> > >> -       f2fs_put_page(apage, 0);
> > >> -
> > >> -       apage = grab_cache_page(NODE_MAPPING(sbi), nid);
> > >> -       if (!apage)
> > >> -               return;
> > >>
> > >>         err = read_node_page(apage, READA);
> > >>         f2fs_put_page(apage, err ? 1 : 0);
> > >>
> > >> Thanks,
> > >>
> > >>>
> > >>>         apage = grab_cache_page(NODE_MAPPING(sbi), nid);
> > >>>         if (!apage)
> > >>> --
> > >>> 1.7.9.5
> > >>>
> > >>>
> > >>> --------------------------------------------------------------------
> > >>> --
> > >>> --------
> > >>> Site24x7 APM Insight: Get Deep Visibility into Application
> > >>> Performance APM + Mobile APM + RUM: Monitor 3 App instances at just
> > >>> $35/Month Monitor end-to-end web transactions and take corrective
> > >>> actions now Troubleshoot faster and improve end-user experience. Signup Now!
> > >>> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> > >>> _______________________________________________
> > >>> Linux-f2fs-devel mailing list
> > >>> Linux-f2fs-devel@lists.sourceforge.net
> > >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >
> > >
> > > ----------------------------------------------------------------------
> > > --------
> > > Site24x7 APM Insight: Get Deep Visibility into Application Performance
> > > APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> > > Monitor end-to-end web transactions and take corrective actions now
> > > Troubleshoot faster and improve end-user experience. Signup Now!
> > > http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://makebettercode.com/inteldaal-eval
