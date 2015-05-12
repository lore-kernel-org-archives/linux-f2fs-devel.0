From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs crypto: add symlink encryption
Date: Tue, 12 May 2015 11:39:32 -0700
Message-ID: <20150512183932.GA28387@jaegeuk-mac02>
References: <20150512120916.GA9471@mwanda>
	<20150512181716.GA27003@jaegeuk-mac02.mot.com>
	<20150512183621.GP16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YsF5i-0005xn-Aq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:39:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsF5h-0007Av-Gl for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:39:42 +0000
Content-Disposition: inline
In-Reply-To: <20150512183621.GP16501@mwanda>
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

On Tue, May 12, 2015 at 09:36:21PM +0300, Dan Carpenter wrote:
> On Tue, May 12, 2015 at 11:17:16AM -0700, Jaegeuk Kim wrote:
> > > For example, shouldn't we release f2fs_lock_op(sbi) when f2fs_add_link()
> > > fails earlier?
> > 
> > The pair of f2fs_lock_op and f2fs_unlock_op here is used to keep FS
> > consistency.
> > And, the handle_failed_inode() should be covered by f2fs_lock_op, so there is
> > no reason to do unlock and lock redundantly to handle the error case.
> 
> Yes, you are right, but the code is still not correct unfortunately.

Yeah, it was. Please check the V2 patch.

Thanks,

> 
> fs/f2fs/namei.c
>    424  
>    425          f2fs_lock_op(sbi);
>    426          err = f2fs_add_link(dentry, inode);
>    427          if (err)
>    428                  goto out;
>                         ^^^^^^^^
> Holding the lock.  This is correct as you say.
> 
>    429          f2fs_unlock_op(sbi);
>    430  
>    431          if (f2fs_encrypted_inode(dir)) {
>    432                  struct qstr istr = QSTR_INIT(symname, len);
>    433  
>    434                  err = f2fs_inherit_context(dir, inode, NULL);
>    435                  if (err)
>    436                          goto out;
>                                 ^^^^^^^^
> Not holding the lock.  This is a double unlock bug.
> 
>    437  
>    438                  err = f2fs_setup_fname_crypto(inode);
>    439                  if (err)
>    440                          goto out;
> 
> regards,
> dan carpenter

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
