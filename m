From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/4] f2fs: return early when trying to read
 null nid
Date: Fri, 25 Dec 2015 08:57:19 +0800
Message-ID: <017501d13eaf$4fb361d0$ef1a2570$@samsung.com>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
	<1450923320-41113-2-git-send-email-jaegeuk@kernel.org>
	<015401d13e0e$f214f8e0$d63eeaa0$@samsung.com>
	<20151224201534.GA43846@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aCGi1-0005eH-BO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 00:58:17 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aCGhz-0002ZG-Ch
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 00:58:17 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZW003X62OVVW20@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 09:58:07 +0900 (KST)
In-reply-to: <20151224201534.GA43846@jaegeuk.local>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, December 25, 2015 4:16 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: return early when trying to read null nid
> 
> On Thu, Dec 24, 2015 at 01:49:24PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Thursday, December 24, 2015 10:15 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 2/4] f2fs: return early when trying to read null nid
> > >
> > > If get_node_page() gets zero nid, we can return early without getting a wrong
> > > page. For example, get_dnode_of_data() can try to do that.
> >
> > Good catch!
> >
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/node.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > index 341de5d..e17128d 100644
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -1059,6 +1059,9 @@ struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
> > >  {
> > >  	struct page *page;
> > >  	int err;
> > > +
> > > +	if (!nid)
> > > +		return ERR_PTR(-ENOENT);
> >
> > How about expand to check upper and lower boundary:
> >
> > 	if (check_nid_range)
> > 		return ERR_PTR(-ENOENT);
> 
> It'd better to add f2fs_bug_on(check_nid_range()) after this.
> Cause check_nid_range() checks its nid as *unlikely*, but this case seems
> *likely*.

Agreed.

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >  repeat:
> > >  	page = grab_cache_page(NODE_MAPPING(sbi), nid);
> > >  	if (!page)
> > > --
> > > 2.5.4 (Apple Git-61)
> > >
> > >
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
