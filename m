From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] F2FS support
Date: Thu, 4 May 2017 22:52:09 +0200
Message-ID: <20170504205208.6vpuvtnb47afcnbb@angband.pl>
References: <20170504181240.7923-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kilobyte@angband.pl>) id 1d6O0t-0002eW-KT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 21:10:15 +0000
Received: from tartarus.angband.pl ([89.206.35.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d6O0s-0005Zd-3A
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 21:10:15 +0000
Content-Disposition: inline
In-Reply-To: <20170504181240.7923-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: grub-devel@gnu.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, May 04, 2017 at 11:12:40AM -0700, Jaegeuk Kim wrote:
> "F2FS (Flash-Friendly File System) is flash-friendly file system which was merged
> into Linux kernel v3.8 in 2013.
> 
> The motive for F2FS was to build a file system that from the start, takes into
> account the characteristics of NAND flash memory-based storage devices (such as
> solid-state disks, eMMC, and SD cards).

Some reason "why?" would be nice.

Here's a rough comparison, class 4 SD card on a Pine64, median of 5:
* "git reset --hard" in a big empty tree:
  btrfs 3m45s, f2fs 4m, ext4 12m, xfs 16-18m (huge variance)
* "./configure && make -j4 && make test" (highly CPU-bound)
  f2fs 95s, btrfs 97s, xfs 120s, ext4 122s
* linear write of a single big file
  no meaningful differences

Ie, there's a drastic gain for using f2fs or btrfs.  But btrfs is... well,
btrfs.  It has both significant data safety features and "WTF" level caveats
that can result in abysmal performance, unexpected lack of space or even
data loss when handled by a naive user in ways that are perfectly safe for
most other filesystems.  Thus, it'd be irresponsible to unleash btrfs onto
an unprepared user.  Which leaves f2fs which works well with "install and
forget".

And there's a bunch of new machines that boot from SD/eMMC even on x86.


Meow!
-- 
Don't be racist.  White, amber or black, all beers should be judged based
solely on their merits.  Heck, even if occasionally a cider applies for a
beer's job, why not?
On the other hand, corpo lager is not a race.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
