Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7317C28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:09:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tqewv-0002Bk-1Y;
	Fri, 07 Mar 2025 21:09:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tqewp-0002BD-6n
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 21:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Giq5AvhxvXyZDpHL+WucKUWOE03rozJikSj/ob2YQ70=; b=B7/Gb5p/em+F6Z3s2XGrVn0DOm
 ERvcqQexMIXv5qYzhO8VgNvKsa1z6dFI5MNHAGSu+oQVsUOeGfXpnCAOkewUTeBBMYj5cEP047Wws
 Sg1JqEl0TgwYIBIFp5Ue8VQgzTZTePZwcpeAmDr+dURzhaIFrAb6vgZeitcCQ87Vb3tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Giq5AvhxvXyZDpHL+WucKUWOE03rozJikSj/ob2YQ70=; b=P
 qvzo8ZkW4vYmIDJLP/1trw6LBvL/+VQq/+AWTXES3B3quVWfDeiZSVML8n//xFID4hhHMBGgwi/YV
 UMBKd5QBq05fjFEPh8D2BXRFbOM6dVhmYgwuwQ8YaNSeZA//V/OoQBdXk6lqyOTANewtjbWLcZdD/
 jEwR9lu4wmD/ZqPk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tqewl-00021t-PY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 21:09:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 97B735C62E5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Mar 2025 21:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F334BC4CED1;
 Fri,  7 Mar 2025 21:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741381761;
 bh=ef8fwyq3WaomtiGQohA6N74PCqpWOCePsGXUPw2ICcw=;
 h=From:To:Cc:Subject:Date:From;
 b=A/jT7dgS9Y/GRoI4nm0w5O419Ay946oTLdcOtIqJQ8nAr1+cjB1ScZOE2sRYWrRqx
 O2XpKYOB8oFZZs+VTXLeKVeUr8J03KM2BuEWIWaTq/INwfDw3qMCa04s++Nkkw77cu
 bm+dt6/uw68alj5gCYERffElHvplusNcOtqpmcFWWZKAZmeuB62TGX32wB8JlTdNlr
 sQnM2o2XsLtGHdlUWPp1S0WnAW5+RTF+ao5M1fCOhbl8se9Pw9t+/SiX0rMwn5kOF/
 WLdusNtlnUlx3e4kVXOuenMPWaFH1brSPe+DxAKUs8wQ8yZZVYMetB6FUkLsppds7i
 jxzNTHnW0Y9hA==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  7 Mar 2025 21:09:19 +0000
Message-ID: <20250307210919.2728968-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
MIME-Version: 1.0
X-Headers-End: 1tqewl-00021t-PY
Subject: [f2fs-dev] [PATCH] f2fs_io: fix wrong ioctl
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index f2d0a0827ca5..21fd3864a20d 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -95,7 +95,7 @@ typedef u32	__be32;
 #define F2FS_IOC_COMPRESS_FILE          _IO(F2FS_IOCTL_MAGIC, 24)
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
-#define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 28, __u32)
+#define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
 
 #ifndef FSCRYPT_POLICY_V1
 #define FSCRYPT_POLICY_V1		0
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
