Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EDDC35FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:59:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tx3rx-0004ek-TJ;
	Tue, 25 Mar 2025 12:59:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tx3rw-0004eQ-6V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4owFGDHGFII1nn+MJNhXXplCkn6+PQSJK57ZEeACwo4=; b=Whi2DX1CN75eVVAzX6h6xbu8Ll
 8EhCMOPl4ctgVVzsCqNAlwBkajAL820frCwLWAlgTg4nKtbVSICZPJGXDNcBSpY1nHmkoOeDBy1oz
 9ZXwPfZaDwpvz7L2oTrsh0+KdqMvtIIYQ4V3TugjlUz5OupmrRRPwPBe7s1ZwiEezrRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4owFGDHGFII1nn+MJNhXXplCkn6+PQSJK57ZEeACwo4=; b=Om7+yxrXDDjrdC1bfTBzSYtPD3
 IVFWrGfK7Ruf7lJM0tTB2Q110S+jU7UtNvIgr0873OLtvA9GnP/46qQJsP2ijrEy1rfltvlxOFrjx
 51s9szTCw6mwnx8xoMHKxLE5Z1GgTggb1xSOyV8z/FliYwR/42C+oyRBpmTE62WvAdZY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tx3rr-0004AR-Cc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:59:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0FA375C5F0F;
 Tue, 25 Mar 2025 12:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4798BC4CEED;
 Tue, 25 Mar 2025 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742907524;
 bh=5VTc25eco32/jJpLDGVrxDEmip6J9yQmzC0ntM+IaW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KomJ+VR+P1yXuLnJB++XCYLC0x3Xa0BhnyumNnCUyl4rCDC3J4yyYcBnxEs3IYadb
 2KXCOUUPUklnglYzk9u36kGbQT06i6iihgy+ja2t/zMResmuH30168jBn+xS5arWn8
 U3tuwinI8bMaH6NWRiJvQI+yy3x8a2xrTtgCYyZ4rC1hXF3AeTgVZ/uVrmj6oq0Aa3
 a6kIjTUaXN5ZusHC7ktP2uFzpciHOfA5FLeizq+t1DADqdWKQlDnk8Zwr//Hift9lG
 zwd6Otlt5SHftBEd5KFFDLR3SnCkfXkIuo2v4mzVvibw291qSDip1uexfNH6+Lc0yy
 onLjQGaL4Qw5g==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 25 Mar 2025 20:58:20 +0800
Message-ID: <20250325125824.3367060-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tx3rr-0004AR-Cc
Subject: [f2fs-dev] [PATCH v5 2/6] common/config: export F2FS_INJECT_PROG
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@redhat.com>,
 David Disseldorp <ddiss@suse.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
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
