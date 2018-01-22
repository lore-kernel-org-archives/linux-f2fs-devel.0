From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH 0/3] f2fs: support passing down write hints to block layer
Date: Mon, 22 Jan 2018 19:49:06 +0900
Message-ID: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

This set implements passing down write hints to block layer with the
following mapping. This mapping equals the conclusion from discussion in
the link, https://sourceforge.net/p/linux-f2fs/mailman/message/36170969/

But there are two exceptions. (1) the 'iohint_mode' mount option is changed
to 'whint_mode'. (2) in "user-based" mode, WRITE_LIFE_EXTREME is passed
down instead of WRITE_LIFE_NOT_SET for files flagged with ioctl(COLD) and 
extension list.

Sorry for late patch.

1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.

2) whint_mode=user-based. F2FS tries to pass down hints given by
users.

User                  F2FS                     Block
----                  ----                     -----
                      META                     WRITE_LIFE_NOT_SET
                      HOT_NODE                 "
                      WARM_NODE                "
                      COLD_NODE                "
*ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
*extension list        "                        "

-- buffered io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        "
WRITE_LIFE_MEDIUM     "                        "
WRITE_LIFE_LONG       "                        "

-- direct io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG

3) whint_mode=fs-based. F2FS passes down hints with its policy.

User                  F2FS                     Block
----                  ----                     -----
                      META                     WRITE_LIFE_MEDIUM;
                      HOT_NODE                 WRITE_LIFE_NOT_SET
                      WARM_NODE                "
                      COLD_NODE                WRITE_LIFE_NONE
ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
extension list        "                        "

-- buffered io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
WRITE_LIFE_NONE       "                        "
WRITE_LIFE_MEDIUM     "                        "
WRITE_LIFE_LONG       "                        "

-- direct io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG

Hyunchul Lee (3):
  f2fs: support passing down write hints given by users to block layer
  f2fs: support passing down write hints to block layer with F2FS policy
  f2fs: Add the 'whint_mode' mount option to f2fs documentation

 Documentation/filesystems/f2fs.txt |   6 +++
 fs/f2fs/data.c                     |  27 ++++++++--
 fs/f2fs/f2fs.h                     |  10 ++++
 fs/f2fs/segment.c                  | 104 +++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    |  29 ++++++++++-
 5 files changed, 170 insertions(+), 6 deletions(-)

-- 
1.9.1
