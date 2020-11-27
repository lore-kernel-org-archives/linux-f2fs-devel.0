Return-Path: <SRS0=C6vc=FB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E111EC2D0E4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2020 09:02:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5211D2222C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2020 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DZm3cjCB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EL5UxXIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5211D2222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kiZdg-0000ge-Ss; Fri, 27 Nov 2020 09:02:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kiZde-0000gN-IW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Nov 2020 09:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EIcTIkuTYy1EtjpPVy4HnnqrlCSgJve7k1HiVCDYuS0=; b=DZm3cjCBqXK6GN2fwBEaDq0vvu
 91stxn39MSeuvUkukkvmL43MLuxpu1WUGNs66Pc0/Oh17t8dQO7TNROJtXy878Jm3kf2RjEhX3pkb
 jG9eMjMyHLq7nT3aTUgPuN475RmdJIkJLlULotrNCOPk5OAQoHcjVAvC6V3J14vxDZhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EIcTIkuTYy1EtjpPVy4HnnqrlCSgJve7k1HiVCDYuS0=; b=E
 L5UxXIuey9rvk35WCJh0Osv17LrfyC/WQAbcfs56rgKUVh1cF7ZovmrOiQ/5d4c4lWdCPaC4KUnz0
 9SrvrpO8AToSejOE/BuYF45D/GVg96xQmNIUc8qSuanKZbrPd49lZCtJ8GV4vKhvhl8QIheFgw8CS
 pFeEBL3pu5pLl6xQ=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kiZdR-0019a7-W9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Nov 2020 09:01:58 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cj7rt2TZrzkhDy;
 Fri, 27 Nov 2020 17:01:02 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 17:01:23 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 27 Nov 2020 17:01:18 +0800
Message-ID: <20201127090118.84235-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1kiZdR-0019a7-W9
Subject: [f2fs-dev] [PATCH] f2fs: introduce a new per-sb directory in sysfs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a new directory 'stat' in path of /sys/fs/f2fs/<devname>/, later
we can add new readonly stat sysfs file into this directory, it will
make <devname> directory less mess.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  5 +++-
 fs/f2fs/sysfs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d38f2135016..a20059dece46 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1510,9 +1510,12 @@ struct f2fs_sb_info {
 	unsigned int node_io_flag;
 
 	/* For sysfs suppport */
-	struct kobject s_kobj;
+	struct kobject s_kobj;			/* /sys/fs/f2fs/<devname> */
 	struct completion s_kobj_unregister;
 
+	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
+	struct completion s_stat_kobj_unregister;
+
 	/* For shrinker support */
 	struct list_head s_list;
 	int s_ndevs;				/* number of devices */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ec77ccfea923..8c63a6e61dfd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -708,6 +708,11 @@ static struct attribute *f2fs_feat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
 
+static struct attribute *f2fs_stat_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(f2fs_stat);
+
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
 	.store	= f2fs_attr_store,
@@ -736,6 +741,44 @@ static struct kobject f2fs_feat = {
 	.kset	= &f2fs_kset,
 };
 
+static ssize_t f2fs_stat_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_stat_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->show ? a->show(a, sbi, buf) : 0;
+}
+
+static ssize_t f2fs_stat_attr_store(struct kobject *kobj, struct attribute *attr,
+						const char *buf, size_t len)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_stat_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->store ? a->store(a, sbi, buf, len) : 0;
+}
+
+static void f2fs_stat_kobj_release(struct kobject *kobj)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_stat_kobj);
+	complete(&sbi->s_stat_kobj_unregister);
+}
+
+static const struct sysfs_ops f2fs_stat_attr_ops = {
+	.show	= f2fs_stat_attr_show,
+	.store	= f2fs_stat_attr_store,
+};
+
+static struct kobj_type f2fs_stat_ktype = {
+	.default_groups = f2fs_stat_groups,
+	.sysfs_ops	= &f2fs_stat_attr_ops,
+	.release	= f2fs_stat_kobj_release,
+};
+
 static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
 						void *offset)
 {
@@ -942,11 +985,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
 				"%s", sb->s_id);
-	if (err) {
-		kobject_put(&sbi->s_kobj);
-		wait_for_completion(&sbi->s_kobj_unregister);
-		return err;
-	}
+	if (err)
+		goto put_sb_kobj;
+
+	sbi->s_stat_kobj.kset = &f2fs_kset;
+	init_completion(&sbi->s_stat_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_stat_kobj, &f2fs_stat_ktype,
+						&sbi->s_kobj, "stat");
+	if (err)
+		goto put_stat_kobj;
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
@@ -962,6 +1009,13 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	}
 	return 0;
+put_stat_kobj:
+	kobject_put(&sbi->s_stat_kobj);
+	wait_for_completion(&sbi->s_stat_kobj_unregister);
+put_sb_kobj:
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+	return err;
 }
 
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
@@ -973,6 +1027,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("victim_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
+
+	kobject_del(&sbi->s_stat_kobj);
+	kobject_put(&sbi->s_stat_kobj);
+	wait_for_completion(&sbi->s_stat_kobj_unregister);
+
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
