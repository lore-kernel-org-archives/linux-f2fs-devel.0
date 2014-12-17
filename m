From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: use ra_meta_pages to simplify
 readahead code in restore_node_summary
Date: Wed, 17 Dec 2014 18:04:51 +0800
Message-ID: <001c01d019e1$1c949560$55bdc020$@samsung.com>
References: <003e01d0152b$a7fd0b60$f7f72220$@samsung.com>
	<20141217060436.GA7624@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Y1BVB-0001rX-Gs
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Dec 2014 10:06:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Y1BV9-0008Il-GZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Dec 2014 10:06:41 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NGQ00GA11ENNGC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Dec 2014 19:06:23 +0900 (KST)
In-reply-to: <20141217060436.GA7624@jaegeuk-mac02.mot-mobility.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, December 17, 2014 2:05 PM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH] f2fs: use ra_meta_pages to simplify readahead code in
> restore_node_summary
> 
> Hi Chao,
> 
> On Thu, Dec 11, 2014 at 06:16:27PM +0800, Chao Yu wrote:
> > Use more common function ra_meta_pages() with META_POR to readahead node blocks
> > in restore_node_summary() instead of ra_sum_pages(), hence we can simplify the
> > readahead code there, and also we can remove unused function ra_sum_pages().
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/node.c | 67 ++++++++++++----------------------------------------------
> >  1 file changed, 14 insertions(+), 53 deletions(-)

[snip]

> > -		invalidate_mapping_pages(inode->i_mapping, addr,
> > -							addr + nrpages);
> > +		truncate_inode_pages_range(META_MAPPING(sbi),
> > +						addr, addr + nrpages);
> 
> I found a bug here. :)

Thank you for your review! :)

> The truncate_inode_pages_range uses start and end parameters as byte offsets.
> So, you should use like (addr << PAGE_CACHE_SHIFT).
> 

Yes, you're correct, I will fix this and send v2 patch.

Regards,
Yu

> Thanks,
> 
> >  	}
> > -	return err;
> > +	return 0;
> >  }
> >
> >  static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> > --
> > 2.1.2


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
