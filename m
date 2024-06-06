Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F45C27C52
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:34:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sF7eA-0003Wx-0Q;
	Thu, 06 Jun 2024 07:34:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1sF7e5-0003Wm-7d
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nGCRfoowmW936zp+wg6FWdWM7gCYhe027V7cxi9zvXs=; b=UpCLmjFaLaJ9X/YtVehfmCOlPj
 PehvQSaN4hls3CA/gtw6937hMQIUasP42qkXDM+QYgyJYfZkDg6+gK2CAyMbJtmc+tGn+9odIPIgv
 m94ZyBPlKl5Tf2Wwb3eizEATwpzAvn6Wm3rs3cmsaDvfQU6yPh4cmCfUJgO/gSxRBAUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nGCRfoowmW936zp+wg6FWdWM7gCYhe027V7cxi9zvXs=; b=nDsSYZGF8v1SMm17Cxr+nWygdp
 lfhNEXD7kimLJ2PDwqKDaLGltHiDtpgYmm7yEOxV5xZy6BqnE6K4aEKnr+K8bI3DYMa7G/zIcSeAU
 khtRYfeVSwuXkQKLZ9phHUPWr6dLly0CNf0jnsxKNSlxGIhWVqR/EQR75AqvMiTzQuLg=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sF7e6-0001xb-8P for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717659278;
 bh=k2lM/43/rKq0SBXPEuuWsOvKQDRgGSdsJNLUcoGSQAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bwk759Hgvf6pJ0JDfaJ160yU1e/Ss5JUWAja70s0ShWdkVC9PUbBxMCINfP4Myiiq
 rm399mv27ekOXn+qCPtmZku1SCJLW8NrrxCGi5eJ4DobkE9ekAIhEvmPEiiv2GcwCU
 KhjHmWF8DLNhoQjf3wb54xqNLVKfLavwrl9klOeCyBTak9md39qNrdfD+tM3nHJfEV
 fUm3CJzsjCzeocrXduuqS/6Y519NkO2c6/JGOiVMYTHMlTlw5GT0L6j/VKz07Z9uV3
 9Cwq6HxfDJNrBET59yinZnAUlf+16mQpvjKVYWTpnG8zfzMbBt6nC0HWaxJPsiAuYF
 F6HjLy7IEyw6g==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3CE2E37821D7;
 Thu,  6 Jun 2024 07:34:37 +0000 (UTC)
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu
Date: Thu,  6 Jun 2024 10:33:49 +0300
Message-Id: <20240606073353.47130-4-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1sF7e6-0001xb-8P
Subject: [f2fs-dev] [PATCH v18 3/7] libfs: Introduce case-insensitive string
 comparison helper
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
From: Eugen Hristev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: krisman@suse.de, brauner@kernel.org, jack@suse.cz, ebiggers@google.com,
 Eugen Hristev <eugen.hristev@collabora.com>, viro@zeniv.linux.org.uk,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

generic_ci_match can be used by case-insensitive filesystems to compare
strings under lookup with dirents in a case-insensitive way.  This
function is currently reimplemented by each filesystem supporting
casefolding, so this reduces code duplication in filesystem-specific
code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: rework to first test the exact match, cleanup
and add error message]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/libfs.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +++
 2 files changed, 78 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index b635ee5adbcc..8aa34870449f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1854,6 +1854,80 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
 #endif
 };
+
+/**
+ * generic_ci_match() - Match a name (case-insensitively) with a dirent.
+ * This is a filesystem helper for comparison with directory entries.
+ * generic_ci_d_compare should be used in VFS' ->d_compare instead.
+ *
+ * @parent: Inode of the parent of the dirent under comparison
+ * @name: name under lookup.
+ * @folded_name: Optional pre-folded name under lookup
+ * @de_name: Dirent name.
+ * @de_name_len: dirent name length.
+ *
+ * Test whether a case-insensitive directory entry matches the filename
+ * being searched.  If @folded_name is provided, it is used instead of
+ * recalculating the casefold of @name.
+ *
+ * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
+ * < 0 on error.
+ */
+int generic_ci_match(const struct inode *parent,
+		     const struct qstr *name,
+		     const struct qstr *folded_name,
+		     const u8 *de_name, u32 de_name_len)
+{
+	const struct super_block *sb = parent->i_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
+	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
+	int res = 0;
+
+	if (IS_ENCRYPTED(parent)) {
+		const struct fscrypt_str encrypted_name =
+			FSTR_INIT((u8 *) de_name, de_name_len);
+
+		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
+			return -EINVAL;
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (res < 0) {
+			kfree(decrypted_name.name);
+			return res;
+		}
+		dirent.name = decrypted_name.name;
+		dirent.len = decrypted_name.len;
+	}
+
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 */
+
+	if (dirent.len == name->len &&
+	    !memcmp(name->name, dirent.name, dirent.len))
+		goto out;
+
+	if (folded_name->name)
+		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
+	else
+		res = utf8_strncasecmp(um, name, &dirent);
+
+out:
+	kfree(decrypted_name.name);
+	if (res < 0 && sb_has_strict_encoding(sb)) {
+		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
+		return 0;
+	}
+	return !res;
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 639885621608..f8ca264a0edc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3367,6 +3367,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_sb_d_ops(struct super_block *sb);
+extern int generic_ci_match(const struct inode *parent,
+			    const struct qstr *name,
+			    const struct qstr *folded_name,
+			    const u8 *de_name, u32 de_name_len);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
