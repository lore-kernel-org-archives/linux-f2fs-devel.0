Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB47BC282D1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:18:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tq6RM-0005UF-EG;
	Thu, 06 Mar 2025 08:18:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tq6RK-0005U7-75
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7JVmVF6h7A5QS52YJ/bDSraPZ0zT+UQnPc8M8WqkvU=; b=V1eUf53Aa2gey2oXzMsWO3Xytn
 0r+oSfkWelCJM8gB8Y84O69+HvJMJb2BUqw5Mfl0mkVM5Arc6VS92jI9u1wit7D3jKTqUUz7XDmkV
 unPY5RlMH4WEf7VL06QQ23gFZvQOHCgIJbKAiQwtjd2oGTosqGkq3dxX60t4vU3HUgqU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7JVmVF6h7A5QS52YJ/bDSraPZ0zT+UQnPc8M8WqkvU=; b=kzFilSYr5nZKku2vNWRtscG/2L
 28So+QPpuDGIi3Iwcw5xVxmsd+V65QxgaAV/UwdobDBV3qsaWlxY+Rj1zP6duvBRLfPK0d2zsmOrL
 fEnv9bG6DLyqWWhpLoy/OCfDS+t1JzUbRbCaG6YpKA5QenkaywBwp76ePDX8ZZ/PHDcM=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tq6R9-0005xl-JA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 36E20A43B26
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Mar 2025 08:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599DDC4CEE8;
 Thu,  6 Mar 2025 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741249104;
 bh=VrrK9AFZRA6UMEjtPkjMxvGnlxlx7x8Uy5ufhbEEAww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eFGp+6Txq7C8BnICguj+q74x75dKCWS+Eqkf5/rXeITQRbuKfc46W6tYpblbXDNSV
 YOuubn0U6KBU76sIDHvg92ijW43lMBDhPen0IECNhwbXXoqfGDU2Gu3iRKL7I+/yqg
 2zAeYHZtK4TygG1fcWXBOgg7zaRNjPxpGFjXxpEbSOuVS6YO+mOYqGSVhg5ItSWD0i
 yqTuTxF5qYa76N+5900ncDOOcdw+uY1rGwnDnCNNoL01jwA7EnnbfP2pwg3mCm/K9F
 u4mgOvN51p0bNlLhDPp2OYJ+KRETSM5/Itk2HW1piccKHznQnvRT39vTqN0m6hH1kW
 v1nuxWB+502cA==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Thu,  6 Mar 2025 16:18:07 +0800
Message-ID: <20250306081809.2397527-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tq6R9-0005xl-JA
Subject: [f2fs-dev] [PATCH 2/4] common/config: export F2FS_INJECT_PROG
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

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 8d3047a5..05f192ea 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
+export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
