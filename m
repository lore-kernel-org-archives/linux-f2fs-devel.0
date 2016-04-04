From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs fixes for v4.6-rc3
Date: Sun, 3 Apr 2016 22:21:10 -0700
Message-ID: <20160404052110.GB80122@jaegeuk.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull the below commits for v4.6-rc3?

Thanks,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-linus

for you to fetch changes up to b2dde6fca37e947628b82ae8f35e183ff112d07c:

  f2fs: retrieve IO write stat from the right place (2016-03-30 13:21:16 -0700)

----------------------------------------------------------------
Jaegeuk Kim (2):
      f2fs: cover large section in sanity check of super
      f2fs crypto: fix corrupted symlink in encrypted case

Shuoran Liu (1):
      f2fs: retrieve IO write stat from the right place

 fs/f2fs/namei.c |  12 +++----
 fs/f2fs/super.c | 104 +++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 72 insertions(+), 44 deletions(-)
