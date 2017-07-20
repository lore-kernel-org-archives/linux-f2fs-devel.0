From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs: update for 4.13-rc2
Date: Wed, 19 Jul 2017 20:18:46 -0700
Message-ID: <20170720031846.GA72919@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Linus,

Could you please pull this request?

Thanks,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-v4.13-rc2

for you to fetch changes up to 4db08d016ccedb5b97869724a096990acad59685:

  f2fs: avoid cpu lockup (2017-07-17 19:23:18 -0700)

----------------------------------------------------------------
for-f2fs-v4.13-rc2

We've filed some bug fixes:
- missing f2fs case in terms of stale SGID big, introduced by Jan
- build error for seq_file.h
- avoid cpu lockup
- wrong inode_unlock in error case

----------------------------------------------------------------
Jaegeuk Kim (3):
      f2fs: Don't clear SGID when inheriting ACLs
      f2fs: include seq_file.h for sysfs.c
      f2fs: avoid cpu lockup

Luis Henriques (1):
      f2fs: remove extra inode_unlock() in error path

 fs/f2fs/acl.c        |  2 +-
 fs/f2fs/checkpoint.c | 10 ++++++++++
 fs/f2fs/file.c       |  5 +----
 fs/f2fs/sysfs.c      |  1 +
 4 files changed, 13 insertions(+), 5 deletions(-)
