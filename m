From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v4 0/3] f2fs: introduce
 F2FS_FEATURE_LOST_FOUND feature
Date: Fri, 9 Mar 2018 15:53:09 +0800
Message-ID: <20180309075312.62357-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1euCqR-0007xj-8b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 07:53:39 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euCqP-009nqj-Lx
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 07:53:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, ebiggers@google.com, tytso@mit.edu
Cc: linux-fscrypt@vger.kernel.org, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

v4->v3:
  * split f2fs patch into 2: one for LOST_FOUND feature, another for
    test_dummy_encryption
  * do not set enc_name if dir is not encrypted
  * do not allow mounting with test_dummy_encryption if encrypt feature
    is not set
v3->v2:
  * fix test_dummy_encryption
v2->v1:
  * introduce new mount option test_dummy_encryption
  * add sysfs entry for LOST_FOUND feature
---8<---

This patchset introduces LOST_FOUND feature in f2fs. If the feature is
enabled, f2fs should avoid to encrypt root directory.

A new mount option "test_dummy_encryption" is introduced, this is used by
xfstests.

Thanks,
Sheng

Sheng Yong (3):
  f2fs: introduce F2FS_FEATURE_LOST_FOUND feature
  f2fs: introduce a new mount option test_dummy_encryption
  ext4: do not allow mount with test_dummy_encryption if encrypt not set

 fs/ext4/super.c |  5 +++--
 fs/f2fs/dir.c   |  4 +++-
 fs/f2fs/f2fs.h  | 13 +++++++++++++
 fs/f2fs/namei.c |  9 ++++++---
 fs/f2fs/super.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c |  7 +++++++
 6 files changed, 75 insertions(+), 6 deletions(-)

-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
