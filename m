Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE588C282D1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:18:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tq6RA-0005Te-2U;
	Thu, 06 Mar 2025 08:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tq6R6-0005TV-PK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XGuJ/t9TD+5Z/+PQsN6fHgQzbJ2+TeC6q/b0AdBg7N0=; b=FcpFRLxWAFIZgU2CcaJdJJzzyk
 NdA+SQJdMuBmgEqDU8SSEbSsVbMlqvJ+gi2ejpvcSEqV0sJ29JAsFAr/YB3u+yAKaNggnngeuam2u
 GOxg0HCiyNY+vdzyhntw/4sloS5BzLnagzSjNdyUiIakCMkuUj+84KP6uSyJMOa9z6VI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XGuJ/t9TD+5Z/+PQsN6fHgQzbJ2+TeC6q/b0AdBg7N0=; b=LvKIdLixe5L535f5b8wREoNheU
 xVb9Tv1XVZQ6IIbPWKCPw5M4QMqY8wqJeOh1XTlpnDHz3eCvF1zsvWCzo+8r9Gfe/a2AIGAuh6VGW
 Pi6jRb1V9WSoW/bza9Bo/CeL8mTQ4q6/b2Prew8wKjCHYP98B1QA6OI+FhMJHoAd2xbk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tq6R6-0005x9-7P for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0E9EF5C41A4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Mar 2025 08:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A14C4CEE4;
 Thu,  6 Mar 2025 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741249106;
 bh=97X0iTZrxA/2Izvuw1nyHZZXtS5Ddl1KNxKm5csh1Uo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ld7GnxgCCzksyPfDkq2XceIM47ieKhQDDLYbNMZOqtcwR5EzLWbIdMMvNneGlSds6
 dRKHcbFsvEcMXMpd6QlzRZ+O1hozMilMaWU1cg1dnPltUP05775+azQtwFhoe92HaW
 0R3Nnab8/oot74uynJTeHt1G9TkQWlFlrFWDeHz4F6KVf/o0T5i86prtomfYYadiwN
 gEvDKI6IYCGSzRLKm+pWNuzo6+rQqRXzkvSNsZ3eRSAepIaK83qDwmi59KJPfcX9lY
 mEzWKqG+eNZm/EdraDPCd0k7Ujau/VKKr4+dXPw9loKMyNBLOs6Veg8jaoMWE4WXuS
 +xFKcgrist/Ig==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Thu,  6 Mar 2025 16:18:08 +0800
Message-ID: <20250306081809.2397527-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tq6R6-0005x9-7P
Subject: [f2fs-dev] [PATCH 3/4] common/rc: support f2fs in _repair_scratch_fs
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Support f2fs in _repair_scratch_fs(), and use -f to repair the image
forcely.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index ca755055..bf24da4e 100644
--- a/common/rc
+++ b/common/rc
@@ -1500,6 +1500,9 @@ _repair_scratch_fs()
 	# want the test to fail:
 	_check_scratch_fs
 	;;
+    f2fs)
+	fsck -t $FSTYP -f $SCRATCH_DEV
+	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
