From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs crash when filling up small filesystem
Date: Mon, 28 Nov 2016 16:26:23 -0800
Message-ID: <20161129002623.GC4624@jaegeuk>
References: <20161127043954.GB34163@google.com> <20161128223052.GB4624@jaegeuk>
	<20161128234146.GB145516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cBWFk-0006DN-Os
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 00:26:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cBWFj-0002uF-U8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 00:26:32 +0000
Content-Disposition: inline
In-Reply-To: <20161128234146.GB145516@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

On Mon, Nov 28, 2016 at 03:41:46PM -0800, Eric Biggers wrote:
> On Mon, Nov 28, 2016 at 02:30:52PM -0800, Jaegeuk Kim wrote:
> > Thanks Eric.
> > 
> > It seems 32MB was too small, so that mkfs.f2fs couldn't get overprovision space
> > which will be used for GC at runtime.
> > I attached a patch to resolve this issue.
> > 
> 
> Hi Jaegeuk,
> 
> The patch seems effective at preventing mkfs.f2fs from a filesystem that's too
> small, but shouldn't there also be a kernel patch to make the kernel robust if
> userspace nevertheless attempts to mount a too-small filesystem?

Yup, I'll take a look at that as well. ;)

> By the way, I included the test which encounters this problem in the encryption
> xfstests patches which I Cc'ed to you --- it's generic/403 ("generic: test for
> weaknesses in filesystem encryption").  If f2fs doesn't support a 32 MB
> filesystem then I'll need to bump up the filesystem size to 64 MB, or disable
> the test on f2fs.  Or maybe people will say the test is too weird and should
> just be deleted, but I think it's an important test :P

Oh, could you please increase the partition size to 64MB? It seems 64MB or even
128MB would not be a big deal, IIUC.

BTW, thank you so much for writing these patches. ;)

> 
> Eric

------------------------------------------------------------------------------
