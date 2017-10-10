From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs fix for v4.14-rc5
Date: Tue, 10 Oct 2017 10:31:48 -0700
Message-ID: <20171010173148.GB6455@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull this quick bug fix?

Thanks,

The following changes since commit e365806ac289457263a133bd32df8df49897f612:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2017-09-25 18:24:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.14-rc5

for you to fetch changes up to 638164a2718f337ea224b747cf5977ef143166a4:

  f2fs: fix potential panic during fstrim (2017-10-03 08:06:05 -0700)

----------------------------------------------------------------
f2fs-for-4.14-rc5

This contains one bug fix which causes a kernel panic during fstrim introduced
in 4.14-rc1.

----------------------------------------------------------------
Chao Yu (1):
      f2fs: fix potential panic during fstrim

 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/segment.c | 6 +++---
 fs/f2fs/super.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
