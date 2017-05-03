From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix a mount fail for wrong
	next_scan_nid
Date: Wed, 3 May 2017 10:04:24 -0700
Message-ID: <20170503170424.GB93619@jaegeuk.local>
References: <20170426075652.4249-1-heyunlei@huawei.com>
	<7822ea80-3064-0b8e-e3f0-ce5e16217c05@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d5xhc-00059n-Hm
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 17:04:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d5xhb-0004ML-Rk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 17:04:36 +0000
Content-Disposition: inline
In-Reply-To: <7822ea80-3064-0b8e-e3f0-ce5e16217c05@huawei.com>
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

On 05/03, Chao Yu wrote:
> Hi all,
> 
> On 2017/4/26 15:56, Yunlei He wrote:
> > -write_checkpoint
> >    -do_checkpoint
> >       -next_free_nid    <--- something wrong with next free nid
> 
> Since we have figured out how next_scan_nid can be changed to a wrong value, so
> how about add a bug_on here to detect potential issue for further fixing?

I'll drop this patch for next merge window.
So, what was the root cause of this?

Thanks,

> 
> Thanks,
> 
> > 
> > -f2fs_fill_super
> >    -build_node_manager
> >       -build_free_nids
> >           -get_current_nat_page
> >              -__get_meta_page   <--- attempt to access beyond end of device
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > ---
> >  fs/f2fs/node.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index b99e318..98351a4 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1955,6 +1955,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
> >  	int i = 0;
> >  	nid_t nid = nm_i->next_scan_nid;
> >  
> > +	if (unlikely(nid >= nm_i->max_nid))
> > +		nid = 0;
> > +
> >  	/* Enough entries */
> >  	if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
> >  		return;
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
