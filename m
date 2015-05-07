From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs fix for v4.1-rc3
Date: Thu, 7 May 2015 11:09:22 -0700
Message-ID: <20150507180922.GA63437@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Please pull the following two patches for v4.1.

Thank you,

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.1-rc3

for you to fetch changes up to 7263b1bd0490fca68ee7eedb0b6973cb86d4701c:

  f2fs: fix wrong error hanlder in f2fs_follow_link (2015-05-04 14:15:16 -0700)

----------------------------------------------------------------
fix performance regression and bug

----------------------------------------------------------------
Jaegeuk Kim (2):
      Revert "f2fs: enhance multi-threads performance"
      f2fs: fix wrong error hanlder in f2fs_follow_link

 fs/f2fs/data.c  | 7 +++++++
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/namei.c | 8 +++-----
 fs/f2fs/super.c | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)
