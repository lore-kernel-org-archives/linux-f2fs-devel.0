From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH v2 0/2] fscrypt / f2fs: prepare I/O path for
 fs-verity
Date: Wed, 18 Apr 2018 11:09:46 -0700
Message-ID: <20180418180948.152031-1-ebiggers@google.com>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f8rZj-0003AH-DF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 18:12:59 +0000
Received: from mail-pl0-f48.google.com ([209.85.160.48])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f8rZh-00FpuZ-Tc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 18:12:59 +0000
Received: by mail-pl0-f48.google.com with SMTP id w21-v6so1593168plq.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Apr 2018 11:12:57 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Michael Halcrow <mhalcrow@google.com>, linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Victor Hsieh <victorhsieh@google.com>, Eric Biggers <ebiggers@google.com>

Hello,

These two patches restructure f2fs's read path to allow the data to go
through multiple postprocessing steps, rather than just decryption as is
implemented currently.  This is mainly in preparation for doing
authenticity verification of data via fs-verity, though this change
might also be useful for other future f2fs features, e.g. compression.

These patches don't yet add the fs-verity work, however, as it depends
on the rest of the fs-verity patchset.  I'm planning to send the full
patchset out as an RFC, but some parts need further investigation first.
(The work-in-progress version can be found at
 git://git.kernel.org/pub/scm/linux/kernel/git/mhalcrow/linux.git,
 branch "fs-verity-dev".)

Changed since v1:
	
	- Define NUM_PREALLOC_POST_READ_CTXS

Eric Biggers (2):
  fscrypt: allow synchronous bio decryption
  f2fs: refactor read path to allow multiple postprocessing steps

 fs/crypto/bio.c                 |  35 ++++---
 fs/crypto/crypto.c              |   8 +-
 fs/crypto/fscrypt_private.h     |   1 -
 fs/ext4/readpage.c              |   2 +-
 fs/f2fs/data.c                  | 166 ++++++++++++++++++++++++--------
 fs/f2fs/f2fs.h                  |  12 ++-
 fs/f2fs/file.c                  |   4 +-
 fs/f2fs/gc.c                    |   6 +-
 fs/f2fs/inline.c                |   2 +-
 fs/f2fs/super.c                 |   6 ++
 include/linux/fscrypt_notsupp.h |  13 ++-
 include/linux/fscrypt_supp.h    |   5 +-
 12 files changed, 191 insertions(+), 69 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
