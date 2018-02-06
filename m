From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 0/2] f2fs: introduce lost+found feature
Date: Tue, 6 Feb 2018 12:31:16 +0800
Message-ID: <20180206043118.134137-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eiuv4-00009I-6a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:46 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiuv2-0004CL-RC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:46 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patchset introduces lost+found feature in f2fs. If the feature is
enabled, f2fs should avoid to encrypting root directory.

For more information, please check the mail "f2fs-tools: introduce lost+
found feature".

Thanks,
Sheng

Sheng Yong (2):
  f2fs: clean up f2fs_sb_has_xxx functions
  f2fs: introduce lost+found feature

 fs/f2fs/data.c    |  2 +-
 fs/f2fs/f2fs.h    | 53 +++++++++++++++--------------------------------------
 fs/f2fs/file.c    |  6 +++---
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/super.c   | 26 +++++++++++++++++++-------
 fs/f2fs/sysfs.c   |  4 ++--
 6 files changed, 42 insertions(+), 53 deletions(-)

-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
