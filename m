From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong sum_page pointer in f2fs_gc
Date: Thu, 13 Oct 2016 10:14:21 -0700
Message-ID: <20161013171421.GA6363@jaegeuk>
References: <20161012232304.6667-1-jaegeuk@kernel.org>
	<faeadd54-7814-41b5-b041-2d0eb819c3f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bujaO-0008Vt-8L
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 17:14:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bujaN-0005pB-97
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 17:14:28 +0000
Content-Disposition: inline
In-Reply-To: <faeadd54-7814-41b5-b041-2d0eb819c3f6@huawei.com>
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

On Thu, Oct 13, 2016 at 06:33:19PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/10/13 7:23, Jaegeuk Kim wrote:
> > This patch fixes using a wrong pointer for sum_page in f2fs_gc.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e48142f..9c18917 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -854,16 +854,16 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >  
> >  	for (segno = start_segno; segno < end_segno; segno++) {
> >  
> > -		if (get_valid_blocks(sbi, segno, 1) == 0 ||
> > -					unlikely(f2fs_cp_error(sbi)))
> > -			goto next;
> > -
> >  		/* find segment summary of victim */
> >  		sum_page = find_get_page(META_MAPPING(sbi),
> >  					GET_SUM_BLOCK(sbi, segno));
> > -		f2fs_bug_on(sbi, !PageUptodate(sum_page));
> >  		f2fs_put_page(sum_page, 0);
> >  
> > +		if (get_valid_blocks(sbi, segno, 1) == 0 ||
> > +				!PageUptodate(sum_page) ||
> 
> Why uptodate flag of summary page can be cleared? someone truncates it?

Well, it looks like no problem to remove this, since it will hit
f2fs_cp_error(). I just intended to handle the above f2fs_bug_on here.

I found you added the above bug_on, but it's not a big deal to remain tho. :)

718e53fa: f2fs: enhance foreground GC

Thanks,

> 
> Thanks,
> 
> > +				unlikely(f2fs_cp_error(sbi)))
> > +			goto next;
> > +
> >  		sum = page_address(sum_page);
> >  		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
> >  
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
