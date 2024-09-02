Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DBCCD13CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:19:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sl49W-0002ob-8t;
	Mon, 02 Sep 2024 10:19:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sl49T-0002oR-0U
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Sep 2024 10:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UgGnQR7QZBLMtJurk5CvXWmDZ6QyaxijJTVXSV+YAM8=; b=a8XeEaVMmFFyGFJr70pJFDD79Z
 VWmVPTFKHj2FvmvyaZTmNGNC54cE5U/D9ksYahXscdQL8WBnf/OxLnROC1b7bUoMPvzOItpW6afXV
 mg+k4iIOKad9wR2dUl2aLhQuregjqhb56/lGnU+RCR2z1FXk9XNQ9Iym6Dj+p3jX9Qis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UgGnQR7QZBLMtJurk5CvXWmDZ6QyaxijJTVXSV+YAM8=; b=Z
 m2jfm8j/ROaD64PN5zy0tBEZYCqUc9Lf3TCecS0IhbsWFyM+EAtCdLkJjy886KP4kX41E2nYaa3gs
 DC/QwG88za6odI2pl5a20FsPuTKLOVp7J4uy32QTDyTBkoLOOC0/7Y+YC0Ii3iqPfwKBbskEB1kVs
 tYRp/52wgTfeyWGM=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sl49R-0002hx-QR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Sep 2024 10:19:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0CF87A41C6E;
 Mon,  2 Sep 2024 10:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361AFC4CEC8;
 Mon,  2 Sep 2024 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725272342;
 bh=iSO8NbaF0kFDuKsCNSKwzKt21e5E2/HlI7tcDkavf8Q=;
 h=From:To:Cc:Subject:Date:From;
 b=AMLuN3Grmj0UHnAc0I1DNfOKHS6MMn/9JDFLsBmztdI2+ysFH+XZTwHsT/6puthae
 EGMnl/4nV+p/I9eefm8gbXA4BAaYSk/r0GaJnEVCTt36A2TvreMwSQzzO684DW8IDI
 dj7/lQ+S+ianSiL1JiAxFfDi3BKa8esseHH/6Opku/WVBqx2ysMKh7s4kQDSI/1ANi
 vxtyI0QNbNIRdbkMbCwisbojsUIeDYQFI3uldcMV3IAwglrXwSVETK5SAglxgPyju9
 z2VMnMxjXvVjUhSP33IsoYm8XVHWPGKt/2THUYOBEYW5Cjx1oQTOMBhWfK7mFk/1hN
 3voKb1VesiZJQ==
To: Zorro Lang <zlang@redhat.com>
Date: Mon,  2 Sep 2024 18:18:44 +0800
Message-Id: <20240902101844.4042983-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sl49R-0002hx-QR
Subject: [f2fs-dev] [PATCH] f2fs/003: add missing _fixed_by_kernel_commit
 line
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The bug related to this regression testcase has been fixed by commit
b40a2b003709 ("f2fs: use meta inode for GC of atomic file"), let's
add missing _fixed_by_kernel_commit line for this testcase.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/003 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/f2fs/003 b/tests/f2fs/003
index 62821ed7..fbb08a3e 100755
--- a/tests/f2fs/003
+++ b/tests/f2fs/003
@@ -25,6 +25,9 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
+_fixed_by_kernel_commit b40a2b003709 \
+	"f2fs: use meta inode for GC of atomic file"
+
 _require_scratch
 _require_xfs_io_command "fpunch"
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
