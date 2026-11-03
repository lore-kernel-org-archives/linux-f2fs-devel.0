Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83B606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UrUkV13V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fA8zsKV1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T9G+QHhQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKRrGZEV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=mYTP1NzkBEpY14uBwsIoJJjq8w8DB75H49f23TTGSd4=; b=UrUkV13VksgCXsvuADh9BO7Rf/
	jzcIjqN4XbWUyhucyuc9ynPFu+8tEkL5n5OFwRzz1djcJQje+4RRg8jcESc6YH3B2G70ZhZfYYOtW
	0TxBqErNDeCZ9ld0m6pvI5LUIdTVRsDgJ9KuajlP2H/vgIAwmB3ZNemsN+wjc+7yHRq0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO4rt-000000005mH-1EsJ;
	Tue, 03 Nov 2026 03:07:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xO4rs-000000005mB-2e8q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 03:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9HpRBkZWND8kAqnAVXLSY+m+WbnEs0skB5MrleQMApE=; b=fA8zsKV19rgMg5Shdl+ELcsH7P
 42g0E8L2+vX8get+0JykOLZ3Z00/fmG8AqEngRud1KTF+Sdeszg0u3PsIcRVgGYBO8n1WGefYcSSb
 ExKDuimkJ9Ono6sTVqlvfL5WAkKzgosj6EB3Wj07hshXiW8ewVRxwbkUeRXjIIgZlrLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9HpRBkZWND8kAqnAVXLSY+m+WbnEs0skB5MrleQMApE=; b=T9G+QHhQ0vXWn/L4PMH5NFUeuP
 PpNOJE300BZvZqpjlD0V/QqocYLCHK5lGMgj0fvPY4MiSf5sHEz0RGT5gcvCqyN7/1C9eeGVvUe0/
 z9m4VW7SRGVoAvwmhauI0MI0CU9RWX66tc1dM5eGDGtDlPFWfQ8CSbxth7nkHpCBo2Ok=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO4rs-000000004W2-0Z2K
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 03:07:24 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8a05f2d5cd3so1562119b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 19:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793675238; x=1794280038; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HpRBkZWND8kAqnAVXLSY+m+WbnEs0skB5MrleQMApE=;
 b=vKRrGZEVFjnVENX9qtoePG2piNzUwm+62Wg1QvMcwybm8Pivhnh7M3zZFQ4z3xP4wo
 uf18+RUrPg4/kM9++tYa2DOAbB6ScN4v+Hn5JAz4bsPwMbEYCR1QTz2u0WSojL+ZnMs3
 zC5ztpMVXjgus4DFiEzbTCjgx8RVf1FD9y2CIOM4J+KgU81lgEdoRaag2lolvdike9LO
 Md7JgzZ4tdxc5dXuoC2ykSY9IBJREfj3fkMmQy4MtnU5sytGaExZpABMd1cEK9tiZIkb
 FcJrUyhif8uuOyvH/xkjgA57nrcnNgNsv4iUFF8BX0sQAhu4LTxR06WhdTxCQEjNN3Kj
 P1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793675238; x=1794280038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9HpRBkZWND8kAqnAVXLSY+m+WbnEs0skB5MrleQMApE=;
 b=EAn1rNBisLP7eLrMC1ohfVEfg6Kdahy6LO2l2YqnssLlBghMf1GBsWZHTQi6U3s/Jp
 oMxeeHWmcy567Yg+9Bcsn5bnpVjydIpCW4ZOih3IE2ho0xS+fj5Qk3Oa7X/e38b7Brgv
 Wzo1j2VCAGzme4W+q0KdA/4b2nKsCP4/UFb+LIDr5jV10PmwBrz+E6V7Af2WuEOSgXz5
 omXCVZQHsviOXfADRscDUjTvVM6scvVtwAqd8HnaPY5gsvk9YQw5Bahmy6CqcvsaGWzb
 ZOlCrnTXdyEy5xsCuA4dtUFXBEiYqeEApYVqLqonPpr5BssQw/8v90TPtMjt8CUu2M25
 utDg==
X-Gm-Message-State: APuU4Z8nYT78BM+QivzVvUdqgloPdoSYhrR9J19odwmTOmjFAVCGmnTQ
 8Sb6cq/aw3xbubeSmd59Z/n2ffAljb+ib4ch4mnJZ7dsvKKO0PEEjNR+
X-Gm-Gg: AYBFou2J4Um40+/gNwXtTA3dw/XhcuHoYMDo4LuYhDvrO8IH57/0GLZd4toDzNYZowB
 tur2VCQi326F6xouHwW/mXG+GsClrqkE9786uRmBiF06xw4xDbeyXulXXDHgQSJbnEYe6/TL/dz
 oSqTJXSwQjycpRbEFDKJYvZTP9Bp3qECrmIuGF/MYIq8KEpgrryL8kJyxCEs3Df2/6czmEGlYya
 QPKqbkYw2yPJGYndQ/VyCdjZRrSb1TsXjD4raJW7qBORqEiBU5OotaYqnhwQwq9KBN6qHTb6i3P
 MBYah8jF3ZKxKP619NLkoDMmPseye5cATlEbhQgmR3HnBJ4Vf6/w9NWOlKM4MO1XSql7p65MfAA
 LPYBl8I8l+S2/BN6z8VGN8CybsRe7VQxMoAGWiCRFjN6oKjo5PGyzlVLI0VWeZE26J+dQoc28fM
 zNua8TpiTo1xM0hGQP+RMzBdGk/SUWLrczdPcJfdLEToB4bZmkpLNQ+rpqOr4YAoK6qbmhOqgER
 gY+3YKtjaDSobgjQcESZlLy9H1ec5QwQovG/kHiVo9DU51AyISVC9cyCqU+lMntTwuOvPB/RLkq
 mzrt5D2t7ExLFlW9Pai5Re3f6JE4W7ZfsChSGBs4B5fvJA==
X-Received: by 2002:a05:6a21:e181:b0:3e2:e6c:7d4 with SMTP id
 adf61e73a8af0-3e928d4401bmr7514623637.23.1793675238189; 
 Mon, 02 Nov 2026 19:07:18 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364ac001sm511302a12.25.2026.11.02.19.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 19:07:17 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  3 Nov 2026 11:07:12 +0800
Message-ID: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xO4rs-000000004W2-0Z2K
Subject: [f2fs-dev] [RFC PATCH] f2fs: fold casefolded names of F2FS_NAME_LEN
 bytes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: zhanxusheng@xiaomi.com, andrealmeid@igalia.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

utf8_casefold() needs room for the terminating NUL, but
f2fs_init_casefolded_name() gives it only F2FS_NAME_LEN bytes, so a
name that folds to exactly 255 bytes is not folded. In a casefolded
directory, creating 'A' x 255 fails with EINVAL under utf8:strict.
Without strict, after creating 'A' x 255, stat of 'a' x 255 returns
ENOENT and creating it adds a second entry.

Fold into F2FS_NAME_LEN + 1 bytes. Existing entries for these names
are hashed by the name as given, so on a miss also try that hash.

Fixes: 43c780ba2624 ("f2fs: rework filename handling")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
RFC because new entries for these names get a different hash on disk.
Results in a VM, with dentries dropped before each stat:

                                 'A'x255  'a'x255  'C'x255  'c'x255
  current kernel creates 'A'        ok    ENOENT
  this patch creates 'C', 'c'       ok    ENOENT     ok       ok
                                    (one 'c' entry)
  back on the current kernel        ok    ENOENT   ENOENT   ENOENT
  strict, current kernel        create 'S' x 255: EINVAL
  strict, this patch            create ok, found in both cases

Each fsck.f2fs version matches only one side. 1.16 folds into PATH_MAX
and rewrote 'A' to the folded hash, after which the current kernel
cannot find it. The dev branch rewrote 'C' to the raw hash, after
which this patch finds it only as 'C'. fsck would need to accept both
hashes for these names. Encrypted directories are not tested.

Is the second lookup acceptable? The alternative is to keep hashing
these names as given, which fixes the EINVAL but leaves them
case-sensitive.

 fs/f2fs/dir.c   | 21 ++++++++++++++++++++-
 fs/f2fs/super.c |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 70847313ca6a..05ae0fa2e22b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -76,7 +76,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 			return -ENOMEM;
 
 		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
-				    buf, F2FS_NAME_LEN);
+				    buf, F2FS_NAME_LEN + 1);
 		if (len <= 0) {
 			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
@@ -359,6 +359,10 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 	bool use_hash = true;
+#if IS_ENABLED(CONFIG_UNICODE)
+	struct f2fs_filename raw;
+	bool raw_tried = false;
+#endif
 
 	*dentry_block = NULL;
 
@@ -389,6 +393,21 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 out:
 #if IS_ENABLED(CONFIG_UNICODE)
+	/*
+	 * Entries for names that fold to F2FS_NAME_LEN bytes used to be
+	 * hashed by the name as given.  Try that hash too.
+	 */
+	if (!de && !IS_ERR(*dentry_block) && use_hash && !raw_tried &&
+	    IS_CASEFOLDED(dir) && fname->cf_name.name &&
+	    fname->cf_name.len == F2FS_NAME_LEN) {
+		raw = *fname;
+		raw.cf_name.name = NULL;
+		f2fs_hash_filename(dir, &raw);
+		raw.cf_name = fname->cf_name;
+		fname = &raw;
+		raw_tried = true;
+		goto start_find_entry;
+	}
 	if (f2fs_should_fallback_to_linear(dir) &&
 		IS_CASEFOLDED(dir) && !de && use_hash) {
 		use_hash = false;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78dbf1e92285..4172429da862 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -505,7 +505,7 @@ struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
-						   F2FS_NAME_LEN);
+						   F2FS_NAME_LEN + 1);
 	return f2fs_cf_name_slab ? 0 : -ENOMEM;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
