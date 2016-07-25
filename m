From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: get victim segment again after new
	cp
Date: Mon, 25 Jul 2016 11:40:05 -0700
Message-ID: <20160725184005.GB56718@jaegeuk>
References: <1469185711-27932-1-git-send-email-heyunlei@huawei.com>
	<20160722185922.GA36408@jaegeuk>
	<6fbd66c3-ccfc-0389-dde5-81b901cb4586@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bRknT-0002BU-Pw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jul 2016 18:40:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bRknS-0003WF-FH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jul 2016 18:40:11 +0000
Content-Disposition: inline
In-Reply-To: <6fbd66c3-ccfc-0389-dde5-81b901cb4586@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sun, Jul 24, 2016 at 06:38:46AM +0800, Chao Yu wrote:
...

> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index de6c41c..ec17096 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -908,10 +908,14 @@ gc_more:
> >>  		 * enough free sections, we should flush dent/node blocks and do
> >>  		 * garbage collections.
> >>  		 */
> >> -		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
> >> +		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi)) {
> >>  			write_checkpoint(sbi, &cpc);
> >> -		else if (has_not_enough_free_secs(sbi, 0))
> > 
> > If segno is NULL_SEGNO, we get a panic when checking the below conditions.
> > Anyway, I don't think we need this condition at all.
> 
> I thinks the condition which trigger our f2fs_bug_on is really a corner case,
> we'd better not waste the victim we found everytime, especially for these
> victims from last background gc's victims.
> 
> What about checking segno first?
> 
> if(segno != NULL_SEGNO && (!get_valid_blocks(sbi, segno, sbi->segs_per_sec) ||
> 	IS_CURSEC(sbi, GET_SECNO(sbi, segno)))
> 	segno = NULL_SEGNO;

My viewpoint is write_checkpoint() flushes node and dentry pages, which provides
another better victims. Another concern is get_valid_blocks and IS_CURSEG are
not covered by any lock.

Thanks,

> 
> Thanks,
> 
> > Let me remove them and just set NULL_SEGNO only after checkpoint.
> > Please check the dev-test repo.
> > 
> > Thanks,
> > 
> >> +			if(!get_valid_blocks(sbi, segno, sbi->segs_per_sec)
> >> +					|| IS_CURSEC(sbi, segno / sbi->segs_per_sec))
> >> +				segno = NULL_SEGNO;
> >> +		} else if (has_not_enough_free_secs(sbi, 0)) {
> >>  			write_checkpoint(sbi, &cpc);
> >> +		}
> >>  	}
> >>  
> >>  	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
> >> -- 
> >> 1.9.1
> > 
> > ------------------------------------------------------------------------------
> > What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> > patterns at an interface-level. Reveals which users, apps, and protocols are 
> > consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
> > J-Flow, sFlow and other flows. Make informed decisions using capacity planning
> > reports.http://sdm.link/zohodev2dev
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
