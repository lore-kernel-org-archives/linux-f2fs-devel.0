From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs urgent fix
Date: Mon, 27 Jul 2015 17:04:49 -0700
Message-ID: <20150728000449.GA53271@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull the following bug-fix patches?

Thanks,

The following changes since commit 33b40178cb3bd75294d1a758b3f509a0d38682ab:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2015-07-24 17:00:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-v4.2-rc5

for you to fetch changes up to 6282adbf932c226f76e1b83e074448c79976fe75:

  f2fs: call set_page_dirty to attach i_wb for cgroup (2015-07-25 08:54:26 -0700)

----------------------------------------------------------------
Jaegeuk Kim (2):
      f2fs: handle error cases in move_encrypted_block
      f2fs: call set_page_dirty to attach i_wb for cgroup

 fs/f2fs/data.c    |  2 --
 fs/f2fs/file.c    |  7 ++++---
 fs/f2fs/gc.c      | 30 +++++++++++++++++++++---------
 fs/f2fs/inline.c  |  2 ++
 fs/f2fs/segment.c |  1 +
 5 files changed, 28 insertions(+), 14 deletions(-)
