Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363EEC3ABB9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 May 2025 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WY1r1H1KdfmxUOv3CEp3d+jqe3jxjJvR5Bf3JSBlh5w=; b=EZB5vYkGTaMVDi6NNllYHP151R
	p9t8mSbu36GEg2a9rtTKuxS0/9Hru+H1mkAP6rGQYiiHxTLet76Fq1E8RobF5RYJYLzQ/xRmBiIA9
	TZkJg6vS81fQL5lucPu+i8T5wU1K9XlC0E9lv92BIP2i56DZ3cZrTLZc4cFnuk3bDYSY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uC4QS-0005Ay-Uv;
	Mon, 05 May 2025 22:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1uC4QJ-0005Ah-I2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 22:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/AfFAyzFrDA4DHFxspTIjQXhYEPee7pVc1QjicdB0K8=; b=eV4G3ZQhwIV7BW5F+pR9a0PZev
 oGgLEyjAfg6eDXAyhy33WkQhVjOcz0zjaj1PusoudBVzLuUOWDWeSU2PJxUfBAnhJ5ajzuPpbDH0q
 0aU/UX1wRliAMiMd7a1dD7amanig20r6qVbpDcHbrHdn9rsCc+EZebaB0MyUBlUc/w2k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/AfFAyzFrDA4DHFxspTIjQXhYEPee7pVc1QjicdB0K8=; b=CeN0THVR2EPwHC75+3t4om/tVU
 A2FCxBICYRYQatdy1LRH42HDX8gn+dwXcWV5s4cdwcbRQNjjue6DC57grtZV1j8y/EHA+bSDJgo/R
 6yU96kjQnOE7aBwc7jSdHcC2shykWGQ6vWdPOQ7aYndoUDqpmut+G8oG7V6hkgT5xgvQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uC4Q2-0002rL-Ho for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 22:36:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C6DBE629C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  5 May 2025 22:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AACC4CEEE;
 Mon,  5 May 2025 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746484563;
 bh=jHCS0+sXGbHTrVHQFAZYbKT6iqPXzBL4D1iEcMpYs2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GCfOnNIyT7fJpJYlz12Fut4hVY5xXY+wz7ccor5w3ZSUtHecJR1oEdnbV+ITtsAXy
 04YQSuwxuRU9RnSGu1PYUdDzxwjrXc98OKBcDiHY1spxHx3yM7Ajs/iZB9Kx7T6yLk
 eyIqw4QrQEv9eAe1tw6eJ2A5+5fMicdCCjFiBUiQE1iUPhlvcq/xNdipkQN3M7QQ19
 It7O8eEBA2R+TUOsR8jhB/txdEkokrci2IYsioojn34BjlwHqxJzftJzMC7aqyfJxb
 i0gtmzLtp6q58umxPOwn5/W8oGEqltrwWvNCQIM07F9AjJmaQqBcdf97rgM8belBKW
 metpzQzfSElWA==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon,  5 May 2025 18:12:35 -0400
Message-Id: <20250505221419.2672473-539-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
X-Headers-End: 1uC4Q2-0002rL-Ho
Subject: [f2fs-dev] [PATCH AUTOSEL 6.14 539/642] f2fs: introduce
 f2fs_base_attr for global sysfs entries
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 21925ede449e038ed6f9efdfe0e79f15bddc34bc ]

In /sys/fs/f2fs/features, there's no f2fs_sb_info, so let's avoid to get
the pointer.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 74 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d15c68b28952b..b419555e1ea7f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -61,6 +61,12 @@ struct f2fs_attr {
 	int id;
 };
 
+struct f2fs_base_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct f2fs_base_attr *a, char *buf);
+	ssize_t (*store)(struct f2fs_base_attr *a, const char *buf, size_t len);
+};
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			     struct f2fs_sb_info *sbi, char *buf);
 
@@ -862,6 +868,25 @@ static void f2fs_sb_release(struct kobject *kobj)
 	complete(&sbi->s_kobj_unregister);
 }
 
+static ssize_t f2fs_base_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_base_attr *a = container_of(attr,
+				struct f2fs_base_attr, attr);
+
+	return a->show ? a->show(a, buf) : 0;
+}
+
+static ssize_t f2fs_base_attr_store(struct kobject *kobj,
+				struct attribute *attr,
+				const char *buf, size_t len)
+{
+	struct f2fs_base_attr *a = container_of(attr,
+				struct f2fs_base_attr, attr);
+
+	return a->store ? a->store(a, buf, len) : 0;
+}
+
 /*
  * Note that there are three feature list entries:
  * 1) /sys/fs/f2fs/features
@@ -880,14 +905,13 @@ static void f2fs_sb_release(struct kobject *kobj)
  *     please add new on-disk feature in this list only.
  *     - ref. F2FS_SB_FEATURE_RO_ATTR()
  */
-static ssize_t f2fs_feature_show(struct f2fs_attr *a,
-		struct f2fs_sb_info *sbi, char *buf)
+static ssize_t f2fs_feature_show(struct f2fs_base_attr *a, char *buf)
 {
 	return sysfs_emit(buf, "supported\n");
 }
 
 #define F2FS_FEATURE_RO_ATTR(_name)				\
-static struct f2fs_attr f2fs_attr_##_name = {			\
+static struct f2fs_base_attr f2fs_base_attr_##_name = {		\
 	.attr = {.name = __stringify(_name), .mode = 0444 },	\
 	.show	= f2fs_feature_show,				\
 }
@@ -1256,37 +1280,38 @@ static struct attribute *f2fs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs);
 
+#define BASE_ATTR_LIST(name) (&f2fs_base_attr_##name.attr)
 static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
-	ATTR_LIST(encryption),
-	ATTR_LIST(test_dummy_encryption_v2),
+	BASE_ATTR_LIST(encryption),
+	BASE_ATTR_LIST(test_dummy_encryption_v2),
 #if IS_ENABLED(CONFIG_UNICODE)
-	ATTR_LIST(encrypted_casefold),
+	BASE_ATTR_LIST(encrypted_casefold),
 #endif
 #endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
-	ATTR_LIST(block_zoned),
+	BASE_ATTR_LIST(block_zoned),
 #endif
-	ATTR_LIST(atomic_write),
-	ATTR_LIST(extra_attr),
-	ATTR_LIST(project_quota),
-	ATTR_LIST(inode_checksum),
-	ATTR_LIST(flexible_inline_xattr),
-	ATTR_LIST(quota_ino),
-	ATTR_LIST(inode_crtime),
-	ATTR_LIST(lost_found),
+	BASE_ATTR_LIST(atomic_write),
+	BASE_ATTR_LIST(extra_attr),
+	BASE_ATTR_LIST(project_quota),
+	BASE_ATTR_LIST(inode_checksum),
+	BASE_ATTR_LIST(flexible_inline_xattr),
+	BASE_ATTR_LIST(quota_ino),
+	BASE_ATTR_LIST(inode_crtime),
+	BASE_ATTR_LIST(lost_found),
 #ifdef CONFIG_FS_VERITY
-	ATTR_LIST(verity),
+	BASE_ATTR_LIST(verity),
 #endif
-	ATTR_LIST(sb_checksum),
+	BASE_ATTR_LIST(sb_checksum),
 #if IS_ENABLED(CONFIG_UNICODE)
-	ATTR_LIST(casefold),
+	BASE_ATTR_LIST(casefold),
 #endif
-	ATTR_LIST(readonly),
+	BASE_ATTR_LIST(readonly),
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	ATTR_LIST(compression),
+	BASE_ATTR_LIST(compression),
 #endif
-	ATTR_LIST(pin_file),
+	BASE_ATTR_LIST(pin_file),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
@@ -1362,9 +1387,14 @@ static struct kset f2fs_kset = {
 	.kobj	= {.ktype = &f2fs_ktype},
 };
 
+static const struct sysfs_ops f2fs_feat_attr_ops = {
+	.show	= f2fs_base_attr_show,
+	.store	= f2fs_base_attr_store,
+};
+
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
-	.sysfs_ops	= &f2fs_attr_ops,
+	.sysfs_ops	= &f2fs_feat_attr_ops,
 };
 
 static struct kobject f2fs_feat = {
-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
