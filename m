From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs bug fix for 4.9-rc2
Date: Tue, 18 Oct 2016 13:19:28 -0700
Message-ID: <20161018201928.GA15491@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bwarM-0004qg-DY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 20:19:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bwarL-00008w-ET
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 20:19:40 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi Linus,

Could you please pull this bug fix patch?

Thanks,

The following changes since commit 4c1fad64eff481982349f5795b9c198c532b0f13:

  Merge tag 'for-f2fs-4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2016-10-06 15:30:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.9-rc2

for you to fetch changes up to de0dcc40f6e24d6bac6b60e36eac4659bbbd3f00:

  f2fs: fix wrong sum_page pointer in f2fs_gc (2016-10-12 16:23:36 -0700)

----------------------------------------------------------------
This includes fixing a bug which references a wrong pointer, sum_page, in
f2fs_gc. It was newly introduced in 4.9-rc1.

----------------------------------------------------------------
Jaegeuk Kim (1):
      f2fs: fix wrong sum_page pointer in f2fs_gc

 fs/f2fs/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
