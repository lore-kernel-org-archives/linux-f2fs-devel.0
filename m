From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix an error return value in
 truncate_partial_data_page
Date: Wed, 1 Mar 2017 11:32:50 -0800
Message-ID: <20170301193250.GB18600@jaegeuk.local>
References: <20170228123241.5070-1-heyunlei@huawei.com>
	<98366c6a-4bcd-44cc-4143-a22a359db63d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cj9ze-0006p3-Mu
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 19:32:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cj9zd-0005XL-SX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 19:32:58 +0000
Content-Disposition: inline
In-Reply-To: <98366c6a-4bcd-44cc-4143-a22a359db63d@huawei.com>
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

On 03/01, Chao Yu wrote:
> On 2017/2/28 20:32, Yunlei He wrote:
> > This patch fix a error return value in truncate_partial_data_page
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > ---
> >  fs/f2fs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index c6ca00c..c186d75 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -529,7 +529,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
> >  
> >  	page = get_lock_data_page(inode, index, true);
> >  	if (IS_ERR(page))
> > -		return 0;
> > +		return page;
> 
> return PTR_ERR(page);

Do we need this?

return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);

Thanks,

> 
> Thanks,
> 
> >  truncate_out:
> >  	f2fs_wait_on_page_writeback(page, DATA, true);
> >  	zero_user(page, offset, PAGE_SIZE - offset);
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
