From: Fan Li <fanofcode.li@samsung.com>
Subject: Re: [PATCH] f2fs: keep scanning until enough free nids
 are acquired
Date: Tue, 07 Nov 2017 15:30:31 +0800
Message-ID: <001d01d3579a$82f21680$88d64380$@samsung.com>
References: <CGME20171107030535epcas1p2094e05ca25eecd2140518cab7a39723d@epcas1p2.samsung.com>
 <001901d35775$47b598f0$d720cad0$@samsung.com>
 <20171107034034.GC92599@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <fanofcode.li@samsung.com>) id 1eByMq-0005FM-Ji
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 07:32:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eByMn-0002GE-Us
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 07:32:16 +0000
In-reply-to: <20171107034034.GC92599@jaegeuk-macbookpro.roam.corp.google.com>
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, November 07, 2017 11:41 AM
> To: Fan Li
> Cc: 'Chao Yu'; 'Chao Yu'; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: keep scanning until enough free nids are acquired
> 
> Hi,
> 
> I merged this patch after fixing some broken format. Could you please check your email configuration?
> 
> Thanks,
> 

Sorry to bother you with so trivial problem, mail configuration is fine, 
but I use a wrong way to copy the text this time, won't happen again.


> On 11/07, Fan Li wrote:
> > In current version, after scan_free_nid_bits, the scan is over if nid_cnt[FREE_NID] != 0.
> > In most cases, there are still free nids in the free list during the
> > scan, and scan_free_nid_bits usually can't increase nid_cnt[FREE_NID].
> > It causes that __build_free_nids is called many times without solving
> > the shortage of the free nids. This patch fixes that.
> >
> > Signed-off-by: Fan li <fanofcode.li@samsung.com>
> > ---
> >  fs/f2fs/node.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 3d0d1be..5cef118
> > 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -2010,7 +2010,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
> >                 /* try to find free nids in free_nid_bitmap */
> >                 scan_free_nid_bits(sbi);
> >
> > -               if (nm_i->nid_cnt[FREE_NID])
> > +               if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
> >                         return;
> >         }
> >
> > --
> > 2.7.4



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
