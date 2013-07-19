From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [f2fs-dev] [PATCH] f2fs: update file name in the inode block
 during f2fs_rename
Date: Fri, 19 Jul 2013 08:49:37 +0100
Message-ID: <20130719074937.GD4165@ZenIV.linux.org.uk>
References: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
	<20130718092211.GA4165@ZenIV.linux.org.uk>
	<CAOtxgyetWtucBEQJmCU0nLNk9_r42yQSC1+X1i+iHM18rDge+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1V05Ri-0006fL-Pp
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Jul 2013 07:49:46 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V05Rg-0000vw-Sd
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Jul 2013 07:49:46 +0000
Content-Disposition: inline
In-Reply-To: <CAOtxgyetWtucBEQJmCU0nLNk9_r42yQSC1+X1i+iHM18rDge+Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim Jaegeuk <jaegeuk.kim@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Jul 19, 2013 at 12:40:47PM +0900, Kim Jaegeuk wrote:
> Hi,
> 
> 2013. 7. 18. ???? 6:22?? "Al Viro" <viro@zeniv.linux.org.uk>???? ????:
> >
> > On Thu, Jul 18, 2013 at 06:11:23PM +0900, Jaegeuk Kim wrote:
> > > The error is reproducible by:
> > >
> > > After this, when we retrieve the inode->i_name of test2 by dump.f2fs,
> we get
> > > test1 instead of test2.
> > > This is because f2fs didn't update the file name during the f2fs_rename.
> >
> > Er...  Correct me if I'm wrong, but f2fs appears to support link(2) and
> > if rename(2) creates some problem for dump.f2fs, I would expect an
> > equivalent link()+unlink() combination to do the same...
> 
> Right. I will check that too.
> Thank you. :)

You do realize that having unlink() hunt for the surviving links would be
both very costly and painful wrt locking, right?

The real question is, what are the warranties for that ->i_name thing?
What should it be while there are multiple links?  Matter of fact,
after looking at the users... What about ->i_pino in the same scenario
(link+unlink instead of rename)?

BTW, while looking at i_pino... Why does get_parent_ino() bother with
igrab/iput?  If you have found an alias, just use parent_ino(dentry)
and be done with that - as it is, you have a race with d_move() there,
so you'd need to reproduce parent_ino() locking anyway (->d_lock on
dentry holds d_move() away and stabilizes ->d_parent->d_inode)

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
