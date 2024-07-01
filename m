Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DCFC2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:53:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOBqY-0005NR-TT;
	Mon, 01 Jul 2024 07:53:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Yi.Sun@unisoc.com>) id 1sOBqW-0005N7-Rr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 01 Jul 2024 07:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sgZupe72zgDiWmFMQzJ0SbPIB8lVo4ZJfv3SL4uVsDA=; b=S7vA3IZPQCoAGUlgCVbWtdSooB
 NqIZaP9roW/elx+AxmP3A302j63Bs5jCEGhOx/tt7cHj4WQK2MNtphFBWWPnrYeOD/xC3JPHnWt5S
 TY6+D62iL30xrwrbu3nYGs5OnAWfDlpVsF9Iac0900se9KmkoYsecXdz14cw/+SVItv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sgZupe72zgDiWmFMQzJ0SbPIB8lVo4ZJfv3SL4uVsDA=; b=A
 mt8/crPS3M94/RqAl2LKrWcMuMwWiDRdOVuBAPBSDdMgVoNUJECCtFAOHfV+YTSxKpHabyN8MLOxq
 aFGSGyqqvrVYcqSvry0aEvxIB+S5dR+qhS+wlftJMvuIGozfd+sIK3A/zwPdj6GO0KBSUvv3pOmjE
 GhWJXfhYeiWzXqAo=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOBqW-0006uo-Di for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 01 Jul 2024 07:53:09 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 4617pgek064460;
 Mon, 1 Jul 2024 15:51:42 +0800 (+08)
 (envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCJ5k4V8Vz2KKCbl;
 Mon,  1 Jul 2024 15:46:50 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 1 Jul 2024 15:51:40 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jiangshanlai@gmail.com>,
 <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Mon, 1 Jul 2024 15:51:36 +0800
Message-ID: <20240701075138.1144575-1-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 4617pgek064460
X-Headers-End: 1sOBqW-0006uo-Di
Subject: [f2fs-dev] [PATCH v2 0/2] new struct io_work and use it in f2fs
 fsverity work
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
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 yi.sun@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Many works will go to submit_bio(). In many cases, the default
io priority of kworker cannot meet the real-time requirements of
the work. Such as f2fs_verify_bio work.

If a high-task-priority process reads the verity-file, it is
possible that the high-task-priority process will be slowly
because the kworker's io priority is too low.

A new work struct containing io priority can solve this problem.

Yi Sun (2):
  workqueue: new struct io_work
  f2fs: set io priority for fsverity work

 fs/f2fs/data.c            | 17 +++++++------
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/verity.c          |  5 ++++
 include/linux/workqueue.h | 47 ++++++++++++++++++++++++++++++++++++
 kernel/workqueue.c        | 50 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 7 deletions(-)

-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
