From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: avoid abnormal behavior on broken symlink
Date: Wed, 22 Apr 2015 22:19:59 +0300
Message-ID: <20150422191959.GT16501@mwanda>
References: <20150420144947.GA10518@mwanda>
	<20150421182045.GB66459@jaegeuk-mac02>
	<051e01d07cc5$9fb78370$df268a50$@samsung.com>
	<20150422102722.GK16501@mwanda>
	<20150422181336.GB82254@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Yl0C2-0000sj-EX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 19:20:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yl0By-0002M9-UQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Apr 2015 19:20:18 +0000
Content-Disposition: inline
In-Reply-To: <20150422181336.GB82254@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Apr 22, 2015 at 11:13:36AM -0700, Jaegeuk Kim wrote:
> On Wed, Apr 22, 2015 at 01:27:22PM +0300, Dan Carpenter wrote:
> > On Wed, Apr 22, 2015 at 02:28:22PM +0800, Chao Yu wrote:
> > > > > fs/f2fs/namei.c
> > > > >    299  static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
> > > > >    300  {
> > > > >    301          struct page *page;
> > > > >    302
> > > > >    303          page = page_follow_link_light(dentry, nd);
> > > > >    304          if (IS_ERR(page))
> > > > >                            ^^^^
> > > > > The code in page_follow_link_light() is a bit hard to follow but it
> > > > > returns NULL on error.
> > > 
> > > I try to find out the other callers' error handling method for
> > > page_follow_link_light, and it shows all of them use the "IS_ERR" one.
> > > 
> > > In page_follow_link_light I also can't find a path which will return a NULL value.
> > > 
> > > So, Dan, is that report from smatch not true? or I made a mistake? If so, please
> > > correct me.
> > 
> > Smatch is correct, it returns NULL on error.  However, I agree that it
> > looks like it is supposed to return an ERR_PTR.  Every caller seems to
> > expect that.
> 
> Well, at least, it seems vfs handles the error correctly.
> The page_follow_link_light is used only by several filesystems.
> 
> And, follow_link is called by:
> 
> 1. fs/namei.c <<follow_link>>
>  -> No problem. It checks the error with nd->saved_names.
> 
> 2. fs/namei.c <<generic_readlink>>
>  -> No problem. The error is checked by readlink_copy.

You're right.  My patch was wrong because it doesn't set
nd->saved_names.  But wow, though!  So convoluted!

  4423  /*
  4424   * A helper for ->readlink().  This should be used *ONLY* for symlinks that
  4425   * have ->follow_link() touching nd only in nd_set_link().  Using (or not
  4426   * using) it for any given inode is up to filesystem.
  4427   */
  4428  int generic_readlink(struct dentry *dentry, char __user *buffer, int buflen)
  4429  {
  4430          struct nameidata nd;
  4431          void *cookie;
  4432          int res;
  4433  
  4434          nd.depth = 0;
  4435          cookie = dentry->d_inode->i_op->follow_link(dentry, &nd);
  4436          if (IS_ERR(cookie))
  4437                  return PTR_ERR(cookie);

Even though we don't return here, the rest of the function is a no-op.

  4438  
  4439          res = readlink_copy(buffer, buflen, nd_get_link(&nd));
  4440          if (dentry->d_inode->i_op->put_link)
  4441                  dentry->d_inode->i_op->put_link(dentry, &nd, cookie);
  4442          return res;
  4443  }
  4444  EXPORT_SYMBOL(generic_readlink);

> 
> Whatever it is expected or not, the fact is that there is no bug in vfs.
> So at this moment, IMO, it needs to fix f2fs_follow_link by adding
> IS_ERR_OR_NULL() to avoid all the cases (including the backporting effort).
> 

I guess that works...  The follow_link() functions often seem to return
NULL on sucess.  But the page_follow_link_light() only returns NULL on
error.  It's very strange.

regards,
dan carpenter


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
