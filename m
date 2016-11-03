From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/7] resize.f2fs: get latest free segments
Date: Thu, 3 Nov 2016 10:36:34 -0700
Message-ID: <20161103173634.GA76264@jaegeuk>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
	<20161103052846.72244-4-jaegeuk@kernel.org>
	<911fa82d-b2b8-5d0f-c469-09f39c9624a5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2M49-0007KI-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 17:44:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2M48-0005FI-5d
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 17:44:41 +0000
Content-Disposition: inline
In-Reply-To: <911fa82d-b2b8-5d0f-c469-09f39c9624a5@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Nov 03, 2016 at 02:53:20PM +0800, heyunlei wrote:
> 
> Hi, Kim
> On 2016/11/3 13:28, Jaegeuk Kim wrote:
> > The # of free segments can be changed by defragmentation.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fsck/resize.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fsck/resize.c b/fsck/resize.c
> > index 5dc73a8..4813de7 100644
> > --- a/fsck/resize.c
> > +++ b/fsck/resize.c
> > @@ -424,7 +424,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
> >  	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
> >  						get_cp(rsvd_segment_count));
> > 
> > -	free_segment_count = get_cp(free_segment_count);
> > +	free_segment_count = get_free_segments(sbi);
> 
> f2fs_defragment will write a checkpoint and then update free_segment_count
> by get_free_segments(sbi)o<
 Is it righto<

Oh, I misread your point.
Yup, but, this is to handle f2fs_defragment incompletion. In that case,
resize.f2fs would call migrate_main() and finally rebuild_checkpoint() with
wrong free_segments.

> 
> Thankso<

> >  	new_segment_count = get_newsb(segment_count_main) -
> >  					get_sb(segment_count_main);
> > 
> > 

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
