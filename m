From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] f2fs-tools: fix blocks allocation
 direction inside segment
Date: Thu, 17 May 2018 17:58:05 -0700
Message-ID: <20180518005805.GB33876@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180508141659.118390-1-zhengjunling@huawei.com>
 <95fbd76a-a4ec-e678-a074-e95612ba37bf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fJTiv-0000gh-2g
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 May 2018 00:58:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fJTip-008yj7-92
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 May 2018 00:58:20 +0000
Content-Disposition: inline
In-Reply-To: <95fbd76a-a4ec-e678-a074-e95612ba37bf@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 05/14, Chao Yu wrote:
> On 2018/5/8 22:16, Junling Zheng wrote:
> > This fixes the block allocation direction from left to right inside
> > one segment despite of the direction of segment allocation.
> 
> Hmm.. there is no such restriction that we have to keep misc tools' allocation
> algorithm line with kernel one, so I suggest that let's just keep original
> codes. Jaegeuk, what's your opinion?

Yeah, let's keep it as is.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> > ---
> >  fsck/mount.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fsck/mount.c b/fsck/mount.c
> > index 1396a2e..38d2aa2 100644
> > --- a/fsck/mount.c
> > +++ b/fsck/mount.c
> > @@ -1921,13 +1921,13 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
> >  
> >  		if (se->valid_blocks == sbi->blocks_per_seg ||
> >  				IS_CUR_SEGNO(sbi, segno, type)) {
> > -			*to = left ? START_BLOCK(sbi, segno) - 1:
> > +			*to = left ? START_BLOCK(sbi, segno - 1) :
> >  						START_BLOCK(sbi, segno + 1);
> >  			continue;
> >  		}
> >  
> >  		if (se->valid_blocks == 0 && not_enough) {
> > -			*to = left ? START_BLOCK(sbi, segno) - 1:
> > +			*to = left ? START_BLOCK(sbi, segno - 1) :
> >  						START_BLOCK(sbi, segno + 1);
> >  			continue;
> >  		}
> > @@ -1949,7 +1949,10 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
> >  			!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
> >  			return 0;
> >  
> > -		*to = left ? *to - 1: *to + 1;
> > +		if (!(OFFSET_IN_SEG(sbi, *to + 1)) && left)
> > +			*to = START_BLOCK(sbi, segno - 1);
> > +		else
> > +			*to = *to + 1;
> >  	}
> >  	return -1;
> >  }
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
