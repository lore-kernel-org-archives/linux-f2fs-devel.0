From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/2] f2fs: support FALLOC_FL_COLLAPSE_RANGE
Date: Thu, 30 Apr 2015 09:38:14 +0800
Message-ID: <025401d082e6$7650a530$62f1ef90$@samsung.com>
References: <007901d079be$9cfb81e0$d6f285a0$@samsung.com>
 <20150429213042.GB8429@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150429213042.GB8429@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, April 30, 2015 5:31 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: support FALLOC_FL_COLLAPSE_RANGE
> 
> Hi Chao,
> 
> On Sat, Apr 18, 2015 at 06:00:36PM +0800, Chao Yu wrote:
> > Now, FALLOC_FL_COLLAPSE_RANGE flag in ->fallocate is supported in ext4/xfs.
> >
> > In commit, the semantics of this flag is descripted as following:
> > "1) It collapses the range lying between offset and length by removing any data
> >    blocks which are present in this range and than updates all the logical
> >    offsets of extents beyond "offset + len" to nullify the hole created by
> >    removing blocks. In short, it does not leave a hole.
> > 2) It should be used exclusively. No other fallocate flag in combination.
> > 3) Offset and length supplied to fallocate should be fs block size aligned
> >    in case of xfs and ext4.
> > 4) Collaspe range does not work beyond i_size."
> >
> > This patch implements fallocate's FALLOC_FL_COLLAPSE_RANGE for f2fs.
> >

[snip]

> > +void replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> > +				block_t old_blkaddr, block_t new_blkaddr)
> 
> Seems like we can reuse the code in recover_data_page.
> How about adding a generic replace_block(..., bool recover_curseg) for both of
> them?

Agree, I will do it. Thanks for your review! :)

> 
> For other flow, looks good to me.
> 
> Nice work.
> Thanks,
