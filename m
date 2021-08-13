Return-Path: <SRS0=A+6L=NE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D7C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 10:14:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3A86103E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 10:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D3A86103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mEUCO-0007HT-US; Fri, 13 Aug 2021 10:14:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <frank.li@vivo.com>) id 1mEUCK-0007HI-MX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 10:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LT5j6jzIpCt8GM4eCtrmf2oNrWK3u/WRcDCpniiGoVs=; b=AS8S78BaGWPvSzXkALacKFovzI
 dCfPym3P9dok9tU5PNoUd0UQDCXWA7eNdpjOzdSUA1e+Weijal7rKJOg+IPhGeL4ipI4BdAnx5yoc
 XI5Pi2l+4MHc8R/nIslWxR+O9zjGNHawg8ss4iqqEd3pnx7zYx9xW+sXGXmZXEDfWbRk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LT5j6jzIpCt8GM4eCtrmf2oNrWK3u/WRcDCpniiGoVs=; b=I
 43FKCmnZcTICOT5ElbZDP60XTds3LqnOVz0Hf9B9JJj5j9PZHa36PcryWW/W4CGnR6NTBXlsqLdOA
 2sO5h/Jlg33JaVKqDxkFDjCPbDbe0v41DJwD7nsbwIpCDeMSN9Y/R74UdEkInGdjbxxDfWa7JQKXV
 Y83s501bL1AsLEuo=;
Received: from mail-m17636.qiye.163.com ([59.111.176.36])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mEUCH-00559c-RL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 10:13:56 +0000
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
 by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 37AC1C40221;
 Fri, 13 Aug 2021 18:13:46 +0800 (CST)
From: Yangtao Li <frank.li@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 13 Aug 2021 18:13:41 +0800
Message-Id: <20210813101342.442438-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlJT09WH0tCGEtOTB5DTE
 xIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06FDo6Vj9JNRgQVkI6GjcU
 DjwaCkNVSlVKTUlDQ09CTUlNTENDVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
 VUpLT1VKQ0NVSk1OWVdZCAFZQU9DTUg3Bg++
X-HM-Tid: 0a7b3f00dd04d996kuws37ac1c40221
X-Headers-End: 1mEUCH-00559c-RL
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: introduce
 proc/fs/f2fs/<dev>/fsck_stack node
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
this flag is set in too many places. For some scenes that are not very
reproducible, adding stack information will help locate the problem.

Let's expose all fsck stack history in procfs.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 33 ++++++++++++++++++++++++++++++++-
 fs/f2fs/sysfs.c | 26 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67faa43cc141..b2662fc56217 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
+#include <linux/stackdepot.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -119,6 +120,8 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+#define FSCK_STACK_DEPTH 64
+
 struct f2fs_mount_info {
 	unsigned int opt;
 	int write_io_size_bits;		/* Write IO size bits */
@@ -1786,6 +1789,8 @@ struct f2fs_sb_info {
 	unsigned int compress_watermark;	/* cache page watermark */
 	atomic_t compress_page_hit;		/* cache hit count */
 #endif
+	depot_stack_handle_t *fsck_stack;
+	unsigned int fsck_count;
 };
 
 struct f2fs_private_dio {
@@ -1997,9 +2002,35 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 	return test_bit(type, &sbi->s_flag);
 }
 
-static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
+static void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	set_bit(type, &sbi->s_flag);
+
+	if (unlikely(type ==  SBI_NEED_FSCK)) {
+		unsigned long entries[FSCK_STACK_DEPTH];
+		depot_stack_handle_t stack, *new;
+		unsigned int nr_entries;
+		int i;
+
+		nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+		nr_entries = filter_irq_stacks(entries, nr_entries);
+		stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
+		if (!stack)
+			return;
+
+		/* Try to find an existing entry for this backtrace */
+		for (i = 0; i < sbi->fsck_count; i++)
+			if (sbi->fsck_stack[i] == stack)
+				return;
+
+		new = krealloc(sbi->fsck_stack, (sbi->fsck_count + 1) *
+			       sizeof(*sbi->fsck_stack), GFP_KERNEL);
+		if (!new)
+			return;
+
+		sbi->fsck_stack = new;
+		sbi->fsck_stack[sbi->fsck_count++] = stack;
+	}
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0954761341d7..c134bbb99c7b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1171,6 +1171,29 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused fsck_stack_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned long *entries;
+	unsigned int nr_entries;
+	unsigned int i, j;
+
+	for (i = 0; i < sbi->fsck_count; i++) {
+		nr_entries = stack_depot_fetch(sbi->fsck_stack[i], &entries);
+		if (!entries)
+			return 0;
+
+		for (j = 0; j < nr_entries; j++)
+			seq_printf(seq, "%pS\n", (void *)entries[j]);
+
+		seq_putc(seq, '\n');
+	}
+
+	return 0;
+}
+
 static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
 						void *offset)
 {
@@ -1261,6 +1284,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				iostat_info_seq_show, sb);
 		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
 				victim_bits_seq_show, sb);
+		proc_create_single_data("fsck_stack", S_IRUGO, sbi->s_proc,
+				fsck_stack_seq_show, sb);
 	}
 	return 0;
 put_feature_list_kobj:
@@ -1282,6 +1307,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry("victim_bits", sbi->s_proc);
+		remove_proc_entry("fsck_stack", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
