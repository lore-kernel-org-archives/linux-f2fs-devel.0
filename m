From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/4] f2fs: avoid frequent checkpoint during
	f2fs_gc
Date: Tue, 11 Apr 2017 15:13:59 -0700
Message-ID: <20170411221359.GA4073@jaegeuk.local>
References: <20170411001308.12881-1-jaegeuk@kernel.org>
	<20170411001308.12881-4-jaegeuk@kernel.org>
	<af677bdd-bf75-a928-1c4c-541642199b4b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cy438-0001Iq-4a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 22:14:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cy436-0002lL-5r
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 22:14:10 +0000
Content-Disposition: inline
In-Reply-To: <af677bdd-bf75-a928-1c4c-541642199b4b@huawei.com>
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

On 04/11, Chao Yu wrote:
> On 2017/4/11 8:13, Jaegeuk Kim wrote:
> > Now we're doing SSR aggressively more than ever before, so once we reach to
> > the reserved_segment, f2fs_balance_fs will call f2fs_gc, which triggers
> > checkpoint everytime. We actually must avoid that.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e2f9b2b12b74..4a720f3394d9 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -966,7 +966,11 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
> >  		 * threshold, we can make them free by checkpoint. Then, we
> >  		 * secure free segments which doesn't need fggc any more.
> >  		 */
> > -		ret = write_checkpoint(sbi, &cpc);
> > +		if (prefree_segments(sbi)) {
> > +			ret = write_checkpoint(sbi, &cpc);
> > +			if (ret)
> > +				goto stop;
> > +		}
> >  		if (ret)
> >  			goto stop;
> 
> We don't need redundant check here?

Yup, will remove this. ;)

> 
> Otherwise, this patchset looks good to me, anyway please add:
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
> >  		if (has_not_enough_free_secs(sbi, 0, 0))
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
