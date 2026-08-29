Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBE5C61DD7
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PCSnPq0jmZsRMk0fIeQQCC3kwN6cHKMBECTq9mMzi0E=; b=jf5nWWLA69s8B6CPNOePM4KBAa
	IWODf1kLp/TIho+q7BMJEFp3NcPhlVXGs0vWQzgxdudOYuZH2xGXRBhHXCoK7UfqeDeo9w5zcZOxb
	SXfwdPvUouFQ4DkfQq4aQ6X0nASw6mr1+fqny83abhKyvjOcKAvK1upJR9Aucrc3R/yc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0CCF-00061v-Gh;
	Sat, 29 Aug 2026 06:05:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x0CCD-00061o-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TkuG7a4t9AcWIusJS9uwYTZnKDwEZgSxcZyE1iPjyLY=; b=MvDvFAkbdRtFOEmLZCVwF6yDY/
 FDc50tkeQEZmlThZWaryipkuUTMf33df9o5akPZYcXFuaUGAldWT5qHneP6pDjHO7oI9WMSttaT5Z
 wNMb1IIaypJPGEkqp0aVvySQasx1tbNfPq4hfxzG0tHq6BPEEscOVwOZdq6RaPMc6bUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TkuG7a4t9AcWIusJS9uwYTZnKDwEZgSxcZyE1iPjyLY=; b=Z
 1ZGT1bi9j/vapWxD2BNeLeJXwy8xkHCSqOgxFhes6M9UsE1ybVZ+xOqKL7UzgAJH3B0M4oSCkrzUa
 k9PblpaK9NLJCnkUlcRgr8ZyBkieRPIfzHcuvoZAqke1UhUYbztvR4+1nFvW85s/5B+vE8QPaTmqq
 cBgbCE3XDgIrzsyY=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0CC9-0002GV-VE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:39 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-396b3d0df94so1733258a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787983532; x=1788588332; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TkuG7a4t9AcWIusJS9uwYTZnKDwEZgSxcZyE1iPjyLY=;
 b=fzot2zl+kNN6CKGi4ujwGLBbZskcRFEighEC4TK+RB1ZDu2CeR4Hj9+TXGBs4XVRCI
 ZeKmmeIHdlUu0FxWIbm/XZI3TIbBJRM8Z9etrpCpKGePSBsEMQtKZEKSaiaqVYvEpXFe
 +9/zt5rx1bTmROEzV3E1hIs9iwIBItXF14u5b9UO4BL7l8LpaP0bfm8Kye8GtMY7kWBu
 +8yAMn86qj8H+/EkgM9w6qoCeI0fb/jzFKTqDwTsL78ZY7cgSrUW/3agZjLtbj+w1fHD
 8q6816nYtM2YKVY6FyXtu80s1zLSZELM3PJJvadjvRjH15iuMbgrk30zA2GN7e64z+np
 5pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787983532; x=1788588332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkuG7a4t9AcWIusJS9uwYTZnKDwEZgSxcZyE1iPjyLY=;
 b=j6Ry59vhsGZikwwUYidv5Lw6Q6eofsCrQ2T40Ycv+UhoKA1F5RHY/0twh5REh5wRVI
 KjGFjn8jaKmzj4l7c23uETbUijmvfR//iROkxGricbZreV1AfSdax3XsBSnR0FA2z8CG
 c2FtyC0h2cMV31KIApHlffdJQc0XO6D2xddnfdCtDjFPHeaQUYRzvq4dL4qpCYpssFsE
 kTYOVEt78+Q8eTty770MW/mxt0kbB5ri0fMvB61EXSLLSPWiVMnsCz/xvUj37XSE5vbx
 WuP+0HxFF4FTrjagNXDZJv72DYSgZUyxVr5EdtL0T6fbZ7OglZ6wOk3egBvobDTJDPY3
 uWuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaSyUmdm+Y582HDFd1fmXs0W0Heq6gNys7paSfkN4OyfroKTIpFdAuNEa79HjLqR4jk/+yYU61nD9ZM3/q+c8s@lists.sourceforge.net
X-Gm-Message-State: AFuF++lEHjpAvXDFG+puSV49SrYndYZyIHOA4gtxaLB9dynptOOZC5L6
 K481eS971NRPwN2w2Wba1ZLRaLigHbBDf5nvpMIK6FPbGHYjRG5lhv6c
X-Gm-Gg: AYBFou2T39uWkP/e0BHINCde5iHEY9aUfsQtHN3TMxJPBBwe2OWavViVj2vJt6sC5zl
 AHDcjcFJRo0yL0uUwv7ZPvhSZWT9PYxinAbXIy9YLTkkIhHW9a7me9mGfXYd4f3M+/oUXBttCyF
 l+pAaYpmOTVD4x1e2gIZ8eGMSBmt1r71xYa4eXV8cCpMhsZaHEtIWcLZMHQxEvWYCPTEnUQ2WXF
 sKpCF+40IWg80OhRo58Mwtr4pPzb9VpT2KGHK52tLyQm3FlQ3cIcXQIyrljRelsAxIcCyZ0cP3u
 lyp4p4eDuGwyTbu42oi6am4mLb3NGUU5EwHjPB5sh61Xd/w3olwSXsKYQUQ80mcLDNVv6xjursA
 UgjCf/tleoDepwrK0u0Led3icmHYzPYrK+6aVKn8Jz+mY4V4TMaBJ7NdpBqZpQEd4xLZo4WloS7
 CujtJrr92sxQE+cWVGg7IUoTV1hsyEX2YrNiYfMwSVjxEfZb8TH93LkDZafAZvHxk8RTrMh5Dcw
 Y7DbrHzMOHN8ph5LMj72HTi
X-Received: by 2002:a17:90b:50cf:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-396d0ed78e5mr21704468a91.8.1787983532176; 
 Fri, 28 Aug 2026 23:05:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda36ed6sm5609411a91.2.2026.08.28.23.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:05:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 29 Aug 2026 14:05:22 +0800
Message-ID: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x0CC9-0002GV-VE
Subject: [f2fs-dev] [PATCH v2 0/2] f2fs: fix online resize state
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Online filesystem shrink changes both persistent SIT state and the
in-memory geometry used by pinned allocation. Two stale-state paths can
leave old information active after the main area is reduced.

Patch 1 makes the resize checkpoint drain existing SIT journal entries
through the normal SIT-area write path even when there are no newly
dirty sentries. Patch 2 refreshes the pinned allocation boundary after
every geometry change and rejects a shrink that conflicts with the
configured resizable tail.

Changes since v1:
- Simplify the incompatible-tail condition.
- Log the main, shrink, and tail section counts on rejection.
- Validate before acquiring the mount write reference.
- Restore compact formatting in the shared boundary helper.
- Recheck after freeze to cover a concurrent remount option change.

Wenjie Qi (2):
  f2fs: flush SIT journal during filesystem resize
  f2fs: refresh pinned allocation boundary after resize

 fs/f2fs/gc.c      | 27 ++++++++++++++++++++++++---
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/segment.h | 13 +++++++++++++
 fs/f2fs/super.c   | 15 ++-------------
 4 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
