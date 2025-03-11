Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B76C2BA1B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1trubT-0001fX-NZ;
	Tue, 11 Mar 2025 08:04:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1trubR-0001f7-LD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2XsY/TVS4JcmFJw8wMzPE6Bgd9QegUSOdY89mtXoEuk=; b=IzuZIhWjunEm80q4oEFAmzKjxY
 mK5jt49iepxfGxeFTcijHYzfBl/x0ZP/HBXtq9XxC8Inu7YWw0gMhjz7tgv4ow837+CQLc0Z/Nz4s
 S2tew3Y7vPa1jZVTZ5XZdLpf9bQ+AIkpUUtqAi2OgQUdKFctmHuH25CSj1y6UiUIxK9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2XsY/TVS4JcmFJw8wMzPE6Bgd9QegUSOdY89mtXoEuk=; b=P
 qCdkf9/WBXCBsIphFl7ruwD4BT5uf4PAoCeXMFx1K6QIX1HAd8RFLe+m7IcUmO5WkINRBHHuPAzKk
 Ke5P1Nqxl6lPKE3zpnhX2NEsIEYYOyU5RX4s1JuQvxiN081Ml1lq3dYv8i7jWN0efZif1J1TQWrVL
 HAYwZLvkIhpBoLBA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1trubR-00050P-II for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6359E5C54BD;
 Tue, 11 Mar 2025 08:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF0BC4CEE9;
 Tue, 11 Mar 2025 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741680275;
 bh=G1iFw1mERxQm3fRA2+x+GlTb1f2Yl2TewlO/Q3TPSY8=;
 h=From:To:Cc:Subject:Date:From;
 b=ev9BahO170rBcAZeAFnyHRY/Hn+ck2U4yhox6OA/yW/3IIeQd0CEbNEwfeh00YsO/
 0m5oGkSfu8qgF+RtrG8dTW+TwzEwpdMkCos0aFKXqXEXP4tmGkpWD5vgwqOBaHz4IM
 Sq6eJXlp7uf4iPXBZdY9BaTlnmAAaZFAjME8kB/JKKRoa0R6AaFB47VL2nJtuWpHRK
 pyumX2aW/i+nMWPFMxzuD/Z1rfiO2t4ed/XrWOYZ1wgyXzbYuRwKcB0Mu9ImY/WGg+
 3I2N4FUdeckLvKGGfba5SgymLIBio5TKBqX6FtB9ThpN3+89rHYjgFXSjq3osmPHLd
 RBbK1AR4nNs3g==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 11 Mar 2025 16:04:25 +0800
Message-ID: <20250311080430.3696582-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
MIME-Version: 1.0
X-Headers-End: 1trubR-00050P-II
Subject: [f2fs-dev] [PATCH v3 1/6] common/config: remove redundant export
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@redhat.com>,
 David Disseldorp <ddiss@suse.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redudant
one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- no changes
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
