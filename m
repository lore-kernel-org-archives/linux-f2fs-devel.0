From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH V2 2/2 RESEND] f2fs: read contiguous sit
 entry pages by merging for mount performance
Date: Thu, 21 Nov 2013 18:35:41 +0900
Message-ID: <1385026541.26319.79.camel@kjgkr>
References: <001d01cee5bc$779c2fe0$66d48fa0$@samsung.com>
	<1384997517.26319.60.camel@kjgkr>
	<000001cee668$872ec6a0$958c53e0$@samsung.com>
	<1385009132.26319.71.camel@kjgkr>
	<000201cee684$550e11a0$ff2a34e0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VjQgx-00045L-V6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 09:36:55 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjQgw-0003ku-1B for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 09:36:55 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWL00AS4XCRKBF0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Nov 2013 18:36:33 +0900 (KST)
In-reply-to: <000201cee684$550e11a0$ff2a34e0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

> > >
> > > >
> > > > The ra_sit_pages() tries to read consecutive sit pages as many as
> > > > possible.
> > > > So then, what about just checking whether its block address is
> > > > contiguous or not?
> > > >
> > > > Something like this:
> > > >  -ra_sit_pages()
> > > > 	blkno = start;
> > > > 	while (blkno < sit_i->sit_blocks) {
> > > > 		blk_addr = current_sit_addr(sbi, blkno);
> > > > 		if (blkno != start && prev_blk_addr + 1 != blk_addr)
> > > > 			break;
> > > >
> > > > 		/* grab and submit_read_page */
> > > >
> > > > 		prev_blk_addr = blk_addr;
> > > > 		blkno++;
> > > > 	}
> > >
> > > Agreed, this method could remove *order.
> > > Shouldn't we add nrpages for readahead policy as VM?
> > 
> > Aha, agreed.
> > We need nrpages to avoid too many reads on sit blocks.
> > 
> > But, still it needs to change the nrpages in its caller.
> > In your patch, it was sit_i->sit_blocks that is total # of sit blocks.
> > I think 128 or 256 is quite reasonable number.
> 
> Hmm, Originally in [PATCH V1] it was be set to 
> MAX_BIO_BLOCKS(max_hw_blocks(sbi)).
> 
> So it could be "#define SIT_ENTRIES_RA_NUM	128"?
> BTW, maybe we should send dynamical nrpages which depend on 
> memory state of system as I mention in previous thread.
> How do you think?

I think it'd be better to use MAX_BIO_BLOCKS().

> 
> > 
> > Anyway, how about implementing ra_sit_pages() with a blk_plug likewise
> > ra_node_pages()?

My mistake.
This was the ra_nat_pages().

> 
> So we use this structure to plug multi bios submitting in ra_sit_pages(), right?
> -build_sit_entries()
> 	blk_start_plug(&plug);
> 	ra_sit_pages();
> 	blk_finish_plug(&plug);

Ah. What I meant was:
 blk_start_plug(&plug);
 for()
 	read_sit_page();
 blk_finish_plug(&plug);

But, it is not a big deal.
It doesn't matter to use your approach.
Please ignore this.

BTW, I found that we can use submit_read_page() at ra_nat_pages() and
remove block plugging.
I'll send a patch for this. :)
Thanks,

-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
