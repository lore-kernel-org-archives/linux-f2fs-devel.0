From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [RFC PATCH 0/2] apply write hints to select the type of segments
Date: Thu,  9 Nov 2017 14:51:26 +0900
Message-ID: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Using write hints[1], applications can inform the life time of the data
written to devices. and this[2] reported that the write hints patch
decreased writes in NAND by 25%.

This hints help F2FS to determine the followings.
  1) the segment types where the data will be written.
  2) the hints that will be passed down to devices with the data of segments.

This patch set implements the first mapping from write hints to segment types
as shown below.

  hints                     segment type
  -----                     ------------
  WRITE_LIFE_SHORT          CURSEG_COLD_DATA
  WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
  others                    CURSEG_WARM_DATA

The F2FS poliy for hot/cold seperation has precedence over this hints, And
hints are not applied in in-place update.

Before the second mapping is implemented, write hints are not passed down
to devices. Because it is better that the data of a segment have the same 
hint.

[1]: c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
[2]: https://lwn.net/Articles/726477/

Hyunchul Lee (2):
  f2fs: apply write hints to select the type of segments for buffered
    write
  f2fs: apply write hints to select the type of segment for direct write

 fs/f2fs/data.c    | 101 ++++++++++++++++++++++++++++++++----------------------
 fs/f2fs/f2fs.h    |   1 +
 fs/f2fs/segment.c |  14 +++++++-
 3 files changed, 74 insertions(+), 42 deletions(-)

-- 
1.9.1
