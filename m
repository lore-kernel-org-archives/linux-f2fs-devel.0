From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/4] f2fs: limit b_size of mapped bh in
	f2fs_map_bh
Date: Tue, 24 Mar 2015 13:02:04 +0800
Message-ID: <003301d065ef$c78b03f0$56a10bd0$@samsung.com>
References: <002201d06511$16e17c70$44a47550$@samsung.com>
	<20150324044211.GA35842@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YaGzW-0000Sy-A3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 05:03:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YaGzU-00036w-90
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 05:03:02 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NLP000C3A0SV290@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 14:02:52 +0900 (KST)
In-reply-to: <20150324044211.GA35842@jaegeuk-mac02.hsd1.ca.comcast.net>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, March 24, 2015 12:42 PM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] f2fs: limit b_size of mapped bh in f2fs_map_bh
> 
> Hi Chao,
> 
> On Mon, Mar 23, 2015 at 10:28:00AM +0800, Chao Yu wrote:
> > Map bh over max size which caller defined is not needed, limit it in
> > f2fs_map_bh.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index f0a18a0..a99bc7f 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -255,15 +255,16 @@ static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
> >  			struct extent_info *ei, struct buffer_head *bh_result)
> >  {
> >  	unsigned int blkbits = sb->s_blocksize_bits;
> > +	unsigned int maxblocks = bh_result->b_size >> blkbits;
> >  	size_t count;
> >
> >  	clear_buffer_new(bh_result);
> >  	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
> >  	count = ei->fofs + ei->len - pgofs;
> > -	if (count < (UINT_MAX >> blkbits))
> > -		bh_result->b_size = (count << blkbits);
> > +	if (count > maxblocks)
> > +		bh_result->b_size = maxblocks << blkbits;
> >  	else
> > -		bh_result->b_size = UINT_MAX;
> > +		bh_result->b_size = count << blkbits;
> 
> How about using min()?

Better, I will do it. :)

Thanks,

> 
> Thanks,
> 
> >  }
> >
> >  static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
> > --
> > 2.3.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
