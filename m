Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D4C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Apr 2022 07:04:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1naBKy-00065a-QH; Fri, 01 Apr 2022 07:04:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <yuyufen@huawei.com>) id 1naBKr-00065G-MF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Apr 2022 07:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8kb5xu9X4cYaGkl4fSGBV0WJ6tIbA7Li6Iq+RNHEoh4=; b=Op56nRjsVCeHf5dGiYw7hHfk4Q
 Jq52un0ThAy81olwKpSAPZierjJYJEDbxQD9EPsPX7o72eXCrD+v4RCnflpcKfD2vJQeEKjogA3ZS
 rU1ZWf7pOzO1nOhH0U1VHrCh8Vy8/ziqckLUqk+MvnFvMHthRmU4+CVrdzCbXJpfRBLw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8kb5xu9X4cYaGkl4fSGBV0WJ6tIbA7Li6Iq+RNHEoh4=; b=O
 aOIAi4nMD8U5XLpFA00vUI/m6NAemIPOchyEn1g+YSnxlyw/c+uXleO49l7Um7uFn8dtmeXG68Lh6
 m991AdU3vWtkwp+zzVrZA0hW8wEJCgrSDik3wH8NWcfrckc9R4u9HfTfyCrNobNdJojIVZBBuOuvb
 heGJ/NZk58r5QDtU=;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1naBKm-001YrV-Tp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Apr 2022 07:04:40 +0000
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVB3n2CpVzdZQQ;
 Fri,  1 Apr 2022 15:04:05 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:25 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:25 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Fri, 1 Apr 2022 15:19:04 +0800
Message-ID: <20220401071909.505086-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Headers-End: 1naBKm-001YrV-Tp
Subject: [f2fs-dev] [PATCH 0/5] f2fs: try to use common fault injection
 framework
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
From: Yufen Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Yufen Yu <yuyufen@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

  Kernel fault injection framework have provided a a systematic
  way to support error injection via debugfs in the /sys/kernel/debug
  directory.

  Compared to the current fault injection by mount options and sysfs,
  fault injection framework can provide more easy used fault injection
  control means.

  Thus, this patchset try to use common fault injection for f2fs.

Yufen Yu (5):
  f2fs: extract f2fs root debugfs to init_f2fs_fs
  f2fs: use common fault injection frmework
  f2fs: replace function time_to_inject by f2fs_should_fail
  f2fs: get rid of stale fault injection code
  f2fs: update doc for f2fs fault injection

 Documentation/filesystems/f2fs.rst | 118 ++++++++++++++++++++++-------
 fs/f2fs/Kconfig                    |   2 +-
 fs/f2fs/Makefile                   |   1 +
 fs/f2fs/checkpoint.c               |   4 +-
 fs/f2fs/data.c                     |   4 +-
 fs/f2fs/debug.c                    |  19 +----
 fs/f2fs/dir.c                      |   2 +-
 fs/f2fs/f2fs.h                     |  81 ++++++++------------
 fs/f2fs/fault_inject.c             |  67 ++++++++++++++++
 fs/f2fs/file.c                     |   2 +-
 fs/f2fs/gc.c                       |   2 +-
 fs/f2fs/inode.c                    |   2 +-
 fs/f2fs/node.c                     |   2 +-
 fs/f2fs/segment.c                  |   4 +-
 fs/f2fs/super.c                    |  82 ++++++--------------
 fs/f2fs/sysfs.c                    |  23 ------
 16 files changed, 227 insertions(+), 188 deletions(-)
 create mode 100644 fs/f2fs/fault_inject.c

-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
