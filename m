From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] f2fs and fscrypto bug fixes for 4.6-rc4
Date: Thu, 14 Apr 2016 13:50:07 -0700
Message-ID: <20160414205007.GA28828@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aqoDQ-0006Yv-Ab
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Apr 2016 20:50:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aqoDP-0000oP-A3
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Apr 2016 20:50:16 +0000
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

Could you please pull these patches which were missing in -rc3?
In addition to f2fs/fscrypto fixes, I've added one patch which prevents RCU
mode lookup in d_revalidate, as Al mentioned.

Thanks,

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-linus-4.6-rc4

for you to fetch changes up to 03a8bb0e53d9562276045bdfcf2b5de2e4cff5a1:

  ext4/fscrypto: avoid RCU lookup in d_revalidate (2016-04-12 20:01:35 -0700)

----------------------------------------------------------------
for-linus-4.6-rc4

These patches fix f2fs and fscrypto based on -rc3 bug fixes in ext4 crypto,
which have not yet been fully propagated as follows.
 - use of dget_parent and file_dentry to avoid crashes
 - disallow RCU-mode lookup in d_invalidate
 - disallow -ENOMEM in the core data encryption path

----------------------------------------------------------------
Jaegeuk Kim (4):
      fscrypto: use dget_parent() in fscrypt_d_revalidate()
      f2fs: use dget_parent and file_dentry in f2fs_file_open
      fscrypto: don't let data integrity writebacks fail with ENOMEM
      ext4/fscrypto: avoid RCU lookup in d_revalidate

 fs/crypto/crypto.c       | 51 ++++++++++++++++++++++++++++++------------------
 fs/ext4/crypto.c         |  4 ++++
 fs/f2fs/data.c           | 16 ++++++++++++---
 fs/f2fs/file.c           | 10 +++++++---
 include/linux/fscrypto.h |  9 +++++----
 5 files changed, 61 insertions(+), 29 deletions(-)

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
