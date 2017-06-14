From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix ref of discard command
Date: Wed, 14 Jun 2017 07:26:48 -0700
Message-ID: <20170614142648.GA74571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170612030449.79290-1-jaegeuk@kernel.org>
	<54b5aaad-1674-8d76-c489-d5eee6ef7f26@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dL9G5-0005ir-ME
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 14:26:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dL9G3-0007wb-Ri
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 14:26:57 +0000
Content-Disposition: inline
In-Reply-To: <54b5aaad-1674-8d76-c489-d5eee6ef7f26@huawei.com>
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

On 06/12, Chao Yu wrote:
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
> Should set dc->ref to 0 to avoid panic once we add other referrers?

Sorry, could you please explain this in more detail?

Thanks,

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
