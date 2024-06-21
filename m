Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AF3C27C4F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:27:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sKXkQ-0003LT-Ja;
	Fri, 21 Jun 2024 06:27:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Yi.Sun@unisoc.com>) id 1sKXkO-0003Jg-Jg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Jun 2024 06:27:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nbmzlt0otK1zbmsPwlHItgUa2gS69QDvx/UQq/N0nSc=; b=duQo5SgS1YaPy5UJLn7oyftyVR
 vFu2U6WPI2DmKL/c0rQtA02d6HXVYAfKQmUaUv1qP1+iI7MulxdpiJImRz5VZoTx4/f7XJLzHoNO9
 BFpNunO1rsFU2vRFMpvwTJD5c9OuExwPyzt/lFRGg6KV9dqQXMlSvTP+vcRWJUfuI1pA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nbmzlt0otK1zbmsPwlHItgUa2gS69QDvx/UQq/N0nSc=; b=i
 viP0X4jX6dhlrrFDsu/fZA8ClVtac0DQfsQpGTefUYVq3KYafEKi8JjIPOxB2i2beAFgSDNS6uR0m
 iTr2ob9Z7oyY4/QJmWVo++TvQU6ME3fblNNho4VzKuRTCeU2iODk25zNakGBSrGiv85CDF6dZeVgb
 IrtupBfisRAPBdUE=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sKXkP-0005cI-2p for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Jun 2024 06:27:45 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 45L6QUrP041081;
 Fri, 21 Jun 2024 14:26:30 +0800 (+08)
 (envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W56hP6fg0z2SFCkm;
 Fri, 21 Jun 2024 14:21:57 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 21 Jun 2024 14:26:27 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jaegeuk@kernel.org>,
 <chao@kernel.org>
Date: Fri, 21 Jun 2024 14:26:15 +0800
Message-ID: <20240621062617.595007-1-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 45L6QUrP041081
X-Headers-End: 1sKXkP-0005cI-2p
Subject: [f2fs-dev] [PATCH 0/2] add io priority feature to work and use it
 in f2fs fsverity work
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
Cc: yunlongxing23@gmail.com, ebiggers@google.com, kent.overstreet@linux.dev,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Many works will go to submit_bio(). In many cases, the default
io priority of kworker cannot meet the real-time requirements of
the work. Such as f2fs_verify_bio work.

If a high-task-priority process reads the verity-file, it is likely
that the high-task-priority process will be slowly because the
kworker's io priority is too low.

Patch 1: Provide a set of interfaces for temporarily changing the
io priority of kworker.
Patch 2: Use the interfaces provided in patch1 to temporarily change
the io priority of f2fs_verify_bio work.

Yi Sun (2):
  workqueue: add io priority to work_struct
  f2fs: set f2fs verify work io priority

 fs/f2fs/data.c                  |  5 ++++
 include/linux/workqueue.h       |  9 ++++++
 include/linux/workqueue_types.h |  6 ++++
 kernel/workqueue.c              | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
