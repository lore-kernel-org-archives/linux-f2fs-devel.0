From: Colin King <colin.king@canonical.com>
Subject: [PATCH] f2fs: fix spelling mistake: "extenstion" -> "extension"
Date: Mon, 30 Apr 2018 16:27:44 +0100
Message-ID: <20180430152744.9927-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in extension list text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/f2fs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f33a56d6e6dd..d9050caff80c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -147,13 +147,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		int len = 0, i;
 
 		len += snprintf(buf + len, PAGE_SIZE - len,
-						"cold file extenstion:\n");
+						"cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
 			len += snprintf(buf + len, PAGE_SIZE - len, "%s\n",
 								extlist[i]);
 
 		len += snprintf(buf + len, PAGE_SIZE - len,
-						"hot file extenstion:\n");
+						"hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
 			len += snprintf(buf + len, PAGE_SIZE - len, "%s\n",
 								extlist[i]);
-- 
2.17.0
