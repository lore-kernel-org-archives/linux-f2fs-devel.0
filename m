Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51013C8303C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Jul 2025 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Date:To:From:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Nc+Bkn+3nKTIBDGcZ0a7x0z5fq08LGHki1i37FZIHg=; b=jtiN/GXiewnWKG5cB6coIs6O6r
	jYwVxdi/J7fGqZFpBD/sAKF8l5vuyBdr/J+3fArwifNeqlCYoA6YonLfGKQplfyZnvZz2vQ7W09Ov
	Sc7i1innD61BQDBaMGeBtL+04ZbPVrxSMRxexbUbRtbigULfeEMg+G8eb2S2/0IPBiwU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uZ26n-0003Qc-5a;
	Tue, 08 Jul 2025 06:47:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ywen.chen@foxmail.com>) id 1uZ26k-0003QB-BA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Jul 2025 06:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vdIyDvJNm1JguBw4F+puzOvkcznPiEpm8HbrDr1/ue4=; b=dD1jgEqGFwyoy31QCFUGR5Orp1
 PVAUxOW6npur8BhGazzJQGnnMHqh8mu7AVZefrZCTB2KhMcKKJCYjWVzJdbXz7wgXWjfA9eqxue8n
 bkiqZlzJ07LqalpvdJJwCz07nBtwq/h8vN+8WnzL4q4xPVJYAaAhLVstogTVa27YTLe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vdIyDvJNm1JguBw4F+puzOvkcznPiEpm8HbrDr1/ue4=; b=aSKuA9fVjgBedVDXF1qZurW66W
 KHrBcY/pqiC+6riYq90g/VLCx+jZxM8N+IdlPr79TCi+b8oXB/BinNr7DSaMyVDTDUWYjzyvTiba/
 vM946Vn5WRdEn4UEKQVivgBwME7D68cZ0y5Sk0FMkM6xxjpHo0NpT7RmJ1Vk094f9nJA=;
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uZ26j-0006sZ-28 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Jul 2025 06:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751956903;
 bh=vdIyDvJNm1JguBw4F+puzOvkcznPiEpm8HbrDr1/ue4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=woXWoh5oZVgyZpvePuntb8Uuth84cVtA9PdRkPcmJkN2AmiG5jIZ2xqa6Vs2Hoegn
 gG+uZcZqrMRCJY0zb/ksv4/7k+TbXiU6QhjABkdMl5UBjuoayCLnKGxphUKB7afRxN
 pSPcKTvTDSYEVpln/aG91vSQc+UbqA2B+6Xcqmuk=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.73])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id A6890ACF; Tue, 08 Jul 2025 14:41:40 +0800
X-QQ-mid: xmsmtpt1751956900tianq68yj
Message-ID: <tencent_5A2FE78BA54BA148917B62FCC4B5E4FC2505@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne9o+Gb8aezNKf5Psbb6m1VxRKSa2JVhARcEcyjV0y21AATnjgl7
 oizaZTfuyqmRXnTMmfneAkENDMc6Vu1RT/u8y9XIcloKbgBjkaXNPNPyOdWZTtKQRknWjxdHD2AW
 Sxgq2JvE7RtnIPYwfGSnNyH1mB1OwRZuGMtOQLvCqC8xovQ9tTe4k6GZOTarq55quNN9JBvAwcx7
 qOOrO8zFVVOtW8ByOD/9YbFHisQllOFlMfxdZfKTHY7kfUA5b3iNz7IH5iekXOfv05fNAUos0KO4
 hG4bRM9n5Y1MMg+BCnvNLaLAEfpZFdbe7LtFQ6PMmt8I+JlYm8wWKKmc44W15m8vwTX6/ajAxNoK
 pJ7x01omadan2ex1F6frWPgiNrQ0jtrISb2TecrhIYkIPne4VzgpS984JHYZ+BqkiEEXOM2wRVNW
 TziMC+RzIXO92IOj7DDAb2t23XrnZQVN4GfRybb168MKM9QMZprVF+2aDDn0qtZBsUkFz7qqOrZK
 Jhz0cP1tY3My2A+Vt4BFYCD6IeAeZamAMf/mngWvv6j3Ea7tT/d77Uam4W7nlPnDjTaj262LmeLx
 zSs8fWTrGFAPEabL7LEOgyla55q6+dUSE8/GRAwF7fbyTTxEn6YNA0q7FeJocUjtIvy3l+b33H3R
 +OZAyL3Zj1qn3xR9aOw8E7SNXqT8rnbqkvjY79yCyW0w/rNQNHRmiWXVWV9V/0u4JgtLWhnIjRhL
 AeVKW7P90HPwCCAzsjEISF5L1Voz8SYgIiX/vRxbnGNZzkiKMpdsjHavXPxgIav54NVD4WcDWAgu
 VlSobte6LbHPRN4QJEYUJOZKvlfPrOl8Xc2S9yoXvnv4omGu/+E2Vo/86vTKrUmh3aA83Fzhc0Gt
 JBDpm2iPOgnR2TB9x+3rTsAune/cMl1qz/rA1Oriqev5G5LbttRZCHsz0Kyas4SqSpRrkH2Exqap
 CGb4v1Y7Zz4kAt1OMWipz5zkHocBmrKjEOAIYte+QXcFDqtKzaerx4H+9mQ+iR7A5wMR8cIuW+i0
 u5Z93q4jO5MGvWsSKKw5qxS3dDfwHRVht2RKF/Dw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Date: Tue,  8 Jul 2025 14:41:35 +0800
X-OQ-MSGID: <20250708064135.844552-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
References: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
MIME-Version: 1.0
X-Headers-End: 1uZ26j-0006sZ-28
Subject: [f2fs-dev] [PATCH v4 1/2] libfs: reduce the number of memory
 allocations in generic_ci_match
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

During path traversal, the generic_ci_match function may be called
multiple times. The number of memory allocations and releases
in it accounts for a relatively high proportion in the flamegraph.
This patch significantly reduces the number of memory allocations
in generic_ci_match through pre - allocation.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/ext4/namei.c    |  2 +-
 fs/f2fs/dir.c      |  2 +-
 fs/libfs.c         | 33 ++++++++++++++++++++++++++++++---
 include/linux/fs.h |  8 +++++++-
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac2294895..f235693bd71aa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1443,7 +1443,7 @@ static bool ext4_match(struct inode *parent,
 
 		return generic_ci_match(parent, fname->usr_fname,
 					&fname->cf_name, de->name,
-					de->name_len) > 0;
+					de->name_len, NULL) > 0;
 	}
 #endif
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c36b3b22bfffd..4c6611fbd9574 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -197,7 +197,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 	if (fname->cf_name.name)
 		return generic_ci_match(dir, fname->usr_fname,
 					&fname->cf_name,
-					de_name, de_name_len);
+					de_name, de_name_len, NULL);
 
 #endif
 	f.usr_fname = fname->usr_fname;
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a81..293b605971bbf 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1863,6 +1863,26 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 #endif
 };
 
+#define DECRYPTED_NAME_PREALLOC_MIN_LEN 64
+static inline char *decrypted_name_prealloc_resize(
+		struct decrypted_name_prealloc *prealloc,
+		size_t wantlen)
+{
+	char *retbuf = NULL;
+
+	if (prealloc->name && wantlen <= prealloc->namelen)
+		return prealloc->name;
+
+	retbuf = kmalloc(wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN, GFP_KERNEL);
+	if (!retbuf)
+		return NULL;
+
+	kfree(prealloc->name);
+	prealloc->name = retbuf;
+	prealloc->namelen = wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN;
+	return retbuf;
+}
+
 /**
  * generic_ci_match() - Match a name (case-insensitively) with a dirent.
  * This is a filesystem helper for comparison with directory entries.
@@ -1873,6 +1893,7 @@ static const struct dentry_operations generic_ci_dentry_ops = {
  * @folded_name: Optional pre-folded name under lookup
  * @de_name: Dirent name.
  * @de_name_len: dirent name length.
+ * @prealloc: decrypted name memory buffer
  *
  * Test whether a case-insensitive directory entry matches the filename
  * being searched.  If @folded_name is provided, it is used instead of
@@ -1884,7 +1905,8 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 int generic_ci_match(const struct inode *parent,
 		     const struct qstr *name,
 		     const struct qstr *folded_name,
-		     const u8 *de_name, u32 de_name_len)
+		     const u8 *de_name, u32 de_name_len,
+		     struct decrypted_name_prealloc *prealloc)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1899,7 +1921,11 @@ int generic_ci_match(const struct inode *parent,
 		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
 			return -EINVAL;
 
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!prealloc)
+			decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		else
+			decrypted_name.name = decrypted_name_prealloc_resize(
+					prealloc, de_name_len);
 		if (!decrypted_name.name)
 			return -ENOMEM;
 		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
@@ -1928,7 +1954,8 @@ int generic_ci_match(const struct inode *parent,
 		res = utf8_strncasecmp(um, name, &dirent);
 
 out:
-	kfree(decrypted_name.name);
+	if (!prealloc)
+		kfree(decrypted_name.name);
 	if (res < 0 && sb_has_strict_encoding(sb)) {
 		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
 		return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ec77da65f144..65307c8c11485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3651,10 +3651,16 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_sb_d_ops(struct super_block *sb);
+
+struct decrypted_name_prealloc {
+	char *name;
+	size_t namelen;
+};
 extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *name,
 			    const struct qstr *folded_name,
-			    const u8 *de_name, u32 de_name_len);
+			    const u8 *de_name, u32 de_name_len,
+			    struct decrypted_name_prealloc *prealloc);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
