From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to detect temporary name of multimedia file
Date: Mon, 5 Sep 2016 12:28:27 +0800
Message-ID: <20160905042827.114632-2-yuchao0@huawei.com>
References: <20160905042827.114632-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160905042827.114632-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Some applications may create multimeida file with temporary name like
'*.jpg.tmp' or '*.mp4.tmp', then rename to '*.jpg' or '*.mp4'.

Now, f2fs can only detect multimedia filename with specified format:
"filename + '.' + extension", so it will make f2fs missing to detect
multimedia file with special temporary name, result in failing to set
cold flag on file.

This patch enhances detection flow for enabling lookup extension in the
middle of temporary filename.

Reported-by: Xue Liu <liuxueliu.liu@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 73fa356..bfcd9da 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -91,18 +91,23 @@ static int is_multimedia_file(const unsigned char *s, const char *sub)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
+	int i;
 
 	/*
 	 * filename format of multimedia file should be defined as:
-	 * "filename + '.' + extension".
+	 * "filename + '.' + extension + (optional: '.' + temp extension)".
 	 */
 	if (slen < sublen + 2)
 		return 0;
 
-	if (s[slen - sublen - 1] != '.')
-		return 0;
+	for (i = 1; i < slen - sublen; i++) {
+		if (s[i] != '.')
+			continue;
+		if (!strncasecmp(s + i + 1, sub, sublen))
+			return 1;
+	}
 
-	return !strncasecmp(s + slen - sublen, sub, sublen);
+	return 0;
 }
 
 /*
-- 
2.8.2.311.gee88674
