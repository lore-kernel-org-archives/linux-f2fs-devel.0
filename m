From: Pavel Machek <pavel@ucw.cz>
Subject: f2fs tests
Date: Fri, 21 Jun 2013 21:36:00 +0200
Message-ID: <20130621193600.GA12712@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi!

I played a bit with f2fs...

First, I had to compile the f2fstools... Unfortunately they require
never autoconf than available on debian. I tried to hack it, but then
I decided that compiling it by hand is just simpler.

gcc -I include/ -I . lib/*.c mkfs/*.c /usr/lib/libuuid.so

does the trick.

I was quite surprised there's no fsck in the repository... Do you have
fsck somewhere?

I tested with copy of kernel and 4GB stick (with RedHat logo, thanks
:-)... copying it from hdd took 46 minutes for VFAT and 19 minutes for
F2FS. Good.

VFAT: time find . -name "not-here" took 26 seconds.
F2F:  time find . -name "not-here" took 22-24 seconds.

Faster copy, same speed find, good. (Find is even slightly faster than
HDD, with 27-30 seconds).

But now the strange stuff: the same data takes 861MB on ext3 and 1.3GB
on f2fs. (It was even bigger than that on VFAT). I guess I should test
the patch for inlining small files into inodes?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
