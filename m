From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for
 umount completion
Date: Wed, 13 Sep 2017 18:10:48 -0700
Message-ID: <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170913230426.GN5426@ZenIV.linux.org.uk>
 <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
 <20170913234437.GO5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dsIgB-0000Su-4r
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Sep 2017 01:10:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dsIgA-00074l-9b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Sep 2017 01:10:55 +0000
Content-Disposition: inline
In-Reply-To: <20170913234437.GO5426@ZenIV.linux.org.uk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 09/14, Al Viro wrote:
> On Wed, Sep 13, 2017 at 04:31:16PM -0700, Jaegeuk Kim wrote:
> > Hi Al,
> > 
> > On 09/14, Al Viro wrote:
> > > On Wed, Sep 13, 2017 at 01:09:41PM -0700, Jaegeuk Kim wrote:
> > > > +	if (!retval && (flags & UMOUNT_WAIT)) {
> > > > +		if (likely(!(current->flags & PF_KTHREAD)))
> > > > +			task_work_run();
> > > 
> > > This is complete crap.  The same damn thing will be done by
> > > caller of sys_umount() pretty much immediately afterwards.
> > > I'm not sure what it is that you are trying to paper over,
> > > but this is just plain wrong.
> > 
> > Okay.
> > 
> > > What _is_ the semantics of UMOUNT_WAIT?  What does it guarantee,
> > > and what would be supplying it to umount(2)?
> > 
> > When android tries to reboot the system, it calls umount(2) without any flag.
> > Then, mntput_no_expire() will add delayed_mntput_work() which finally does
> > cleanup_mnt() later. In the mean time, android proceeded to shutdown all
> > the UFS devices.
> 
> Why has task_work_add() failed?  Or is that umount(2) issued by a kernel thread?

Android triggers umount(2) by init process, which is definitely not a kernel
thread. But, we've seen some kernel panics which say umount(2) was succeeded,
but ext4 triggered a kernel panic due to EIO after then like below. I'm also
not sure task_work_run() would be also safe enoughly. May I ask where I can
find sys_umount() calls task_work_run()?

[254012.860565] c4  12426 [<ffffff909b6a7ebc>] panic+0x184/0x37c
[254012.860589] c4  12426 [<ffffff909b88e724>] __ext4_abort+0x198/0x19c
[254012.860606] c4  12426 [<ffffff909b897468>] ext4_put_super+0x80/0x2b4
[254012.860629] c4  12426 [<ffffff909b7e7274>] generic_shutdown_super+0x68/0xd0
[254012.860646] c4  12426 [<ffffff909b7e87fc>] kill_block_super+0x1c/0x5c
[254012.860663] c4  12426 [<ffffff909b7e70dc>] deactivate_locked_super+0x5c/0xc0
[254012.860679] c4  12426 [<ffffff909b7e71a8>] deactivate_super+0x68/0x74
[254012.860696] c4  12426 [<ffffff909b80a25c>] cleanup_mnt+0xb0/0x12c
[254012.860712] c4  12426 [<ffffff909b80a310>] delayed_mntput+0x38/0x4c
[254012.860737] c4  12426 [<ffffff909b6c6524>] process_one_work+0x1e0/0x490
[254012.860753] c4  12426 [<ffffff909b6c6094>] worker_thread+0x314/0x494
[254012.860771] c4  12426 [<ffffff909b6cb35c>] kthread+0xdc/0xec
[254012.860790] c4  12426 [<ffffff909b683860>] ret_from_fork+0x10/0x30

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
