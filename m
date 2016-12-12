From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: give random checkpoint version
Date: Mon, 12 Dec 2016 10:59:13 -0800
Message-ID: <20161212185913.GB61413@jaegeuk.local>
References: <20161125023256.80540-1-jaegeuk@kernel.org>
	<e4549e48-142d-13ee-b224-2b59d8bef2a6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cGVoo-0001j6-61
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 18:59:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cGVon-0006Cb-GC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 18:59:22 +0000
Content-Disposition: inline
In-Reply-To: <e4549e48-142d-13ee-b224-2b59d8bef2a6@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 12/10, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/11/25 10:32, Jaegeuk Kim wrote:
> > This is to avoid wrong recovery during xfstests.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  mkfs/f2fs_format.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index 9a536f0..d2254e7 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -507,7 +507,7 @@ static int f2fs_write_check_point_pack(void)
> >  	}
> >  
> >  	/* 1. cp page 1 of checkpoint pack 1 */
> > -	set_cp(checkpoint_ver, 1);
> > +	cp->checkpoint_ver = rand();
> 
> I can see the last patch merged in upstream is:
> 
> +	cp->checkpoint_ver = rand() | 0x1;
> 
> Any difference and why don't we use set_cp?

In order to support old f2fs driver, we should at least keep the ordering
by default, since such the version conversion would not be a normal case.

Thanks,

> 
> Thanks,
> 
> >  	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
> >  	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
> >  	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
