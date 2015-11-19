From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs stability problems keep me from testing
Date: Thu, 19 Nov 2015 22:01:30 +0100
Message-ID: <20151119210130.GC2499@schmorp.de>
References: <20151119205614.GA10406@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZzWKq-0007Oj-3Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 21:01:40 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzWKn-0003CS-Do
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 21:01:40 +0000
Content-Disposition: inline
In-Reply-To: <20151119205614.GA10406@jaegeuk.local>
	<00a101d122a0$fb9e6ab0$f2db4010$@samsung.com>
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

On Thu, Nov 19, 2015 at 04:04:21PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> >    openat(AT_FDCWD, "/cold1", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 5
> >    fchdir(5)                               = 0
> >    getdents(5, /* 0 entries */, 32768)     = 0
> 
> I found an issue here.
> 
> If the dir entry of '/cold1/var' is removed from dentry page in '/cold1', at
> least we should return entries of '.' and '..' for the getdents invoking, but
> we didn't. So here it looks like we keep silent about some kind of error (i.e.
> ENOMEM/EIO...) when grabing&updating the dentry page of '/cold1', obviously
> it's better to report such error to user rather than ignoring it.

As for EIO, I would expect the kernel to log something. As for ENOMEM,
unless f2fs tries higher order or zone-specific allocations, that's
unlikely because the box had over 20GB memory free (according to top).

As for other errors, sure, could be.

Would that explain the sync lockup though?

> I'd like to send a patch to fix this issue, could you include the following
> patch in your f2fs module, so when it reproduces we can catch more details
> about this problem.

I can, but I guess you forgot to attach the patch.

On Fri, Nov 20, 2015 at 04:56:14AM +0800, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > Ah, sorry if that might not have been clear - after a reboot, fsck showed
> > no errors and all files and directories (apparently) were there, i.e. it
> > looks like a transient problem, not a problem of the on-disk structure.
> 
> So, it seems that the system suffers from memory pressure significantly, which
> can incur ENOMEM, as I guess.
> Can you catch /sys/kernel/debug/f2fs/status at that moment?

If I can, I will - I didn't attempt to stress the filesystem since then, but
will presdumably start doing tests next week again.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
