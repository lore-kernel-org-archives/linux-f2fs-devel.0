From: Eric Biggers <ebiggers@google.com>
Subject: Re: f2fs crash when filling up small filesystem
Date: Mon, 5 Dec 2016 11:30:28 -0800
Message-ID: <20161205193028.GA92618@google.com>
References: <20161127043954.GB34163@google.com> <20161128223052.GB4624@jaegeuk>
	<20161128234146.GB145516@google.com>
	<20161129002623.GC4624@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers@google.com>) id 1cDyyE-0005IA-7T
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:30:38 +0000
Received: from mail-pg0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cDyyD-0003mF-8G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:30:38 +0000
Received: by mail-pg0-f47.google.com with SMTP id p66so139812282pga.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 05 Dec 2016 11:30:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161129002623.GC4624@jaegeuk>
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

On Mon, Nov 28, 2016 at 04:26:23PM -0800, Jaegeuk Kim wrote:
> 
> > By the way, I included the test which encounters this problem in the encryption
> > xfstests patches which I Cc'ed to you --- it's generic/403 ("generic: test for
> > weaknesses in filesystem encryption").  If f2fs doesn't support a 32 MB
> > filesystem then I'll need to bump up the filesystem size to 64 MB, or disable
> > the test on f2fs.  Or maybe people will say the test is too weird and should
> > just be deleted, but I think it's an important test :P
> 
> Oh, could you please increase the partition size to 64MB? It seems 64MB or even
> 128MB would not be a big deal, IIUC.
> 

Well, smaller is better since the test compresses the whole filesystem with xz.
But I was able to tweak the xz parameters and make a size of 64 MB work, so now
the test passes on f2fs.

Eric

------------------------------------------------------------------------------
