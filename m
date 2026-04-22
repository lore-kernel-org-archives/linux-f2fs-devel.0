Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CAF9EDC6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EvNXwrg8fYD0n82qUxleqJG7IghLnVfIrjbibCOzW+M=; b=LkXDk57VMSQaeW14KVmOJ/lhB2
	koYXkQBxNM+czTyKi6iISUrweTESsVyxHF7949cmq2dok4+GmCtZGcCD8L9LqFjn8JxGUIi2x7SjE
	v62rFBdrQ3vDzs5Z0JDjMiFDYf6FAPePV5zBVdlUgtomBc+mFugOg2QOqtpvrN/2rUoU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFWt0-0006dy-Tj;
	Wed, 22 Apr 2026 12:40:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wFWsz-0006ds-FT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 12:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8fsjCmetEZmz0qqYVXrFd4J1zzadDeQalQIxEPQVgY4=; b=dtKPDRQQUm5ZMbZLUOoYl0U+MP
 vFui9w92hKj27mBTh/dxDwgxkZ5Psg/MlK1doSo2yN7JeX5P0TynpJ7Tk7u/LXD7Y7sMqjB9JH++f
 D3FX0oFeBk+45CDP0odLeYQcr4gUcm6nzTmALLO4oZV+q/dcymPN5bdsvAszAx8Z2W4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8fsjCmetEZmz0qqYVXrFd4J1zzadDeQalQIxEPQVgY4=; b=h
 FEnHlYMQU9uoI59YPbI4ryEm7sgciucXqN2bcOGqwzgfvLHgECP/T7n7dDooVwbG97lbcltKLoB4Y
 /rYRUmBHMVHyWyf6gFitwuKKByK8y/axXw6cGIlQjKCOQAO4zm5VupgMBEdQZWKKx/CfswWBsdNUE
 j7evoymHewB/kG/M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFWsz-0005s1-4u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 12:40:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BFC1E437CA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Apr 2026 12:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A320DC2BCB4;
 Wed, 22 Apr 2026 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776861646;
 bh=jjp+IM2CvF+/Cq3DgQxWN9nCOub38O1J9ctC7sRjejY=;
 h=From:To:Cc:Subject:Date:From;
 b=Vcow1XCwk9GoVrMS/v4W7kYWERVBplW0xMkZhAJTAr+ixbRtzgSszojHhTRMAvMKN
 CR+4s1MTj6Zl5bidxOXyNmnGld8INzrQdpHp5VU94JWtRJJVaCdtwKJgX37Mvmd/Ig
 3Et+LrrCHm9RZdQSp9eGYYpsNWlI/o4eTTtxZ+PEYRfEmjsxA6FY78UNJsrWJlsUek
 pZ4jP0ecNBcHBGPJIXGuhNl8njbTK9/zhO718muH0y8+bLnJUPnIyAfnbuNParNYsd
 vyXK8WJKiGIcHF2LyoOnjQPizi9+YYMIM9QarR9HJEID5CGVIT/zvi9ONmx+8GjV0I
 aYytfbQjVIQWw==
To: jaegeuk@kernel.org
Date: Wed, 22 Apr 2026 18:48:47 +0800
Message-Id: <20260422104847.11243-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1wFWsz-0005s1-4u
Subject: [f2fs-dev] [PATCH] f2fs: doc: fix the wrong description for
 critical_task_priority
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The default value should be 120 rather than 100, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 27d5e88facbe..1b58c029abd0 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1001,4 +1001,4 @@ Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It can be used to tune priority of f2fs critical task, e.g. f2fs_ckpt, f2fs_gc
 		threads, limitation as below:
 		- it requires user has CAP_SYS_NICE capability.
-		- the range is [100, 139], by default the value is 100.
+		- the range is [100, 139], by default the value is 120.
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
