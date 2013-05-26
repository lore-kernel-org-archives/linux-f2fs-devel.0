From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [f2fs-dev] [patch] f2fs: dereferencing an ERR_PTR
Date: Sun, 26 May 2013 23:41:16 +0300
Message-ID: <20130526204116.GE23932@mwanda>
References: <20130523100213.GA19107@elgon.mountain> <51A224AB.8010209@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ughl5-0007pi-1s
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 20:41:39 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ughl4-0008Ax-5e
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 20:41:39 +0000
Content-Disposition: inline
In-Reply-To: <51A224AB.8010209@bfs.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: walter harms <wharms@bfs.de>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sun, May 26, 2013 at 05:05:15PM +0200, walter harms wrote:
> 
> 
> Am 23.05.2013 12:02, schrieb Dan Carpenter:
> > There is an error path where "dir" is an ERR_PTR.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 5148d90..921aede 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -71,7 +71,8 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
> >  out:
> >  	f2fs_msg(inode->i_sb, KERN_NOTICE, "recover_inode and its dentry: "
> >  			"ino = %x, name = %s, dir = %lx, err = %d",
> > -			ino_of_node(ipage), raw_inode->i_name, dir->i_ino, err);
> > +			ino_of_node(ipage), raw_inode->i_name,
> > +			IS_ERR(dir) ? 0 : dir->i_ino, err);
> >  	return err;
> >  }
> >  
> I am not an expert on  this matter so a simple question:
> dir->i_ino==0 is not valid ?

That is a valid question.  The trick is that we also print the err
code so error conditions should be pretty obvious.

regards,
dan carpenter


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
