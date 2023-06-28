Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53E9EB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jun 2023 15:04:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qEWiZ-00022w-Ko;
	Wed, 28 Jun 2023 15:04:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qEWiX-00022o-2N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jun 2023 15:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kblpPaMOMJ5krQu789DhNdxSi2f14Uxv7ol6nfeg8+g=; b=cN0cCoSRQeOsJ0RtB5PdmeggQP
 LT73yAKN33ukZ/iZTFqSKe1TncDTMB4k0MGQrYLUwQaDmYiVQKPT1tSSqLg/L5UAyV/fITG2gDlWz
 2FNjG8VfTYrgqPOqRpsjgKfZQVRcWQHQoe5NtDuSOxKLoRCQZebVFsG8U4bpzjUy83go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kblpPaMOMJ5krQu789DhNdxSi2f14Uxv7ol6nfeg8+g=; b=R
 /HmOlZYRN4M0jfBDX2SAvNmk5ZE20kNAFLiQpmbGSfv1Yt8w4PEzHkzfVZSuejgBtyjVuasmfIwHo
 0koGPLhTEOZtSCZsk4hGD6lwI43EPp1UChCc8TTRG3bFn4izZn+MvIj9CSzej5qINconUoCrTcCF3
 D0sQUaV8kho+n6cU=;
Received: from mga17.intel.com ([192.55.52.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qEWiS-0007Q6-1I for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jun 2023 15:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687964660; x=1719500660;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1gfH1VI8rikXgJa4+jQmJEeCxlL86Kd/v1XPUYZdwvk=;
 b=V6A6cgSfp9MN8e7frpb5utdIokPImNOrjsSceaw/0cDb8h1QDT/e6fUz
 xRro6U4VfOzxUpmm3VdG5c59JPu+CxGmm4Z74uajLcJoRPc2UIkYqJMgr
 QJOLhiKd7AfgoPjmbvbeTwoZVu21tLxbxQhj7df2HykcSAQMvSNPVBSD/
 rBI6yssz75JpaHacn2DWw5ErWqWfUPJuA1d07cnhE0udOpsLMztcIJ1KA
 nqUapBM8ZzQfwL+oRpOL+eTZ5+fkkoo9Hgd/87VXqlDAEjZrvmEpKNYiP
 OST1lDQz2nRtsztiDy2Gb3+E7brss4lpWtcvi2SKJKFGkmcLUh/w0ub1D A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342206007"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="342206007"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 08:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667159873"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="667159873"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 08:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 63569E1; Wed, 28 Jun 2023 18:02:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Date: Wed, 28 Jun 2023 18:02:43 +0300
Message-Id: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
X-Headers-End: 1qEWiS-0007Q6-1I
Subject: [f2fs-dev] [PATCH v1 1/1] f2fs: Use return value of strreplace()
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since strreplace() returns the pointer to the string itself,
we may use it directly in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/trace/events/f2fs.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..f5994515290c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2234,13 +2234,11 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 		 * because this screws up the tooling that parses
 		 * the traces.
 		 */
-		__assign_str(pathbuf, pathname);
-		(void)strreplace(__get_str(pathbuf), ' ', '_');
+		__assign_str(pathbuf, strreplace(pathname, ' ', '_'));
 		__entry->offset = offset;
 		__entry->bytes = bytes;
 		__entry->i_size = i_size_read(inode);
-		__assign_str(cmdline, command);
-		(void)strreplace(__get_str(cmdline), ' ', '_');
+		__assign_str(cmdline, strreplace(command, ' ', '_'));
 		__entry->pid = pid;
 		__entry->ino = inode->i_ino;
 	),
-- 
2.40.0.1.gaa8946217a0b



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
