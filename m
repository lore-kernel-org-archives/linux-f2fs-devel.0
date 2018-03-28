From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH] f2fs: reserve bits for fs-verity
Date: Wed, 28 Mar 2018 11:15:09 -0700
Message-ID: <20180328181509.199870-1-ebiggers@google.com>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f1G0G-0004vw-9d
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 18:40:56 +0000
Received: from mail-pg0-f68.google.com ([74.125.83.68])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f1G0C-00CKWa-PV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 18:40:56 +0000
Received: by mail-pg0-f68.google.com with SMTP id f10so1329519pgs.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Mar 2018 11:40:52 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Victor Hsieh <victorhsieh@google.com>, Eric Biggers <ebiggers@google.com>

Reserve an F2FS feature flag and inode flag for fs-verity.  This is an
in-development feature that is planned be discussed at LSF/MM 2018 [1].
It will provide file-based integrity and authenticity for read-only
files.  Most code will be in a filesystem-independent module, with
smaller changes needed to individual filesystems that opt-in to
supporting the feature.  An early prototype supporting F2FS is available
[2].  Reserving the F2FS on-disk bits for fs-verity will prevent users
of the prototype from conflicting with other new F2FS features.

Note that we're reserving the inode flag in f2fs_inode.i_advise, which
isn't really appropriate since it's not a hint or advice.  But
->i_advise is already being used to hold the 'encrypt' flag; and F2FS's
->i_flags uses the generic FS_* values, so it seems ->i_flags can't be
used for an F2FS-specific flag without additional work to remove the
assumption that ->i_flags uses the generic flags namespace.

[1] https://marc.info/?l=linux-fsdevel&m=151690752225644
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mhalcrow/linux.git/log/?h=fs-verity-dev

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/f2fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae69dc358401..96d7809c4541 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -146,6 +146,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
 #define F2FS_FEATURE_LOST_FOUND		0x0200
+#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -598,6 +599,7 @@ enum {
 #define FADVISE_ENC_NAME_BIT	0x08
 #define FADVISE_KEEP_SIZE_BIT	0x10
 #define FADVISE_HOT_BIT		0x20
+#define FADVISE_VERITY_BIT	0x40	/* reserved */
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
-- 
2.17.0.rc1.321.gba9d0f2565-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
