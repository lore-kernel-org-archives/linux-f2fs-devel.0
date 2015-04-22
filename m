From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: avoid abnormal behavior on broken symlink
Date: Wed, 22 Apr 2015 11:13:36 -0700
Message-ID: <20150422181336.GB82254@jaegeuk-mac02.mot.com>
References: <20150420144947.GA10518@mwanda>
	<20150421182045.GB66459@jaegeuk-mac02>
	<051e01d07cc5$9fb78370$df268a50$@samsung.com>
	<20150422102722.GK16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ykz9e-0000F4-Th
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 18:13:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ykz9d-0006US-A2 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 18:13:46 +0000
Content-Disposition: inline
In-Reply-To: <20150422102722.GK16501@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Apr 22, 2015 at 01:27:22PM +0300, Dan Carpenter wrote:
> On Wed, Apr 22, 2015 at 02:28:22PM +0800, Chao Yu wrote:
> > > > fs/f2fs/namei.c
> > > >    299  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
> > > >    300  {
> > > >    301          struct page *page;
> > > >    302
> > > >    303          page = page_follow_link_light(dentry, nd);
> > > >    304          if (IS_ERR(page))
> > > >                            ^^^^
> > > > The code in page_follow_link_light() is a bit hard to follow but it
> > > > returns NULL on error.
> > 
> > I try to find out the other callers' error handling method for
> > page_follow_link_light, and it shows all of them use the "IS_ERR" one.
> > 
> > In page_follow_link_light I also can't find a path which will return a NULL value.
> > 
> > So, Dan, is that report from smatch not true? or I made a mistake? If so, please
> > correct me.
> 
> Smatch is correct, it returns NULL on error.  However, I agree that it
> looks like it is supposed to return an ERR_PTR.  Every caller seems to
> expect that.

Well, at least, it seems vfs handles the error correctly.
The page_follow_link_light is used only by several filesystems.

And, follow_link is called by:

1. fs/namei.c <<follow_link>>
 -> No problem. It checks the error with nd->saved_names.

2. fs/namei.c <<generic_readlink>>
 -> No problem. The error is checked by readlink_copy.

Whatever it is expected or not, the fact is that there is no bug in vfs.
So at this moment, IMO, it needs to fix f2fs_follow_link by adding
IS_ERR_OR_NULL() to avoid all the cases (including the backporting effort).

As Chao mentioned, it seems that Al is going to fix that with new convention,
though. :)

Thanks,

> 
> I suspect the right fix is to change page_follow_link_light().  But I
> don't know this code very well so I just sent the bug report instead of
> fixing it myself.  :)
> 
> regards,
> dan carpenter
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index ffab2e0..5ca251e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4473,7 +4473,12 @@ EXPORT_SYMBOL(page_readlink);
>  void *page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
>  {
>  	struct page *page = NULL;
> -	nd_set_link(nd, page_getlink(dentry, &page));
> +	char *link;
> +
> +	link = page_getlink(dentry, &page);
> +	if (IS_ERR(link))
> +		return link;
> +	nd_set_link(nd, link);
>  	return page;
>  }
>  EXPORT_SYMBOL(page_follow_link_light);

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
