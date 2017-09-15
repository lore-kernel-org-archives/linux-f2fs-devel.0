From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for
 umount completion
Date: Fri, 15 Sep 2017 18:12:38 -0400
Message-ID: <20170915221238.js6elr5jmj4mgt67@thunk.org>
References: <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
 <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915042137.GX5426@ZenIV.linux.org.uk>
 <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <tytso@thunk.org>) id 1dsyr1-0005YJ-QE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Sep 2017 22:12:55 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dsyr0-0008Gm-5v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Sep 2017 22:12:55 +0000
Content-Disposition: inline
In-Reply-To: <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org

On Fri, Sep 15, 2017 at 11:44:33AM -0700, Jaegeuk Kim wrote:
> 
> So, I digged it in more detail, and found, in drivers/android/binder.c [1],
> - binder_ioctl()
>  - create a kernel thread
>  - zombie_cleanup_check()
>   - binder_defer_work()
>     - queue_work(..., &binder_deferred_work);
> 
> - binder_deferred_func()
>  - binder_clear_zombies()
>   - binder_proc_clear_zombies()
>    - put_files_struct()
>     - close_files()
>      - filp_close()
>       - fput()
> 
> It seems binder holds some proc files.

If binder was holding some files open, then umount should have failed
with EBUSY, no?

Does Android use mount namespaces at all?

					- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
