From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 04/10] f2fs: support IO alignment for DATA
 and NODE writes
Date: Wed, 4 Jan 2017 15:44:44 -0800
Message-ID: <20170104234444.GD1011@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-4-jaegeuk@kernel.org>
	<7920f143-750a-69df-f4b3-eeac82c1014b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cOvEj-0000TY-EJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 23:44:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cOvEi-0006mb-Nq
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 23:44:53 +0000
Content-Disposition: inline
In-Reply-To: <7920f143-750a-69df-f4b3-eeac82c1014b@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 01/04, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/12/31 2:51, Jaegeuk Kim wrote:
> > This patch implements IO alignment by filling dummy blocks in DATA and NODE
> > write bios. If we can guarantee, for example, 32KB or 64KB for such the IOs,
> > we can eliminate underlying dummy page problem which FTL conducts in order to
> > close MLC or TLC partial written pages.
> > 
> > Note that,
> >  - it requires "-o mode=lfs".
> >  - IO size should be power of 2, not exceed BIO_MAX_PAGES, 256.
> >  - read IO is still 4KB.
> >  - do checkpoint at fsync, if dummy NODE page was written.
> 
> Which scenario we can benefit from? Any numbers?

I described it in the patch. This is not targetting for performance improvement
for now, but to address the dummy page write problem in FTL so that we can later
implement very simple host-level FTL on top of open-channel SSD.

> I doubt that there are some potential side-effect points:
>  - write amplification will be more serious than before
>  - free space will be more fragmented since dummy blocks is separated in whole
> address space
>  - there is less chance to merge small(unaligned) IOs in block layer

I agree, so I just added this as a mount option experimentally.
One point would be that, if f2fs doesn't do this, FTL should do it. So I think,
from the system point of view, f2fs is a better layer to do it.

Thanks,

> 
> Thoughts?
> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
