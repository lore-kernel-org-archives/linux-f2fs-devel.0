Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC26CA5FD4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZojHIVt6uoQ03owYwDXp2WPD6PGnz7gnzQOyxwLqfaY=; b=bxMQcUhuibhVMBvDk754/0boZ3
	gril5k4ELCR++Dh+afKdVDHEQ3JjdnOGlhHnus3jC+0ZOfuTxEovKjCoqJSB0N4n+GawPWZo2r4SJ
	EsYyOmiBRrIhFCd48OdibP5TVW8jeVF/0nJutdYQv7zrGTbGWIc0rX5g5HinMApchYu4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCgsu-000365-SZ;
	Fri, 02 Oct 2026 17:17:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xCgsr-00035w-5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 17:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=at3WCJYxrNqQiRPabCfUcyh8BXLNwHFp+QXUnaRws7o=; b=ZVeH1O7shEYsPuug15D0ME+E8V
 yS4jgEFPQJ5aotMl9aUhZI0RVkNfX8OVIAd+LFuLmF3/S58zPQqhMXQ5h0VFhvnwKOG05dHbtN6My
 T51enmDoDQ/eZbDYSCxV3QsuQLV0u+OnXEGmKg8N9D+69dBAKLJcN0rj+eQNb3ynlEBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=at3WCJYxrNqQiRPabCfUcyh8BXLNwHFp+QXUnaRws7o=; b=l
 VgFjSkUP+PHMpDH52Cg8FvyoUPAva+x7Tal3UZCXlpRXV3CbcKZSBmckW8U6NngEj1Gq29h23lE5S
 Ca4kbiSUp4G3bCj9A1wlBNaqErCvV8nbyCWRqmCR92VCag/u7F+sMm8isAw0hhn5RYmSyQZAueeC1
 P724uAyQFZ8+8xQw=;
Received: from mail-pj2-f42.google.com ([74.125.227.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCgsn-0005Ff-2G for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 17:17:18 +0000
Received: by mail-pj2-f42.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so52784105ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 02 Oct 2026 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790961431; x=1791566231; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=at3WCJYxrNqQiRPabCfUcyh8BXLNwHFp+QXUnaRws7o=;
 b=CMSCdPO1OvdabmqodniLpmD+Ov2bAbgAog92QgZqaa9HvwrfZV4YSC2JylfJOtThOn
 ALS63mXg4bWaZwQtFu7EizbuERtBTcGZrarSHMwig9lWfVzOlBQH8yhwwzD9UU8U2mDZ
 ntkOThD4id9pZcpOaX4zP3eZmyuz27idpZv11xN5aCGVgxQGG3VMnMngjHJ6E51bFo11
 1jAoHLGJYjw5L8lTqM3b2E8/egUgQrTgUtE/y9/74tYnwxVBTzM+dBUviji2je/wBCGB
 9v32+XXxvobpt/eN2CmCZVplYyzR7ptfNjZxni2lwro0KT+t7SGBRgKXVeJ/of0+FHSQ
 eMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961431; x=1791566231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=at3WCJYxrNqQiRPabCfUcyh8BXLNwHFp+QXUnaRws7o=;
 b=b+/ExCJ89WMYrFVomik4O1bRK0cj5W5yMLrLzGs7sGu7pzbEqZ/pa0RrpoqeffY9Ga
 GI9mJvL8qMCrDJHP2BFOBZNyQbBei2kkzxGxlSVUdymGFUS7mPVxuJcr57NmPvwErs2c
 yH0gCjBy6jr3hDWLTtpGYboPnygpU6rUXFGDDbroDEM6O8/hhoUEqD84G4g39qlixUlh
 uzxUkA6MCjRq+ixkrRw88oaoq+m9XahYp0lsR9ztCTQPePrM4KnmggIYbzDEInepmeOA
 y1+m4OMgNV2/VtLHGdy8XZAyMOf+u11BQy9FAJtNJAiiAco006FQj8i7PNDZU+uVh0Zq
 ILxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzXrffkMaQ4uTl27b7K138gkHGWve6r1gvzh2pGYhA8sx8od0dmkbMK99KJW6REVGQbnJad0YkmiE2ky4BbMbS@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIJB5BFXY+LpQINCPhRXxcXoosIBwTyiTbcUijCKJZY7lskYtIB
 0AsVKRWZxrLCPyxscvaNlbxM/zIoF5LvAJvk9+bD2g+tcRBQf8TBM86B
X-Gm-Gg: AYBFou18ntnZkXEgUh2n34KvdROqiKq5k3XtY0CWAp1746ptsm7RE423QL4CxLbVvgk
 bKzmKhQjlT4CnOyyzV2s+fTjPs/CDdJUZSHsFHHZyxUPr8THBrjpct8hEgZVFXk97O6k8gwj9nG
 BCjeCDOuptlJFunlc7ax+I/SNVXL7s5n0d8RSVW/aRLCSQaUHd7cobpnJ5PpIhl2cRR5ToG+JQs
 LrBZ7e2xQfKdqswgc6XK0b2AQwdv347JHY25uPG2mCp0gVvalCkdEqkjcUkkavQux20osrSEcLh
 biKE5yWId6X6yraC0aQzlG8URUmysgJucP5DAKVrCYrRaJPc9VPOgXsEtDPQFKd47Wk1EItnGuE
 1d8zkBeRbiO5LGwbLmqBr1clhnK8BLcnBDqQVwXc7f+iMoO8B+1nXuPwOB+SXsU+sv1JZuL+Iiu
 mJlIHIV41Aw+YjsL5cA28KsB6wIpHxRMWOTBxwN7VpemanpqPV6AP8OGAqvCSB4cXkyHpFrteEg
 dgcdoJtIYLzsbwzab3X99r04GVwW6SvtMg2o8nEgysjUQVOQCye5ba4ysC9WakmYagt2E4XuJ72
 AtcIA812kCX+kMQ=
X-Received: by 2002:a17:902:d502:b0:2e2:ffcb:87a9 with SMTP id
 d9443c01a7336-2e49b4e3702mr32501335ad.24.1790961431271; 
 Fri, 02 Oct 2026 10:17:11 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e4c2a7e76csm4075525ad.31.2026.10.02.10.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:17:10 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri,  2 Oct 2026 17:17:04 +0000
Message-ID: <20261002171704.3652570-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xCgsn-0005Ff-2G
Subject: [f2fs-dev] [PATCH] f2fs: disallow mmap write and data-modifying
 fallocate on atomic files
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Stores through a shared writable mapping and fallocate with
FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE, FALLOC_FL_COLLAPSE_RANGE or
FALLOC_FL_INSERT_RANGE do not go through ->write_begin, so they bypass
the COW inode and modify the original inode directly. Reject them while
the file is in atomic write mode, as fallocate already does for pinned
and compressed files. A write fault gets SIGBUS and fallocate gets
-EOPNOTSUPP.

fallocate without these flags only preallocates blocks and stays
allowed.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694..56c686b8580 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -140,6 +140,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
+	/* mmap stores bypass the COW inode and would break atomicity */
+	if (f2fs_is_atomic_file(inode))
+		return VM_FAULT_SIGBUS;
+
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
 		goto out;
@@ -2113,9 +2117,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	/*
 	 * Pinned file should not support partial truncation since the block
-	 * can be used by applications.
+	 * can be used by applications. Atomic files should not either, since
+	 * these modify the original inode directly and break atomicity.
 	 */
-	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode) ||
+	     f2fs_is_atomic_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
 			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
 		ret = -EOPNOTSUPP;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
