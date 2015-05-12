From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs crypto: add symlink encryption
Date: Tue, 12 May 2015 21:36:21 +0300
Message-ID: <20150512183621.GP16501@mwanda>
References: <20150512120916.GA9471@mwanda>
	<20150512181716.GA27003@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1YsF2o-00079T-3O
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:36:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YsF2n-0003DD-CK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:36:42 +0000
Content-Disposition: inline
In-Reply-To: <20150512181716.GA27003@jaegeuk-mac02.mot.com>
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

On Tue, May 12, 2015 at 11:17:16AM -0700, Jaegeuk Kim wrote:
> > For example, shouldn't we release f2fs_lock_op(sbi) when f2fs_add_link()
> > fails earlier?
> 
> The pair of f2fs_lock_op and f2fs_unlock_op here is used to keep FS
> consistency.
> And, the handle_failed_inode() should be covered by f2fs_lock_op, so there is
> no reason to do unlock and lock redundantly to handle the error case.

Yes, you are right, but the code is still not correct unfortunately.

fs/f2fs/namei.c
   424  
   425          f2fs_lock_op(sbi);
   426          err = f2fs_add_link(dentry, inode);
   427          if (err)
   428                  goto out;
                        ^^^^^^^^
Holding the lock.  This is correct as you say.

   429          f2fs_unlock_op(sbi);
   430  
   431          if (f2fs_encrypted_inode(dir)) {
   432                  struct qstr istr = QSTR_INIT(symname, len);
   433  
   434                  err = f2fs_inherit_context(dir, inode, NULL);
   435                  if (err)
   436                          goto out;
                                ^^^^^^^^
Not holding the lock.  This is a double unlock bug.

   437  
   438                  err = f2fs_setup_fname_crypto(inode);
   439                  if (err)
   440                          goto out;

regards,
dan carpenter


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
