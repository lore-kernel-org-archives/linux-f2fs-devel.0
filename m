From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs_io: add gc_urgent
Date: Wed, 20 Feb 2019 09:07:45 -0800
Message-ID: <20190220170745.7328-4-jaegeuk@kernel.org>
References: <20190220170745.7328-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gwVLh-0006kP-9Y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 17:07:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwVLf-00380G-O0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 17:07:57 +0000
In-Reply-To: <20190220170745.7328-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

e.g.,
f2fs_io gc_urgent dm-4 [start/end/run] [time in sec]

This controls sysfs/gc_urgent to run f2fs_gc urgently.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 70fde6e..cb28ff8 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -359,6 +359,40 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define gc_urgent_desc "start/end/run gc_urgent for given time period"
+#define gc_urgent_help					\
+"f2fs_io gc_urgent $dev [start/end/run] [time in sec]\n\n"\
+" - f2fs_io gc_urgent sda21 start\n"		\
+" - f2fs_io gc_urgent sda21 end\n"		\
+" - f2fs_io gc_urgent sda21 run 10\n"		\
+
+static void do_gc_urgent(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	char command[255];
+
+	if (argc == 3 && !strcmp(argv[2], "start")) {
+		printf("gc_urgent: start on %s\n", argv[1]);
+		sprintf(command, "echo %d > %s/%s/gc_urgent", 1, "/sys/fs/f2fs/", argv[1]);
+		system(command);
+	} else if (argc == 3 && !strcmp(argv[2], "end")) {
+		printf("gc_urgent: end on %s\n", argv[1]);
+		sprintf(command, "echo %d > %s/%s/gc_urgent", 0, "/sys/fs/f2fs/", argv[1]);
+		system(command);
+	} else if (argc == 4 && !strcmp(argv[2], "run")) {
+		printf("gc_urgent: start on %s for %d secs\n", argv[1], atoi(argv[3]));
+		sprintf(command, "echo %d > %s/%s/gc_urgent", 1, "/sys/fs/f2fs/", argv[1]);
+		system(command);
+		sleep(atoi(argv[3]));
+		printf("gc_urgent: end on %s for %d secs\n", argv[1], atoi(argv[3]));
+		sprintf(command, "echo %d > %s/%s/gc_urgent", 0, "/sys/fs/f2fs/", argv[1]);
+		system(command);
+	} else {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -371,6 +405,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(write),
 	CMD(read),
 	CMD(fiemap),
+	CMD(gc_urgent),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.19.0.605.g01d371f741-goog
