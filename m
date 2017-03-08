From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add a punch discard command function
Date: Wed, 8 Mar 2017 13:33:44 -0800
Message-ID: <20170308213344.GA5483@jaegeuk.local>
References: <20170302023620.13337-1-heyunlei@huawei.com>
	<20170308013612.GD2499@jaegeuk.local>
	<20170308024954.GB11351@jaegeuk.local>
	<a21e8bec-e02a-5c01-95fa-a536454efbc7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cljDW-00047Y-Hz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:33:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cljDV-0005aR-A6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:33:54 +0000
Content-Disposition: inline
In-Reply-To: <a21e8bec-e02a-5c01-95fa-a536454efbc7@huawei.com>
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

On 03/08, heyunlei wrote:
> Hi Jaegeuk,
> 
> On 2017/3/8 10:49, Jaegeuk Kim wrote:
> > On 03/07, Jaegeuk Kim wrote:
> > > Hi Yunlei,
> > > 
> > > On 03/02, Yunlei He wrote:
> > > > This patch add a function to punch discard command if one segment
> > > > reuse before discard. Split this segment from multi-segments discard
> > > > range, and discard the left bigger range.
> > > > 
> > > > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > > > ---
> > > >  fs/f2fs/segment.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 4bd7a8b..1e1d5d3 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -672,6 +672,22 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
> > > >  	kmem_cache_free(discard_cmd_slab, dc);
> > > >  }
> > > > 
> > > > +static void __punch_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc, block_t blkaddr)
> > > > +{
> > > > +	block_t end_block = START_BLOCK(sbi, GET_SEGNO(sbi, blkaddr) + 1);
> > > > +
> > > > +	if (dc->lstart + dc->len <= end_block) {
> > > > +		__remove_discard_cmd(sbi, dc);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	if (blkaddr - dc->lstart < dc->lstart + dc->len - end_block) {
> > > > +		dc->lstart = end_block;
> > > > +		dc->len -= (end_block - dc->lstart);
> > > 
> > > I just missed one thing which we already have a bio to submit later. So, in
> > > order to do this, we should manage dc->bio as well.
> > > Let me think about whole flow again.
> > 
> > Please take a look at:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=ef63d148d469f249622afe9e89fc273848ee427b
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=eea59dd279d5d34eb8d9652b7af1bd9e45a3b69e
> 
> It looks good to me.

One more bug fix.

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=bd9c4619e81d42c7df1758b6841fd0909840c687

Thanks,

> 
> Thanks.
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > 
> > > > +	} else
> > > > +		dc->len = blkaddr - dc->lstart;
> > > > +}
> > > > +
> > > >  /* This should be covered by global mutex, &sit_i->sentry_lock */
> > > >  void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
> > > >  {
> > > > @@ -708,7 +724,7 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
> > > >  	if (blkaddr == NULL_ADDR) {
> > > >  		list_for_each_entry_safe(dc, tmp, wait_list, list) {
> > > >  			wait_for_completion_io(&dc->wait);
> > > > -			__remove_discard_cmd(sbi, dc);
> > > > +			__punch_discard_cmd(sbi, dc, blkaddr);
> > > >  		}
> > > >  	}
> > > >  	mutex_unlock(&dcc->cmd_lock);
> > > > --
> > > > 2.10.1
> > > 
> > > ------------------------------------------------------------------------------
> > > Announcing the Oxford Dictionaries API! The API offers world-renowned
> > > dictionary content that is easy and intuitive to access. Sign up for an
> > > account today to start using our lexical data to power your apps and
> > > projects. Get started today and enter our developer competition.
> > > http://sdm.link/oxford
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
