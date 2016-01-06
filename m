From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: check the page status filled from
	disk
Date: Wed, 06 Jan 2016 11:14:22 +0800
Message-ID: <010601d14830$704ba210$50e2e630$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aGeZB-0005zN-7d
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 03:15:17 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aGeZ9-0003sb-3Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 03:15:17 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0I00KTPH165J40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 12:15:06 +0900 (KST)
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, January 06, 2016 10:30 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
> 
> Hi,
> 
> On Wed, Jan 06, 2016 at 09:21:29AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Wednesday, January 06, 2016 1:49 AM
> > > To: Chao Yu
> > > Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
> > >
> > > Hi Chao,
> > >
> > > On Tue, Jan 05, 2016 at 05:31:51PM +0800, Chao Yu wrote:
> > > > Hi Jaegeuk,
> > > >
> > > > > -----Original Message-----
> > > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > > Sent: Sunday, January 03, 2016 9:26 AM
> > > > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > > > linux-f2fs-devel@lists.sourceforge.net
> > > > > Cc: Jaegeuk Kim
> > > > > Subject: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
> > > > >
> > > > > After reading a page, we need to check whether there is any error.
> > > > >
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >  fs/f2fs/data.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > index 89a978c..11b2111 100644
> > > > > --- a/fs/f2fs/data.c
> > > > > +++ b/fs/f2fs/data.c
> > > > > @@ -448,6 +448,14 @@ repeat:
> > > > >
> > > > >  		/* wait for read completion */
> > > > >  		lock_page(page);
> > > > > +		if (unlikely(!PageUptodate(page))) {
> > > > > +			f2fs_put_page(page, 1);
> > > > > +			return ERR_PTR(-EIO);
> > > >
> > > > There is a convention in get_new_data_page, anyway we should release ipage
> > > > if there is any error occurs, but I think it will be ok to return directly
> > > > since it seems impossible the new dentry page has its real block address.
> > >
> > > Makes sense, but definitely ipage should be put. :)
> >
> > Alright. :)
> >
> > >
> > > >
> > > > To avoid any bug here or wrong usage, how about add bug_on as following patch?
> > > >
> > > > >From d92f0f34493b27ef28da67c446d552ce721b5d6f Mon Sep 17 00:00:00 2001
> > > > From: Chao Yu <chao2.yu@samsung.com>
> > > > Date: Tue, 5 Jan 2016 15:28:56 +0800
> > > > Subject: [PATCH] f2fs: add f2fs_bug_on in get_new_data_page
> > > >
> > > > In get_new_data_page, locked inode page should not be hold before
> > > > get_read_data_page, this patch adds f2fs_bug_on to detect this
> > > > condition.
> > > >
> > > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > > ---
> > > >  fs/f2fs/data.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > index 48f0bd3..2c5e3f6 100644
> > > > --- a/fs/f2fs/data.c
> > > > +++ b/fs/f2fs/data.c
> > > > @@ -440,6 +440,8 @@ repeat:
> > > >  		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> > > >  		SetPageUptodate(page);
> > > >  	} else {
> > > > +		f2fs_bug_on(F2FS_I_SB(inode), ipage);
> > > > +
> > > >  		f2fs_put_page(page, 1);
> > > >
> > > >  		page = get_read_data_page(inode, index, READ_SYNC, true);
> > > > --
> > > > 2.6.3
> > > >
> > > >
> > > > > +		}
> > > > > +		if (unlikely(page->mapping != mapping)) {
> > > > > +			f2fs_put_page(page, 1);
> > > > > +			goto repeat;
> > > > > +		}
> > > >
> > > > How about use get_lock_data_page to avoid duplicated code?
> > >
> > > Agreed.
> > >
> > > How about this?
> > >
> > > From fef77fb244a706491e8e4c46cb245e99e22003c3 Mon Sep 17 00:00:00 2001
> > > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Date: Fri, 1 Jan 2016 22:03:47 -0800
> > > Subject: [PATCH] f2fs: check the page status filled from disk
> > >
> > > After reading a page, we need to check whether there is any error.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/data.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 89a978c..89d633a 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -442,12 +442,16 @@ repeat:
> > >  	} else {
> > >  		f2fs_put_page(page, 1);
> > >
> > > -		page = get_read_data_page(inode, index, READ_SYNC, true);
> > > -		if (IS_ERR(page))
> > > -			goto repeat;
> > > +		f2fs_bug_on(F2FS_I_SB(inode), ipage);
> > >
> > > -		/* wait for read completion */
> > > -		lock_page(page);
> > > +		page = get_lock_data_page(inode, index, true);
> > > +		if (IS_ERR(page)) {
> > > +			if (PTR_ERR(page) == -EIO) {
> > > +				f2fs_put_page(ipage, 1);
> > > +				return page;
> > > +			}
> > > +			goto repeat;
> >
> > Seems if get_lock_data_page always return -EFAULT, we may run into an
> > infinite loop. IMO, it's not a bad thing to tolerate other error more
> > than EIO returned from get_lock_data_page. How about return directly
> > when error is returned? And add a bug_on for ENOENT which seems not
> > impossible here?
> 
> Hmm. I can only expect EIO, ENOMEM, and ENOENT.
> What condition can we get EFAULT?

It's possible in following call path:
- get_new_data_page
 - get_read_data_page
  - f2fs_submit_page_bio
   - bio_add_page           failed and return -EFAULT

Right?

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > > +		}
> > >  	}
> > >  got_it:
> > >  	if (new_i_size && i_size_read(inode) <
> > > --
> > > 2.6.3
> >


------------------------------------------------------------------------------
