Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57034606B761
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T+5zazGi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ph/IlOT3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PyuAzjrD;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BXAa/fsu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=MTQsyYurp0NM59/NYB7WXNeeXRSMJeFcD8NsQVvLODc=; b=T+5zazGiH45PVAPTH2LkbihK1f
	7PTAK3109vz2Xh/S17mrkwBoUCys/E874xK6KLWaicC4DcYjyc/V23GHJONMp1ioxr0QMiEoPtbxi
	mKKXM3OpaspDk35aXXTytDdDIVq09DzduxpggwAodbloc+HAYDGsmlLAW90TkkzBMiVM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU8xv-000000000PZ-2EjE;
	Thu, 19 Nov 2026 20:42:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xU8xu-000000000PS-0YxS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zuAMJz9hO/rd2dsRhDkrP8w09SehngbI7g09vJ6xniI=; b=Ph/IlOT3gX5wdfAmgnoo9xs0T+
 1e32b5ELQoEcyXml7et5yny3gQZtl+i1zuVOP2hkInR8XL5C1hq24V6pxXbeo1VmjlHG7E02bk6jU
 UqdnF+A/7yQeE1ShIyv5CWgnqDPkxBWmigLAtoclu5v0ZiaQk/EyZlBWvEMzFQpClb7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zuAMJz9hO/rd2dsRhDkrP8w09SehngbI7g09vJ6xniI=; b=PyuAzjrDcdIxj1S3b91OAsjrAV
 jliqZlSw5t5r0wB/ukNE9aVX56pRpd7UlfXkq6++ZUwjVqSsAFpWKzon/Fz9sf7tepSw/5dCRBSbl
 QEwUq22CmirRjagAJeaFj3UwxUP6kWLD+Dyv7Ugo90UH9CpZ4WY+AEsjR5CmHH7wATno=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU8xs-000000003Sl-36Uj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:42:42 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b3d4d3bba3so140587a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795120955; x=1795725755; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zuAMJz9hO/rd2dsRhDkrP8w09SehngbI7g09vJ6xniI=;
 b=BXAa/fsuISA/JF7Ovhxs7OryW3mINNlJybL/KL859y0nnJLnGClMBIrRCxDMsd61AZ
 JcPymz1zrWezqyHkLdUuAqoOAACp3xxPZ6OK9lNsjp/kpZdwH/tQ+Mn3VAC005mEYvOL
 n4OP8j96M4r1PNbunCuVJvUTUKh7fbub2cQZPaXaYd8BxsMjZ3wPux6JfpdFvggQUUK3
 J1M5Wg0gdZ9lrtMNmpubrVDw/3d/Do1Fe4YOS4Oh/vQcXOH66UqTpT3PMksGQ0bDbA5j
 W4Wzo7v5FROoHHKEr14290WNXbblJapr36kEj7Tp9707pxBKrYbvkn+PPxgqaqI0c/T0
 BPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795120955; x=1795725755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zuAMJz9hO/rd2dsRhDkrP8w09SehngbI7g09vJ6xniI=;
 b=0b23yWkb0oxnWahD5dVXwJTeUmsejIhMkXrz68AjyoUIGVwTd35RzJu3uSJ53VaUs2
 qcXLbnqppwMd0bD2rVkseoBKizd6p9lP1pQfobpgqDbmJA74PHaGXStC/LpMv4G1asZR
 6GqbeX9z88nPasD9ohmRjajdTQDrhlr4BKOw6u4RKAncurjhglz3F9U/K+u301uTq+IY
 H5e0FLEZq2VuaZDqbXWjUfJd5vVxkPvsPOmvhqkmGvk8o/HBkJQMKN7rSZfBOSI/Mihj
 inqwGcwHeZ473FRKeFVAwrqBExuRvob5pW5mIJqa187GN0QgFHWsEeW0ftpKzr8hCna7
 7FKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHL+XP1WczqUJD5o8pA7tXnUWr0FSnZTzLCpoHYqStXbGoY78sMoxoKe4/Nyi6GfumjMhjTkWYTT3nLKzzoXOw8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81DH9dWKjWayOYyf8i6+QvVI4jVjUi9zxMrdcNOzZmZJsuQP+b
 6y9hFAtNcMZbURdi4X3s+v7/KY8na1lTJpw0o9LM5e30/iOUCt7KNvsS
X-Gm-Gg: AZFdTZeGk9UtWkJ0IDL7Bqv9ZKedx2pAk8x1PBdrCljL5OE8vGCPEJZUEAz/bYxk1+x
 /TTEAS30zF4/uxOQSJGhLs3VKfry4ypxcJfK6O9yhvaVbj3EUUf8gGQk1wJqCncYFQYOJUv0N0J
 M03yETtBxGqjf5JhsHCuMexKZem/ectj5daAFnYZjb2Bq+uZJ+ayYd0kIVZQrFwSGllARZL0d2R
 HSiTq5HjdE/OhG1+PnMbP1qNGYocBe10vZK55dQdjvtB8K9ploeIzn1/qaoZxLz4MGBkze4/Wc1
 flyX6+aDtWDJfPHa8R7A98I5RUh2xHkrsNeoMoeBK1ZSVPi/QnSllvcJdaGdhVR4qRxA/HviA0b
 FVNsNevHusIAO/n7xMMLkthgBz1hBvI38b2VC2sLop406yE6TRegR3l/oaV015MbP7fm1LSH5wI
 P83x/qPid7KzHtz3rzyWqCQwnQUvy29ysSqOI3qTubq215DKMriOuqKZcsnCp1+hiGWfe3RO2ts
 qV6q2DOdfpGkKePf5eRqp1MVAR/x7vUbz5ZgAM6Ue8MILRGNUDs69DH7ln/FqEAOD33XqQ8fKv6
 fnq6e9R5GNdMPD8Wv8tFyMa1QsGg+AnANlMW8BMOWWmWclRoJnuiQsifYf8VarfOv7fIcbmhXMs
 CXcnRQyr+o+h3kfPYRABS08JAKMmNnNc7ZLdjnuhx/sfeMzyXKRzbCRbhYyXIix/5uf8=
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9d14:feb2 with SMTP id
 98e67ed59e1d1-3b41c933eefmr515740a91.35.1795120954903; 
 Thu, 19 Nov 2026 12:42:34 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad48786sm960738a91.9.2026.11.19.12.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:42:33 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 19 Nov 2026 12:42:29 -0800
Message-ID: <20261119204229.3895622-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xU8xs-000000003Sl-36Uj
Subject: [f2fs-dev] [PATCH] f2fs: let f2fs_write_cache_pages() flush a
 partially written folio
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

f2fs_write_single_data_page() writes a multi-block folio block by block,
so it can fail after it put some of the blocks into the merged bio. It
does not report them on an error, and f2fs_write_raw_pages() does not
count a folio that failed, so f2fs_write_cache_pages() may not flush the
bio at the end and the folio stays under writeback. For that reason
f2fs_write_single_data_page() flushes the bio by itself on an error.

Report the submitted blocks on an error as well, and count them in
f2fs_write_raw_pages() before its error handling. Then
f2fs_write_cache_pages() flushes the bio as it does after a successful
write, which is also what f2fs_write_cache_folios() does, and the flush
in f2fs_write_single_data_page() can go.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c | 4 ++--
 fs/f2fs/data.c     | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0e989254ffe..b8001953be15 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1743,6 +1743,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		ret = f2fs_write_single_data_page(folio, &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
+		/* Some blocks can be submitted before an error. */
+		*submitted_p += submitted;
 		if (ret) {
 			if (ret == 1) {
 				ret = 0;
@@ -1760,8 +1762,6 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 			}
 			goto out;
 		}
-
-		*submitted_p += submitted;
 	}
 
 out:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..c0fc24d0b2ac 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4381,9 +4381,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		if (!compr_blocks)
 			f2fs_unlock_op(sbi, &lc);
 
-		/* The callers drop the submitted count on error. */
-		if (err && local_submitted)
-			f2fs_submit_merged_write_cond(sbi, NULL, folio);
+		/* Let the caller flush the blocks submitted before an error. */
+		if (err && submitted)
+			*submitted = DIV_ROUND_UP(local_submitted,
+						  F2FS_BLKS_PER_PAGE(sbi));
 
 		if (!err)
 			f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-- 
2.56.1.750.gf70dc682cf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
