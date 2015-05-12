From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs crypto: add symlink encryption
Date: Tue, 12 May 2015 15:09:17 +0300
Message-ID: <20150512120916.GA9471@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ys90B-0007mL-7I
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 12:09:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ys90A-0005YA-DB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 12:09:35 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Jaegeuk Kim,

The patch 24d584edddca: "f2fs crypto: add symlink encryption" from
Apr 29, 2015, leads to the following static checker warning:

	fs/f2fs/namei.c:487 f2fs_symlink()
	warn: calling kfree() when 'sd' is always NULL.

fs/f2fs/namei.c
   484          f2fs_fname_crypto_free_buffer(&disk_link);
   485          return err;
   486  out:
   487          kfree(sd);
                ^^^^^^^^^
Freeing a NULL pointer is harmless but I have a static checker warning
for it because it can indicate confusion or typos.

   488          f2fs_fname_crypto_free_buffer(&disk_link);
   489          handle_failed_inode(inode);
   490          return err;
   491  }

"out" labels are bad.

The name is meaningless.  If it says "goto free_sd;" that's useful and
you know what it does without scrolling down and losing your place.
But with out: labels you can't know.

Sometimes out labels do nothing.

	out:
		return err;

These are supposed to prevent return with lock held bugs etc, but if you
look through the git log it has historically not been effective.  It
also introduces "forgot to set the error code" bugs.

Sometime it does everything like in this case and that's very bug prone.
For example, shouldn't we release f2fs_lock_op(sbi) when f2fs_add_link()
fails earlier?

Sometimes it does one thing which is good, but the name is just lazy.

-out:
+unlock:
	mutext_unlock();
	return err;

Btw shouldn't we earlier if page_symlink() fails?

regards,
dan carpenter


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
