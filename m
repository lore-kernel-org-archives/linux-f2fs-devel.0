From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs bug fix for 4.8-rc4
Date: Tue, 23 Aug 2016 16:35:03 -0700
Message-ID: <20160823233503.GA78328@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bcLDt-00055S-0W
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 23:35:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcLDs-0006zE-10
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 23:35:12 +0000
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

Could you consider this pull request?

Thanks,

The following changes since commit 3408fef7448ce7d3c926978ee1a511e7707bffba:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-08-18 15:09:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-v4.8-rc4

for you to fetch changes up to 20a3d61d46e1fb45efa6eb4637c0dcd3f00a14e9:

  f2fs: avoid potential deadlock in f2fs_move_file_range (2016-08-19 11:15:08 +0900)

----------------------------------------------------------------
Bug/regression fix
- fsmark regression
- i_size race condition
- wrong conditions in f2fs_move_file_range

----------------------------------------------------------------
Chao Yu (3):
      Revert "f2fs: move i_size_write in f2fs_write_end"
      f2fs: allow copying file range only in between regular files
      f2fs: avoid potential deadlock in f2fs_move_file_range

Jaegeuk Kim (1):
      Revert "f2fs: use percpu_rw_semaphore"

 fs/f2fs/data.c  |  2 +-
 fs/f2fs/f2fs.h  | 12 ++++++------
 fs/f2fs/file.c  | 13 +++++++++----
 fs/f2fs/node.c  | 47 +++++++++++++++++++++++------------------------
 fs/f2fs/super.c |  6 +-----
 5 files changed, 40 insertions(+), 40 deletions(-)

------------------------------------------------------------------------------
