From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 5/5] f2fs: add proc entry to show victim_secmap
 bitmap
Date: Mon, 23 Jul 2018 22:10:22 +0800
Message-ID: <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1fhbYG-0004xi-At
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Jul 2018 14:11:04 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fhbYD-009ors-II
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Jul 2018 14:11:04 +0000
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

This patch adds a new proc entry to show victim_secmap information in
more detail, which is very helpful to know the get_victim candidate
status clearly, and helpful to debug problems (e.g., some sections can
not gc all of its blocks, since some blocks belong to atomic file,
leaving victim_secmap with section bit setting, in extrem case, this
will lead all bytes of victim_secmap setting with 0xff).

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bca1236..f22782a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -615,6 +615,28 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	int i;
+
+	seq_puts(seq, "format: victim_secmap bitmaps\n");
+
+	for (i = 0; i < MAIN_SECS(sbi); i++) {
+		if ((i % 10) == 0)
+			seq_printf(seq, "%-10d", i);
+		seq_printf(seq, "%d", test_bit(i, dirty_i->victim_secmap) ? 1 : 0);
+		if ((i % 10) == 9 || i == (MAIN_SECS(sbi) - 1))
+			seq_putc(seq, '\n');
+		else
+			seq_putc(seq, ' ');
+	}
+	return 0;
+}
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -664,6 +686,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				segment_bits_seq_show, sb);
 		proc_create_single_data("iostat_info", S_IRUGO, sbi->s_proc,
 				iostat_info_seq_show, sb);
+		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
+				victim_bits_seq_show, sb);
 	}
 	return 0;
 }
@@ -674,6 +698,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("iostat_info", sbi->s_proc);
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
+		remove_proc_entry("victim_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
