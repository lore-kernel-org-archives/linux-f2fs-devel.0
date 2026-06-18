Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6368CCD98F2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E1jP55zFLXY433njwplW1vMIunttOKOaQzVbL7miOHE=; b=Wko11c4akv3ARnUzL9rwRsEw8V
	ABn7+A6qjGEiIkOH7cUaTfqPKe28QFVZM5PzyTTALCLN5qzvOMxf0uejcL5+PHxf+r0xun9T6DDqd
	4BHP7jiaVRXSWg7aP92hUYVcdvyug9mff+4RsCMui5W/bO+LQCXuRhQ5/BLkjI1NZlyQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1waIvw-0007wn-UD;
	Thu, 18 Jun 2026 20:01:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <iganschel@gmail.com>) id 1waIvX-0007wO-Fp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 20:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/KjNn7oIPOk5S1KhGdV+Qc8EkkjlRGU4my6m/nNkSF4=; b=byTVBmiay2dH/4MY0R4CwDEu5x
 Ppo2ShCh28qKxDRHHykfZvrf54wqCICaxTtd7jzTg4ZIQLJrFfThnePsjfZJJzgPYpSHtmFFenRJ6
 413BygIbjab59+evRz60HyrrHjX2M505OM9KUmTxNwr/OVQUgPdnwr2drCyPLj4FSDwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/KjNn7oIPOk5S1KhGdV+Qc8EkkjlRGU4my6m/nNkSF4=; b=S
 i7hlznGW95o8KzP5loRoVw3USBCLY+WE65f8AuvqagplRzIy4vTabW0qJ0Mpw1SVF4jyEufvNiu0C
 2u9eM1/pBhYs6hDwR8xLULBcq3SC6OtDTnjtRG/iQS97lJ8plTJAkKLYb4O8CQmWqILpMMUKucOWt
 lXSs8fLt7t9BHAaA=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waIvT-0004OH-43 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 20:01:24 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso1561096a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781812878; x=1782417678; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/KjNn7oIPOk5S1KhGdV+Qc8EkkjlRGU4my6m/nNkSF4=;
 b=X80neZuVpv3LoNuBFwAk2ptU3qw6ftDQH+GtyoOwal6SZEXoFsdafGR5daYbRv5w38
 xFj8XLXfyMBBV5q5hrkEPbBa2VU1Jqr+k0nCQYKC04aaBS/k/F1KLlpVDju0xFXQPVYO
 slQCRDF2M6cCAjaa2gRLmZN+jLcFMD0zkBmlWWizmoOMbF3U7PFzFtLDdfB9KQJBParR
 cTQ3vC6jHJt087OwVukPIVabwPGeDIsYb1PizOXYBKlkdBEeWirpgqAXXMzRqTyETkCj
 LxBnY0Bz05BpHWAt9sDeJrAsh4OwnR2cbRJx1wfO8DeO9+EGb2IrIozEIPR21+RmBJfU
 bsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812878; x=1782417678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KjNn7oIPOk5S1KhGdV+Qc8EkkjlRGU4my6m/nNkSF4=;
 b=WtF6g5YBQuU4moaUW3eHWW6VgzTFeKj7KEgTUR2yJvMnaB5HB6pIBl+pb/y5iBlejG
 jZuVrviu1M6/jjrVBCP7dtNjYVnjJoSWnl6O9EdF1wvSDcr4L2+aEfR+cqHtFxW0ZZAG
 x/EihZwFbM70hCAxuw71WRzAWLtWTlNx2uPq9wLEdJWfEXcJvC+dgKfMJFVJfdq+gQgd
 baM6j+nRHGcaGJFDAFrP3e82g5XePMFab/bj1z21BNA0vqxk/xeteZ/LZzudH6iqgQGk
 ztOp8M3td0SD/CM0jk505r6wx2qyxdyjy01/7AV/+U9sycOI16+pSM8NLV6Wvkewa28D
 3LGA==
X-Gm-Message-State: AOJu0Ywov53q+0y3WsppUiATy1Ft21KNtm9rau/SaeARKxnqaBQmv4Rz
 /g8e74zX+K7cyvYYyb/22aOAB3PWwL88qvYIRdMkryugL4kDnFu5idlJ
X-Gm-Gg: AfdE7cnHzXigyDl/oR6GVELvuZ64OS5yRJNGcvxxYaOhTXZ6YhfkYs+xQ5MGLAqzyOX
 fTBV81B0nrCwVS4Vg0JpZ5gGALZtTHC9jHP93omZikl9A9Ifb/I48pY2qeeZfEalgu/8CjG9Do1
 UZtjcaAANRxhqOF8i4iuOQioS7Qp5t57PTGE13CzWNHrFH/yRwxzKB0sH/vKQmixnj5z+sAEtLp
 ctxOONwpkfwV9q+4gJssgIl7m0/B4SA3Y8J3sAdEtJXaNsIkB56NXmyje+ViUISPI8DqWDaUsIJ
 JLW9jnxknHp1Lsq5DF/SBISZJXp1Dt+tRVIAcxnSU9U8FlKefCdgnJwyvkj+H32ykSez2uJUys3
 EqW5k3AMZ0Dc+f++2eLZWnLDgVJZwvneVYXwbaxa8sOdUQbu9fAymvvlbjriqxMo6uES3o5HB3b
 zFgtVCg/WdzOX2i8QSs18YfGCD9aoCGB9VHg==
X-Received: by 2002:a17:902:dac5:b0:2c6:cf81:74a8 with SMTP id
 d9443c01a7336-2c71900ff22mr6485405ad.30.1781812877821; 
 Thu, 18 Jun 2026 13:01:17 -0700 (PDT)
Received: from LAPTOP-TMVMP5FD.localdomain ([106.222.251.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac72asm225736595ad.38.2026.06.18.13.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 13:01:17 -0700 (PDT)
From: Keshav Verma <iganschel@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 19 Jun 2026 01:31:05 +0530
Message-Id: <20260618200105.3551-1-iganschel@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-Headers-End: 1waIvT-0004OH-43
Subject: [f2fs-dev] [PATCH] f2fs: fix listxattr handling of corrupted xattr
 entries
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
Cc: linux-kernel@vger.kernel.org, iganschel@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Validate the xattr entry before reading its fields in f2fs_listxattr().
Return -EFSCORRUPTED when the entry is outside the valid xattr storage
area instead of returning a successful partial result.

Signed-off-by: Keshav Verma <iganschel@gmail.com>
---
 fs/f2fs/xattr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 610d5810074d..18f495db20d2 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -581,8 +581,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
-		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
-
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
@@ -590,9 +588,12 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			f2fs_handle_error(F2FS_I_SB(inode),
 						ERROR_CORRUPTED_XATTR);
-			break;
+			error = -EFSCORRUPTED;
+			goto cleanup;
 		}
 
+		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
+
 		if (!prefix)
 			continue;
 
-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
