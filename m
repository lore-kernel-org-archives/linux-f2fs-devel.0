Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF926C28B30
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:57:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1trblL-0002NP-US;
	Mon, 10 Mar 2025 11:57:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1trblJ-0002Mz-Ad
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Mar 2025 11:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n1SYqmiRigAhX3ky3bpyclHDRpqNduXZ6RhADw/Y1cg=; b=ZvEnoC45QbNxfoMIBLH61kGoqG
 Hz3K81GWZLcXCSEHey0rYrD1bI4biz+eWIcXlItdi6SgnZMt6Cx0Cb2pR2SDXPoS/rzo8eLdyyH5u
 lSWj5W1dQBjNw7Zvp4GcvRVqQC2KLJvYBKr6BYGMKJOVtEoYWHh7O94CKgnYS5BJzUbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n1SYqmiRigAhX3ky3bpyclHDRpqNduXZ6RhADw/Y1cg=; b=e
 6YIvnZbxxS8WoTLm9r7Tszd3By1huyMWNqIp967s6b4SGCir143q9Ylj53BsXc1D40JtP75kejZTw
 p4k9naYYTpUBB7NV4bOMLUrctr67PULpnDauhgi6STYJWvuEBfCgCvhiyd6BvVG7gXCqj0E9TCKGH
 U5HZUc5tIUu75oIE=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1trblA-0001BQ-Mh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Mar 2025 11:57:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C049EA45A9E;
 Mon, 10 Mar 2025 11:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F6C4CEE5;
 Mon, 10 Mar 2025 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741607837;
 bh=2i2mVcUoEEJErWlRXsEieReXX6af21WasR5ug/fmQrQ=;
 h=From:To:Cc:Subject:Date:From;
 b=q9//8GiC26nydhcUzbdirCDMSSATbA8Gf0gTX2n8IR4PLTeWNhCS/2C60KvYh7Sid
 XC4njpdwFpX8LPEoF14n6RuJuZxwAfxzU+qi9ZRjepsv6VhSq1fsn0GAlOoakTuyyy
 e9SJnMm77X3nfveHZIdW4bUgAUi4tDiUeB3c5xZ14a+aSQunPjTfUwubbL5zQHxKSi
 eyvkJTp6TG+pM/bMla1tCCZG4wUPBxR4+F9pguVK6ir3fS0ckDaXf50iMrwUaMZ2qS
 A/Prl1lYHVAyCjxaQnvOI3uN+Nv/ofeWmdPUO7hViLS7sHhr6uUKGohwP0RJKD5RbS
 iRjD8evrP9h7A==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 10 Mar 2025 19:56:18 +0800
Message-ID: <20250310115621.3441518-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
MIME-Version: 1.0
X-Headers-End: 1trblA-0001BQ-Mh
Subject: [f2fs-dev] [PATCH v2 1/4] common/config: remove redundant export
 variables
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

F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redundant
one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
v2:
- remove another redundant export variable
 common/config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/common/config b/common/config
index 2afbda14..aa525825 100644
--- a/common/config
+++ b/common/config
@@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
-export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
@@ -220,7 +219,6 @@ export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
 export THIN_CHECK_PROG="$(type -P thin_check)"
 export PYTHON3_PROG="$(type -P python3)"
 export SQLITE3_PROG="$(type -P sqlite3)"
-export TIMEOUT_PROG="$(type -P timeout)"
 export SETCAP_PROG="$(type -P setcap)"
 export GETCAP_PROG="$(type -P getcap)"
 export CAPSH_PROG="$(type -P capsh)"
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
