Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1664BC28B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1trubb-0000xM-8u;
	Tue, 11 Mar 2025 08:04:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1trubZ-0000xD-Qd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FdDr/jZRFqrYxdexFRluuQTZGq+vwp4AAB++NjDbcDg=; b=ejQSJEhgLAP6oouA8Ex4hB5ccx
 QRJKI0B6NNGgWJzwEiKg3vKLHH50HXi3E/GtTc7Ami/nVgbDwmvuyFG/CZl17tS1CTLimllI38t5n
 3ZRprhtyAwyetyJJ2fUDanRRpqYSxSSxY//HTQcGdwnl2PkxIXVhFJcv1bwILX/Zm9Ak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FdDr/jZRFqrYxdexFRluuQTZGq+vwp4AAB++NjDbcDg=; b=io+fxaishKFn4qjb6HlDDt2zbP
 BZy7KfuX+hoPkXn4AcbIQglYG9zEUNty+j99/1L5W1ExaUqKSu9fVOLzZK2o/uo54eqYwFgwsuv/Y
 soA4zWrchPlwZRpXyXmOLkDc1YvPckJI84DfaISjnYa50XSbsBpnulea07KbKcV6DZso=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1trubT-00050g-A4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 28B245C54EC;
 Tue, 11 Mar 2025 08:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E172C4CEEE;
 Tue, 11 Mar 2025 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741680277;
 bh=xq2sFpKcMwD7O+8IUPL0qAjuOxbSP9sZA5L4A95ecbQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V1j9gKGWnVu0TT4SPUr9Usaqoml99nVWcf48BYRLQNPHDQaER0WHXRZQfCaok8R0f
 M+qRo8dMmyh/iE78KY/V/S9QKvale2+lGFFBUqE3dJwpphfpeZ1XZlIIanZS+M/zEv
 HCC8sT3vX9A6cufEKMnWMIi2W5unmw+WJDNBV1caVo4hwQCzdKvXFEM/KHl9RLgLds
 c0QWgP4dkGeGrgKxH8bj6cGcGR6bL/igPbDC6WIJspo+yOSPZC1BLpJwFhwOvVjDjW
 VFFbJgEZ3mCBZbtn++FOuhOFFFBQekFe4VlsDOFlcWvKD1TklytrrP2z43APenQDIX
 xYImm0+56j9Bw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 11 Mar 2025 16:04:26 +0800
Message-ID: <20250311080430.3696582-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1trubT-00050g-A4
Subject: [f2fs-dev] [PATCH v3 2/6] common/config: export F2FS_INJECT_PROG
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
Cc: jaegeuk@kernel.org, David Disseldorp <ddiss@suse.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- no changes
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index aa525825..7d017a05 100644
--- a/common/config
+++ b/common/config
@@ -316,6 +316,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
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
