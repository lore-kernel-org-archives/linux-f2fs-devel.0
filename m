From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix ref of discard command
Date: Sat, 24 Jun 2017 09:26:54 -0700
Message-ID: <20170624162654.GA38959@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170612030449.79290-1-jaegeuk@kernel.org>
	<bedfaab3-0f28-51b4-289a-dd7fcd9ccd8a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dOnto-0003aK-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:27:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dOntn-0007ZA-Lq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:27:04 +0000
Content-Disposition: inline
In-Reply-To: <bedfaab3-0f28-51b4-289a-dd7fcd9ccd8a@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 06/23, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/6/12 11:04, Jaegeuk Kim wrote:
> > This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on
> > 
> >   f2fs: add f2fs_bug_on in __remove_discard_cmd
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 86a0c1095939..a6d77388a806 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1025,6 +1025,8 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
> >  	list_for_each_entry_safe(dc, tmp, wait_list, list) {
> >  		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
> >  			wait_for_completion_io(&dc->wait);
> > +			if (dc->state == D_DONE && dc->ref)
> > +				dc->ref--;
> 
> How about using ("f2fs: stop discard thread in prior during umount") instead of
> this one? As dereference of dc here will lead use-after-free of real referrer.

Yup, I'll also verify that.
Thank you. :)

> 
> Thanks,
> 
> >  			__remove_discard_cmd(sbi, dc);
> >  		} else {
> >  			dc->ref++;
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
