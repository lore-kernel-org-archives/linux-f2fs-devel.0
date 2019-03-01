From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 0/8] add generic interface to set/get project
Date: Fri,  1 Mar 2019 23:05:33 +0900
Message-ID: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzinX-0000nL-1J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:05:59 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzinU-006NOR-SO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:05:58 +0000
Received: by mail-pf1-f195.google.com with SMTP id d25so11480787pfn.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:05:56 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, lixi@ddn.com, Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

Currently, Filesystem use FS_IOC_FS_SETXATTR ioctl
to change project ID of file. However we don't
support ioctl on symlink files, and it is desirable
to change symlink files' project ID just like uid/gid.

This patch try to reuse existed interface fchownat(),
use group id to set project ID if flag AT_FCHOWN_PROJID
passed in.

Also extend statx() calles to get symlink files' project
ID and inherit attribute.

Wang Shilong (8):
  fs: add support to change project ID
  ext4: support project ID in ext4_setattr()
  f2fs: support project ID in f2fs_setattr()
  xfs: support project ID in xfs_setattr()
  fs: add project support to statx
  ext4: support project in ext4_getattr()
  f2fs: support project in f2fs_getattr()
  xfs: support project in xfs_getattr()

 fs/attr.c                        | 26 +++++++++++++--
 fs/ext4/inode.c                  | 15 +++++++--
 fs/f2fs/file.c                   | 12 +++++--
 fs/open.c                        | 29 +++++++++++++----
 fs/quota/dquot.c                 | 23 ++++++++++++++
 fs/stat.c                        |  1 +
 fs/xfs/xfs_iops.c                | 54 ++++++++++++++++++++++++++------
 fs/xfs/xfs_linux.h               | 10 ++++++
 include/linux/fs.h               |  3 ++
 include/linux/quotaops.h         |  9 ++++++
 include/linux/stat.h             |  2 ++
 include/uapi/linux/fcntl.h       |  1 +
 include/uapi/linux/stat.h        |  8 +++--
 tools/include/uapi/linux/fcntl.h |  1 +
 tools/include/uapi/linux/stat.h  |  8 +++--
 15 files changed, 175 insertions(+), 27 deletions(-)

-- 
2.19.1
