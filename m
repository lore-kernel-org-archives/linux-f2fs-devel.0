From: Jin Qian <jinqian@android.com>
Subject: [f2fs-dev][PATCH 1/1] f2fs: sanity check size of nat and sit cache
Date: Thu, 1 Jun 2017 11:18:30 -0700
Message-ID: <CA+yUs=yynPLetzzZRCCkK3X1Ayej6NKV1k9R6jJhp3JybOQReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org, Jin Qian <jinqian@google.com>, jaegeuk@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Make sure number of entires doesn't exceed max journal size.

Cc: stable@vger.kernel.org
Signed-off-by: Jin Qian <jinqian@android.com>
---
 fs/f2fs/segment.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index de31030b5041..b07385630150 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2337,10 +2337,15 @@ static int read_compacted_summaries(struct
f2fs_sb_info *sbi)
        /* Step 1: restore nat cache */
        seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
        memcpy(seg_i->journal, kaddr, SUM_JOURNAL_SIZE);
+       if (nats_in_cursum(seg_i->journal) > NAT_JOURNAL_ENTRIES)
+               return -EINVAL;

        /* Step 2: restore sit cache */
        seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
        memcpy(seg_i->journal, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
+       if (sits_in_cursum(seg_i->journal) > SIT_JOURNAL_ENTRIES)
+               return -EINVAL;
+
        offset = 2 * SUM_JOURNAL_SIZE;

        /* Step 3: restore summary entries */
@@ -2431,6 +2436,12 @@ static int read_normal_summaries(struct
f2fs_sb_info *sbi, int type)
                                return err;
                        }
                }
+       } else {
+               if ((type == CURSEG_HOT_DATA &&
+                       nats_in_cursum(sum->journal) > NAT_JOURNAL_ENTRIES) ||
+                   (type == CURSEG_COLD_DATA &&
+                       sits_in_cursum(sum->journal) > SIT_JOURNAL_ENTRIES))
+               return -EINVAL;
        }

        /* set uncompleted segment to curseg */
-- 
2.13.0.506.g27d5fe0cd-goog
