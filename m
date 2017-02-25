From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Fri, 24 Feb 2017 18:07:33 -0800
Message-ID: <20170225020733.GB50867@jaegeuk.local>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1chRlv-0008Oz-4e
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:07:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1chRlu-0004Xi-BB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:07:43 +0000
Content-Disposition: inline
In-Reply-To: <58B0E17C.1030306@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/25, Hou Pengyang wrote:
> On 2017/2/24 18:28, Chao Yu wrote:
> > On 2017/2/24 18:01, Hou Pengyang wrote:
> > > Under scenerio with large number of dirty nodes, and these nodes are flushed
> > > in SSR mode during cp. enough free segemts now, no need to do fggc.
> > 
> > We'd better break out of GC flow once we encounter cp error, so additional
> > condition judgment is not needed.
> > 
> 
> In (ret || !has_not_enough_free_secs(sbi, sec_freed, 0)),
> if cp return error(NOT zero), flow will goto stop directly without
> has_not_enough_free_secs checking;
> if cp return ok(zero), has_not_enough_free_secs would be checked.

Well, I think it'd be fine to do one gc by a background thread.

Thanks,

> 
> Thanks,
> 
> > Thanks,
> > 
> > > 
> > > Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> > > ---
> > >   fs/f2fs/gc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 6c996e3..41bdfb7 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -959,7 +959,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
> > >   		 * garbage collections.
> > >   		 */
> > >   		ret = write_checkpoint(sbi, &cpc);
> > > -		if (ret)
> > > +		if (ret || !has_not_enough_free_secs(sbi, sec_freed, 0))
> > >   			goto stop;
> > >   	} else if (gc_type == BG_GC && !background) {
> > >   		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> > > 
> > 
> > 
> > .
> > 
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
