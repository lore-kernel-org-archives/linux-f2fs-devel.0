From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs fix for 4.11-rc4
Date: Mon, 20 Mar 2017 13:30:19 -0400
Message-ID: <20170320173019.GA53763@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cq18Z-0007bv-VF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 17:30:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cq18X-0007uP-Sl
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 17:30:31 +0000
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

Could you please pull the below fixes?

Thanks,

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.11-rc4

for you to fetch changes up to 7041d5d286fb54635f540c1bb3b43980ed65513a:

  f2fs: combine nat_bits and free_nid_bitmap cache (2017-03-20 10:00:18 -0400)

----------------------------------------------------------------
Bug fix for f2fs

- Fix performance regression reported by lkp-rebot
- Fix potential data lost after power-cut due to SSR reallocation

----------------------------------------------------------------
Chao Yu (2):
      f2fs: skip scanning free nid bitmap of full NAT blocks
      f2fs: combine nat_bits and free_nid_bitmap cache

Jaegeuk Kim (3):
      f2fs: don't overwrite node block by SSR
      f2fs: declare static functions
      f2fs: use __set{__clear}_bit_le

 fs/f2fs/debug.c   |   1 +
 fs/f2fs/dir.c     |   2 +-
 fs/f2fs/f2fs.h    |   2 +
 fs/f2fs/node.c    | 163 ++++++++++++++++++++++++++----------------------------
 fs/f2fs/segment.c |   6 ++
 5 files changed, 87 insertions(+), 87 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
