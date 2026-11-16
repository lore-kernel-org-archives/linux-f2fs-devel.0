Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D788606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hgoXr3zv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bTTHtJS8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ry6fRppu;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4FTD8ig
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=/zKmVIfzxeLsyqDQ7I2EiDIGn3ELAALXnctAecQsTho=; b=hgoXr3zv9Pc+/1Q9RZGLoaExRf
	B/6f0u1eNE1PScnbjDHaCRuv/6vYIYMEb4MN2GD7U3why75JUf6nAHAon/mTEEO//kRn4xD1uFs/b
	yX9PtCYy9ef6L0i4I4wkEqvh8Oj8Pb7u80eGnDoq9Ub4acU6VjKeACEsMMjENHBbWAxM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo27-000000006eR-0DGM;
	Mon, 16 Nov 2026 04:09:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo25-000000006dj-2YEH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=itS1+HEShLEFlben7inBoCVV+t3onLIzDTpOeg1Xvu0=; b=bTTHtJS8g0hOWdfc1HTsA+E+T7
 zu/DVuKt5ekZNrz7dipJFnIDQJZPXFZjuQtOednzrNoTfSIoa7zeTCQsiSgv7F4k5d7IqMAn2TT5A
 welxx7Olvvvo+DCMDYl+GB0on+IP1Mwx2b2g1sWZvNeoA7aBnZr6rxBb3fDDRSb4Udt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=itS1+HEShLEFlben7inBoCVV+t3onLIzDTpOeg1Xvu0=; b=Ry6fRppuaNVl+qmnRMzXuQ1KO7
 IpWeYAJ5J4rKgiKugurj0gXU5hXw+S0P338e5bfMIsAMnjbbjJDLK1BfCxUdzBo2yuOrEZtVJBuQy
 YG5ysJxrKcwurPnyo7dImAXRRXf69qKmRqLHYR3T3Ou95IWhBVowQ1GXswOXj7+Rs9OY=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo24-000000007cY-0yG8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:29 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso2483427a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802162; x=1795406962; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=itS1+HEShLEFlben7inBoCVV+t3onLIzDTpOeg1Xvu0=;
 b=e4FTD8igFv6KinEpOpztiWjioq+t+vlTqWmKP28UKqkNupzEYcu/QTVqpz4M20GGk3
 MHM+1SyyXinoCFw2dUtHVAad6Ia5j5Lle9qfG92S2YrGDJn3FIk0Cpv+OMpRO7eAC0Qp
 jul57QSVTHZBmauY+4loUQfDa+HacWzPwunG7CVZFBh/0ZPL7TeNZTZc/Bpz1PNVOozS
 bA/gBmgSjw8VSyFc6zXCsyMA58Zil9seyluCJ5VpIMzRkNb0Y9mAIkudq+oo8XJjL/Yw
 VKQU4HeHilG70ZUMgjvIytTnlLyWzIMhUbq2HaamNVD2rtIDErE5cGR9/eSY7XLPzZI9
 yWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802162; x=1795406962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=itS1+HEShLEFlben7inBoCVV+t3onLIzDTpOeg1Xvu0=;
 b=IJParQW32TQtcHKIzEX1egn3HoWGXrD3Fsg1Eu8DZ+HCQuIyg8XpPNbBgYiybldP/N
 6AsCutiDCbsALtDOIFcgnJNUjarrGPwKvLeEdhI/oDLl4jcWgYd3YU3VQah5E1z+30a8
 xBS2h6328aZEbr3gGFa6wERaAB1MEDUt1srTZw5pFIe41gAAvKcSNUFV3fmS/W1UeDgF
 kQJSNlnzh4dekQ7V1MZ3sYFgTPOdZTh84AkAK9fzfLxoFSolusNKtWflciQy5PzjullX
 IpOyDoWOkVpctjPMJRPATo6ceBa+5uILVz+9T1lXZVv69dZDNtqfD7RJ+iCshITx33Zm
 OwJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHHKnAgNmjxY+guKwnK7ZRANfgnmYyQRBBCQswLWHmZ5i+b8j+PaRTSG6F0FS0krXrif4M45cWxZzs23W+DdFqW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Gje8ssZ0whkHzjxrRm0F6JFlIcCrmWxebNMYvVgHiRuzm8rPt
 eqgv3BXeY9gt+59fi9mmGjwcDJ8eJZqo6z56QecHe7DT2fsN3V7CgWiI
X-Gm-Gg: AYBFou2kluhPSQA88QpJ1GC6mGY2zIClg5B8tQ0bOAwvuLpaXtE2GHdxM/qSBN7F8uP
 b/3zYyMPJ7EJIYmI2MV6LuU8ccWSiijY538Od/6xX4jIx8dsqCzFchrGQbom6ZiMZRLY4MGsdrE
 ehiikpwLP11M1i/GrHkqFoBp/2b8X1lr/CLnW1/31VkwKYfLm7F9hVnh+eDtJM/DnZeRr9bLyie
 3JUVhLJ0pEt3v2Wm1QZKkrHYKnWB08520IjL0o1TO/U+sGaRSuXuzxcs4mKQAUcKc/eKR6/RcgP
 T6F0my44kuL02fzA5kvuXY6fZyGxzOiT3F41uMq9R2Kia4yOCmUWT+tjDovhqOMydAw+lkMkhBp
 u+LBG86Pa7bhttwPyIB1YJX2sxTM29Sd7DCux8oujwdJgVA27vHvUlqrPtedM0n7hEp77VM2t+m
 QLsA9SmXAkovK1b4wwOQTWJ5wS/nYyhkA3fPw4oB6pQi6Txxiu/YDcZxD3dHcSFE8I9OcHr/9K+
 7QPFmBGuQKTuMLhn/xC68XwcJe2MJ1WNOQJOcEe+ousHu4P2DqMMp1icUZeSYNY4AxRRZ2vDL4E
 vuMAPutkIy0xU7X842p6FWNzo5kVG8IDpitfyEWQjcetNvA1TOu9WmuZjKfRCnaplphbiOqg1WK
 JJgUv1b7aiugps5s2qVoAC/mTRL8V38YVXt4f5wzhg5x0ueg=
X-Received: by 2002:a17:90b:2247:b0:3ae:2969:9031 with SMTP id
 98e67ed59e1d1-3b1b0d08f2cmr9878273a91.54.1794802162415; 
 Sun, 15 Nov 2026 20:09:22 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:21 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:43 -0800
Message-ID: <20261116040851.2849696-13-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo24-000000007cY-0yG8
Subject: [f2fs-dev] [PATCH v2 12/20] f2fs: support subpage blocks in
 defragmentation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Mark only the target block, not its whole page, dirty when redirtying
data for defragmentation. Remove the -EOPNOTSUPP check.

Read a multi-block folio once through ->read_folio() instead of each
block synchronously, and redirty the folio that was read after locking
it. This also applies to large folios when the block size equals
PAGE_SIZE.

Read compressed files through ->read_folio() as well, with any block
size. f2fs_get_lock_data_folio() reads the mapped block as it is, so a
block of a compressed cluster that was not in the page cache was read
without decompression, and defragmentation wrote the compressed data
back as file data.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4499a461be86..26dd06961389 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3202,6 +3202,41 @@ static int f2fs_ioc_write_checkpoint(struct file *filp)
 	return ret;
 }
 
+/*
+ * Return the locked folio of a block to redirty it for defragmentation.
+ *
+ * A compressed file is read through ->read_folio(), which decompresses the
+ * cluster: f2fs_get_lock_data_folio() would read the mapped block as it is
+ * and leave compressed data in the page cache. A multi-block folio is read
+ * the same way, in one I/O instead of one synchronous read per block.
+ */
+static struct folio *f2fs_get_defrag_folio(struct file *filp, pgoff_t bidx)
+{
+	struct inode *inode = file_inode(filp);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t index = f2fs_lblk_to_folio_index(F2FS_I_SB(inode), bidx);
+	struct folio *folio;
+
+	if (!f2fs_compressed_file(inode) && !f2fs_has_multiblock_folios(inode))
+		return f2fs_get_lock_data_folio(inode, bidx, true);
+
+repeat:
+	folio = read_mapping_folio(mapping, index, filp);
+	if (IS_ERR(folio))
+		return folio;
+
+	folio_lock(folio);
+	if (unlikely(folio->mapping != mapping)) {
+		f2fs_folio_put(folio, true);
+		goto repeat;
+	}
+	if (unlikely(!folio_test_uptodate(folio))) {
+		f2fs_folio_put(folio, true);
+		return ERR_PTR(-EIO);
+	}
+	return folio;
+}
+
 static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 					struct file *filp,
 					struct f2fs_defragment *range)
@@ -3327,7 +3362,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 						cnt < BLKS_PER_SEG(sbi)) {
 			struct folio *folio;
 
-			folio = f2fs_get_lock_data_folio(inode, idx, true);
+			folio = f2fs_get_defrag_folio(filp, idx);
 			if (IS_ERR(folio)) {
 				err = PTR_ERR(folio);
 				goto clear_out;
@@ -3336,8 +3371,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			f2fs_folio_wait_writeback(folio, true, true);
 
 			f2fs_ffs_mark_subrange_dirty(folio,
-				offset_in_folio(folio, (loff_t)idx << PAGE_SHIFT),
-				PAGE_SIZE);
+				f2fs_folio_byte_offset(sbi, folio, idx),
+				F2FS_BLKSIZE(sbi));
 			f2fs_folio_mark_dirty(folio);
 			folio_set_f2fs_gcing(folio);
 			f2fs_folio_put(folio, true);
@@ -3378,9 +3413,6 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	struct f2fs_defragment range;
 	int err;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
