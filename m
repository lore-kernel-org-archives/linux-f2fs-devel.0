Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257ECCD98F2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cq2nGS0us8dXKkGmfBPrwmdmiYwq0T1iL9z8llIJv88=; b=GCkJfqFLcgThzF7r8/2t8PBv7f
	L87cEhb1GDExoavgD2TLIUdANoz3lqtduNAbXNqjUJUlg005GOAkoMbXH9gr4nu6C8qxM8hyoYlVp
	UuoIrMdBy5sepY2zBtoRLVPT86Pp75qZZm6compLSNFTPE+Hzeb+J3Ckmk/Cl46a2t14=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbgMV-0007Hv-Rk;
	Mon, 22 Jun 2026 15:15:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <iganschel@gmail.com>) id 1wbgMU-0007Hn-91
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XS2jT7hVM4XCWKhj2hYkN4S7SwrftLDakyjg4kfk5Kc=; b=mv9LI23N3g3ZHbelNLPp+vwAyy
 WcDNZYMeVX1XCQDUysnRGQdv0U+gIvatBlJYaaesiC7+snD6Of+39Q8n9s8DNFvbpnK5z7Vrti9iZ
 KPjFWvzpaR5JXUDUm8nyrG14TdTpl0XYkG2HjD0QtiphUOyR0kKf0JIj4U+6odvV06lM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XS2jT7hVM4XCWKhj2hYkN4S7SwrftLDakyjg4kfk5Kc=; b=TlspoRVilRuPemQjYPUH8WFUGP
 Ci+WVv3pqDlipU8UuUSxtKNaKvbrAzQHalX29e5YRC1OcWj3DTbLzM80Q5NscqjrSPdd0nxqoQUFI
 9rPSgkfbCTi7iVrHttbLbspcRQ6rn2R0Yolx0bsIvvSw0ubXlombC1cT58b5LfNdAx5U=;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgMU-0006sI-2T for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:14:58 +0000
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-845537740ddso1564718b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782141293; x=1782746093; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS2jT7hVM4XCWKhj2hYkN4S7SwrftLDakyjg4kfk5Kc=;
 b=Vd3BnEIurHzFSH3kx948ooUK+h1bljEKqvaR7zkKiO8rrV2Rj2FLS2fKF9dJyJBWCF
 r0ZAbjwdmt82RgHL5kXrLhLI4/FsO2VCU2Ivwx/uBOK4CxCDvwq3P5EgBOscimlIjvh/
 vd2WEsWRm5r29NRpeKIwTQvdOt8iyGsXlBgqHTZowS3Vom/ZCr+HOtGZhFGTj+AxVmz3
 lQU6pIjQS/KAP7Gh8dUFOxwvXYK68hFBUZu9QZ/XBNDYJUNUcJWJ6k9RVe7Z4U97/2vQ
 sLoeRPMm/xKfnnwsVIMlf99fCVRCmvmgqFBoOEFY5TO4J37qCc/G7Hln4V3vPu38rvJl
 0HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141293; x=1782746093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XS2jT7hVM4XCWKhj2hYkN4S7SwrftLDakyjg4kfk5Kc=;
 b=sZ6FZBlCIJnqBAdOekvMKWBC7MIkgSGRNoHWYH7Wz593rAO4bhWx+iXxQv91m4sbSl
 g+7ExBTUtTKjLCjbtrxH7DwD7PON2XRcOTDv3XPVAvSSSrDIS6e4ohdMO/0Ccp6lDfk4
 eD9v/gFxNWU8rMPKi5g2U8BoMRmeQj40urzKAsQeiCCTJ1gNNGeIKccuCcK7zGIoBGKu
 AIDsDHoGU7ZiASNDWNL/uCccqQ1y6bRxeK67kRbO7yKJe14NmJvT7p4UYWHqCyoZVRNa
 p6L5+XdVwFtQgqF3EQdCpTlF/WnM5n7UFemvaPIzuuyXiqf/QhkWtexDJ3Umr2/lCj8C
 riNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//dtMQBl4oOhhMHQOxr/M4wux4tyCLtW5ZL5iLzYma5FJ9LHKu2AjxBuen0e5gVUEAUrdV/LtYDX1143YuMcWH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzeSxKjuQeStPa0S/fsrVYzJrz5pa+UmhTCxSoXfLwQpnUMFpAg
 13kRZrYMQh37WRSagNsr6Z7sZtXGEPYMP5kkUP83FJq8gca9ysVWWgYN
X-Gm-Gg: AfdE7ckOqnfR2Rv1q6e5z1Ed+oF4rLEqvhIxZ0xbNnxvQhqzOAisUec7+ONbStNBmwq
 mOlNwJf9ARLBxt+kIaK8N0CYPcBt8kg1vPn1cETu8Y30zXyIX8FUyl6D6WYlJOgj+9mDb+2u/2g
 eGar5X1bVs8/mbmuLnSys4Feitq4Qdf6xNJd1s5H8oC75rgQ3sSSqSMATfeYE/kwF0GTtgo+342
 QxChWcb3Xg3S10c+m3zMAHNThagAbtHvGfXpdH5Q0oOjfM0Gh5PsrkJOL10YeFqtO88Gvf6q8If
 D0C25HFJrxATNbZCBkyoiHDrGRjvJ4bY4jOLqibR04TBhZzQuMVpdCzDghYyJRfTmEQ8ttSjWcm
 hMrRrMQ8CCxOYvgb+ijnj+U8133NHOSUW1KwxTItoEYLi2EPtm81cyM4Ts6IEShbbddIaJOfUl5
 QyRq4PxG4VMmH9n8CnJXjS+im9D/7I4hMe9WBzPbZ1mclW
X-Received: by 2002:a05:6a00:a21a:b0:845:2f67:a0e6 with SMTP id
 d2e1a72fcca58-84550b1a5c8mr15972110b3a.46.1782141292825; 
 Mon, 22 Jun 2026 08:14:52 -0700 (PDT)
Received: from LAPTOP-TMVMP5FD.localdomain ([106.222.250.238])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d68edasm7514146b3a.1.2026.06.22.08.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:14:52 -0700 (PDT)
From: Keshav Verma <iganschel@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 22 Jun 2026 20:44:21 +0530
Message-Id: <20260622151421.806-1-iganschel@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260618200105.3551-1-iganschel@gmail.com>
References: <20260618200105.3551-1-iganschel@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wbgMU-0006sI-2T
Subject: [f2fs-dev] [PATCH v2] f2fs: fix listxattr handling of corrupted
 xattr entries
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 Keshav Verma <iganschel@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Validate the xattr entry before reading its fields in f2fs_listxattr().
Return -EFSCORRUPTED when the entry is outside the valid xattr storage
area instead of returning a successful partial result.

Fixes: 688078e7f36c ("f2fs: fix to avoid memory leakage in f2fs_listxattr")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Keshav Verma <iganschel@gmail.com>
---
Changes in v2:
- Add Fixes tag.
- Add Reviewed-by tag.
- Add Cc: stable@kernel.org tag.

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
