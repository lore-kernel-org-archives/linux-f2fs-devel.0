From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: no need lock_op in
 f2fs_write_inline_data
Date: Fri, 24 Feb 2017 18:10:23 -0800
Message-ID: <20170225021023.GC50867@jaegeuk.local>
References: <20170223123120.18842-1-heyunlei@huawei.com>
	<20170223194529.GE2026@jaegeuk.local>
	<0e037d54-9f45-d38b-da91-b5765fa83a62@huawei.com>
	<20170224195837.GE39009@jaegeuk.local>
	<ffdfdb1c-4a33-2d81-7776-2fd001cc85ec@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1chRoe-00005h-UG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:10:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1chRod-0004tb-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:10:32 +0000
Content-Disposition: inline
In-Reply-To: <ffdfdb1c-4a33-2d81-7776-2fd001cc85ec@huawei.com>
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

On 02/25, Chao Yu wrote:
> On 2017/2/25 3:58, Jaegeuk Kim wrote:
> > On 02/24, heyunlei wrote:
> >> Hi Jaegeuk,
> >>
> >> 	Can you explain more about this? Besides, how about inplace update?
> > 
> > Oh, sorry. I confused it was the inline_data conversion. ;)
> > Yup, we can avoid entire f2fs_lock_op like this. And we can avoid IPU as well,
> > but it's quite difficult to detect that.
> 
> Seems when there is a large number of dirty inline data in page cache, then
> trigger intensively writeback and CP can run out of free space?

I expect that f2fs_balance_fs() will hopefully block them.

Thanks,

> 
> Thanks,
> 
> > 
> >>From 146e4c1ca458b1e33bf7f658f8796a8763e67a4e Mon Sep 17 00:00:00 2001
> > From: Yunlei He <heyunlei@huawei.com>
> > Date: Thu, 23 Feb 2017 20:31:20 +0800
> > Subject: [PATCH] f2fs: no need lock_op in f2fs_write_inline_data
> > 
> > Similar as f2fs_write_inode, f2fs_write_inline_data just
> > mark inode page dirty, so it's no need to write inline data
> > under read lock of cp_rwsem.
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 80f9863dc4b0..9e51c5e40ce1 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1414,9 +1414,12 @@ static int __write_data_page(struct page *page, bool *submitted,
> >  		goto redirty_out;
> >  
> >  	err = -EAGAIN;
> > -	f2fs_lock_op(sbi);
> > -	if (f2fs_has_inline_data(inode))
> > +	if (f2fs_has_inline_data(inode)) {
> >  		err = f2fs_write_inline_data(inode, page);
> > +		if (!err)
> > +			goto out;
> > +	}
> > +	f2fs_lock_op(sbi);
> >  	if (err == -EAGAIN)
> >  		err = do_write_data_page(&fio);
> >  	if (F2FS_I(inode)->last_disk_size < psize)
> > 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
