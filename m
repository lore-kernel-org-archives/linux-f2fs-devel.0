From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 16:55:35 -0400
Message-ID: <20160326205535.GE4539@thunk.org>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
	<CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
	<20160321184520.GA8199@jaegeuk.gateway>
	<20160326061007.GA24620@zzz>
	<20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
	<20160326134748.GA971@zzz>
	<CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
	<20160326204125.GD4539@thunk.org>
	<CA+55aFyh6Kjnb+=M5b-V7zY9nakzGfNyNwJf4VZHeQ5cOQRmKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1ajvFL-0005G1-Ih
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 20:55:47 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ajvFI-0004lV-CC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 20:55:47 +0000
Content-Disposition: inline
In-Reply-To: <CA+55aFyh6Kjnb+=M5b-V7zY9nakzGfNyNwJf4VZHeQ5cOQRmKw@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>, Michael Halcrow <mhalcrow@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>

On Sat, Mar 26, 2016 at 01:48:23PM -0700, Linus Torvalds wrote:
> > BTW, as far as switching ext4 to use the shared code in fs/crypto ---
> > I'm hoping to get that done for the next merge window.  There are a 2
> > or 3 patches to fix some recently discovered bugs that I'll need to
> > push into the fs/crypto code, but I'll take care of that for the next
> > development cycle.
> 
> No worries. Considering this mistake (which happily seems to have an
> innocent explanation for it) it would be good to have it verified that
> the shared code does actually work for you, so that we don't end up in
> the unhappy situation that the code got split up in order to be
> shared, but some random detail choice then made it not actually work
> for ext4 after all..

Oh, for sure.  One of the things I plan to do is to make sure that a
file system created using the *current* ext4 encryption code is
properly readable using the new fs/crypto code.  I'll also run a full
regression test run using xfstests as well.

That's one of the reasons why I wasn't going to even try to get it
done for this merge window (even if you weren't going to be closing
the merge window tomorrow).  I just didn't have the time to do a good
job, and it made sense to let the f2fs code go in first, and then
convert ext4 afterwards.

						- Ted

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
