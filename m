Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6B606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=laWxh0S/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hx+MsQFH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SZeHfCOK;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jn/oXwT9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=t5S0Tam0BDmntGCQQ2nPT+RR/0R0SZUs4JN2e5AzhsY=; b=laWxh0S/47jaDW+FBuVTmqayut
	X7pvgkYF19ltv7h4q1mybOM/6H8F6Ch4frplgp+eLOoF0jAy68IGsgrgQo66bNny2tPJYSSW2Dbkb
	tcOw8Wq1lifIRWyhj4uLHx3FloPSR8bqaySFHKetH9zaBvkS/ucp9ckPrDGtYS2F7JrY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRxaZ-000000001pp-0qms;
	Fri, 13 Nov 2026 20:09:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xRxaI-000000001pa-2nma
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 20:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2JCzw07zOgx11DGTQQhhF28iPAeJ5hNLiG60ahLQknE=; b=Hx+MsQFHtFRUS4CzXdQp1dORFa
 0JDod0cOu4o9usj4lnjREJaTa67nT9/sf/hdCZOjIh7x7wcMLvPPHHGVGo1vdoH+pC0QgtYDsqp0z
 Lv/93Sdb2N7BROWRMOr44B6hAnAe8Qfd/igLibgEDqWheuSrUU3UJDJs2pD0S15Wh2kQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2JCzw07zOgx11DGTQQhhF28iPAeJ5hNLiG60ahLQknE=; b=SZeHfCOKLqhKL6GqAOSBEqitxk
 retJMTuxTBRhi1Z4k/LHGyG/LIzprmG8o1zdBdaEJz5EUe5Cho/oJPfQy5o4pdcLbUPXJ9jL2edsP
 ABj8U++82aX6co2nDN9tnCA01K+9JojAuT7fgHBAqBXLApm1cmx7ehjdnJVCfl082Q2c=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRxaI-000000003XW-0a9i
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 20:09:18 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdb75699c7cso545233a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794600552; x=1795205352; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2JCzw07zOgx11DGTQQhhF28iPAeJ5hNLiG60ahLQknE=;
 b=Jn/oXwT9SeegZRVDe5IrljwHTDyAcu2gIHLR42Y5sZYfWbc39lihVLSTFpwKECPzOq
 mx3sKOiAoC3O3fTI/ipERg5xYYuSMYthY5/4S0oCNRZXY7wyymW178x8acopQBD7mTtg
 0s9fjZe/agAmTDv9gxhnhgh2i47mN3GKPnsmstWATprl0H4GuQ5y2LczUhAuyUHCVOSc
 dmohkZevTnvt10Owpzz/51YLedhdhMI89Yqj4t9C4sZBxkIcIRYrTozU1AXij5gX7boN
 7hHj/RqnYTu3Swo/YL/rTEYtHZEvVQjSTrOYPi+RlWomV48VYnLXiFE/KGDLHmKwbSmS
 xpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794600552; x=1795205352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2JCzw07zOgx11DGTQQhhF28iPAeJ5hNLiG60ahLQknE=;
 b=pGeIKrFob0NUHiPOB7x/1w7fZKFwSsiZ+LvKXMfK9x4zr7KqZCVyfNSkjUwT685D/R
 aSuxYYb1gcZP1QfLL+AeC7yP5dcmsLuo9KOLZlWdotwlfGH0YtPUzzMjlbJv1mJ+JJj/
 aMfym3hD8EPOBbss709A4IxtdJdmPx0nZCRYeXukKaf+OgpzGoqHPdjCQ1WI5/KO/EUy
 sv/Hpolvq9VubvbT042Npe7Jl/YCnizKVosFwOTlhaCtjmoHAhet3doJI17zniWV6wE1
 xAw/2WgKuYf8+j6t0bbP604XVstpgUyaUEWe+lZ2VkIIqNieDzPf+BgmmCZsz8qrY4dD
 I5Eg==
X-Forwarded-Encrypted: i=1;
 AL+hErEFYb/kMiS4DqDzH1YJpfBz619WJKFzYblDHbCaW091nF+IxBfkPVnqCGIQR1rPp6FncdDdHIrD6aqX0Ta6/8cf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/FrxpqdliyHMSuxtjvPtI93TewxWhcY6Cp53UxEHG2+WwOvs63
 iZMpA4YOlxhT5ybggumkFPBaItXsFGPo4/rdLivE8Y11tqd4qYVZV+L1
X-Gm-Gg: AYBFou1gYgRgzgbjr4TjJUWpXXJcirE25aM1zEoZaIemD6tA1CP+clCtF0IB6FNd6bC
 rGB0Qzqwxv4/vhr2LpKE/MfiSii+ulm2BFsioIOpJg4ZD356PeoU4EM5yKneq84M/JZrjyUF9Ie
 6gRgGunzjv1LLkcfFe+OK1/Thk6aEKQNQP6nFAxMUxBmloY6YmzXzhltTr33EuM/6L7DtDVb+mT
 v0Kv0ZYYCyr1427iLQOGrNR0zTo1fyenNqBjAPKwhlYaBES8H26BG1ZlLcF4n7UIWx0em+3mZbJ
 nQwS4YfquNIqklBd7rfuhERCL9wV4yJwq96xYJB+2SAyty9ybkEX/UxJb8oel0e7nrGYi8rQzX4
 amevbsbC0GOclxPxO55sOXRyYlwYDSD9MGi44Kjfp/7UQvvRiGGzlPCTo5pfPZf1qH/cbXFWi2J
 PuMhuWLG7YGEt/Wc2btNAettsbQ4yPnIAuKfHXnR647Z5Xzi6CfNb7a8Ek19YMbDWftlfGCpJf/
 r6SkmqOLGqGtNzxkclfk33G5ZVkvdczsrSAeQktM28bELWuCbhpVnv+CSBCgL/r0PCJ8em92mJ4
 TZCCrsu2H8P0r/A9YyO8w3aQXL+hMbDzR+P27Oja9tzF/og6Qj4Hjow9/n6J0n8C+mKZcEYc+3Z
 8qkTPAdsZ+SfHc3t+w7aC9Ly0FjsuYzro3BwYa8vOnwCGYVqizJxpw+rxexoLDa43nOs=
X-Received: by 2002:a17:90b:17d1:b0:3ac:9a5e:9ce9 with SMTP id
 98e67ed59e1d1-3b1b0a3b41cmr3553616a91.29.1794600552264; 
 Fri, 13 Nov 2026 12:09:12 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c6c9c5sm10909841a91.1.2026.11.13.12.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:09:10 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 13 Nov 2026 12:09:04 -0800
Message-ID: <20261113200904.3010578-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xRxaI-000000003XW-0a9i
Subject: [f2fs-dev] [PATCH] f2fs-tools: set the block size of zoned devices
 to the logical block size
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

The kernel caches a block device in units of its soft block size, which
is set to the largest power of two that divides the device size, up to
PAGE_SIZE. On a 16KB page kernel, it is 16KB even for a 4KB logical
block device, so a buffered 4KB write is written back as a whole 16KB
unit.

On a host-managed zoned device, the first write in a unit then moves the
write pointer of the sequential zone beyond the written data, and the
next write in the same unit is rejected as an unaligned write, e.g.

  Buffer I/O error on dev nvme0n1, logical block 24576, lost async page write
  Error: While writing the quota_blk to disk!!!

Set the soft block size of zoned devices to their logical block size
with BLKBSZSET, so that each write covers whole units. If it cannot be
set and the current one is larger, fail right away instead of failing in
the middle of the writes. Skip it for dump.f2fs and --dry-run, which do
not write to the device, and when the page size is not larger than the
logical block size, as the soft block size is not larger then either.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 lib/libf2fs.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 93f36ca..b0cdf09 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -922,6 +922,14 @@ void get_kernel_uname_version(__u8 *version)
 #define BLKSSZGET	_IO(0x12,104)
 #endif
 
+#if defined(__linux__) && defined(_IOR) && !defined(BLKBSZGET)
+#define BLKBSZGET	_IOR(0x12,112, size_t)
+#endif
+
+#if defined(__linux__) && defined(_IOW) && !defined(BLKBSZSET)
+#define BLKBSZSET	_IOW(0x12,113, size_t)
+#endif
+
 #if defined(__APPLE__)
 #include <sys/disk.h>
 #define BLKGETSIZE	DKIOCGETBLOCKCOUNT
@@ -1047,6 +1055,34 @@ int get_device_info(int i)
 		else if (dev->sector_size < sector_size)
 			dev->sector_size = sector_size;
 #endif
+#if defined(BLKBSZGET) && defined(BLKBSZSET)
+		/*
+		 * The page cache of a block device is managed in units of its
+		 * soft block size, which can be as large as PAGE_SIZE. A
+		 * smaller write is then written back as a whole unit, which
+		 * moves the write pointer of a sequential zone beyond the
+		 * written data, and makes the next write in the same unit
+		 * fail. Use the logical block size for zoned devices, and do
+		 * not go on to write to the device if it cannot be set. The
+		 * soft block size is larger than the logical block size only
+		 * when PAGE_SIZE is, so leave it alone otherwise.
+		 */
+		if (dev->zoned_model == F2FS_ZONED_HM &&
+				c.func != DUMP && !c.dry_run &&
+				sysconf(_SC_PAGESIZE) > (long)dev->sector_size) {
+			int bsz = dev->sector_size;
+			int cur_bsz = 0;
+
+			if (ioctl(fd, BLKBSZSET, &bsz) < 0 &&
+			    (ioctl(fd, BLKBSZGET, &cur_bsz) < 0 ||
+			     cur_bsz > bsz)) {
+				MSG(0, "\tError: Cannot set the block size "
+					"of %s to %d\n", dev->path, bsz);
+				free(stat_buf);
+				return -1;
+			}
+		}
+#endif
 #ifdef BLKGETSIZE64
 		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
