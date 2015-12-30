From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: init variable total_zombie_tree
Date: Wed, 30 Dec 2015 10:15:23 -0800
Message-ID: <20151230181523.GB28564@jaegeuk.local>
References: <1451460488-16730-1-git-send-email-heyunlei@huawei.com>
	<00ee01d142e0$d1fc5ea0$75f51be0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aELHU-0000P0-E4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:15:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aELHS-0004yI-DA for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:15:28 +0000
Content-Disposition: inline
In-Reply-To: <00ee01d142e0$d1fc5ea0$75f51be0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On Wed, Dec 30, 2015 at 05:01:48PM +0800, Chao Yu wrote:
> Hi Yunlei,
> 
> > -----Original Message-----
> > From: Yunlei He [mailto:heyunlei@huawei.com]
> > Sent: Wednesday, December 30, 2015 3:28 PM
> > To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org; chao2.yu@samsung.com
> > Cc: bintian.wang@huawei.com; Yunlei He
> > Subject: [f2fs-dev][PATCH] f2fs: init variable total_zombie_tree
> > 
> > This patch init total_zombie_tree in init_extent_cache_info.
> 
> Sorry, seems I mislead you, I meant it's better let Jaegeuk to fix the
> issue in his original patch, not in the patch you replied.

Sorry, me too. :(
Let me update this in the original patch.

Thanks,

> 
> Anyway, this patch looks good to me. :)
> 
> Thanks,
> 
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > ---
> >  fs/f2fs/extent_cache.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 23e7c82..b37184f 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -737,6 +737,7 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi)
> >  	INIT_LIST_HEAD(&sbi->extent_list);
> >  	spin_lock_init(&sbi->extent_lock);
> >  	atomic_set(&sbi->total_ext_tree, 0);
> > +	atomic_set(&sbi->total_zombie_tree, 0);
> >  	atomic_set(&sbi->total_ext_node, 0);
> >  }
> > 
> > --
> > 1.9.1
> 

------------------------------------------------------------------------------
