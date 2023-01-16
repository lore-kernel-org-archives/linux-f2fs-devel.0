Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA0AC46467
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Jan 2023 23:25:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pHYqq-0005PK-Ab;
	Mon, 16 Jan 2023 23:25:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pHYqp-0005PE-5C
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 23:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ne21Iv6UNcm/Oe/7CbpdNlhxgE0y7ZpW9hml9Q+o7kw=; b=fHR36G3K31UACKbVmOFvKiWmBi
 dkMOMVsXarZU/QUN+VzG6JpAGAVHbcWXZ0WFlyYRIbvqXOO98Lg0TBNGEmR2snjp0vSWTACcuXvOG
 Yukb3+Ldt4XYdUTWMTtLyTtqjivG3yLfaSfpKTsKco3bU2I4YlkxY8NQ5V/5YAUWbFtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ne21Iv6UNcm/Oe/7CbpdNlhxgE0y7ZpW9hml9Q+o7kw=; b=L
 wKjUIcWNbLSeFZmGH2GXOuxc5tjWKe0jzo6Hr3vSXN0v24bTTQFs0ICIWR8ZeDOitkoUdO2pPbWSR
 PwPNwhHh/cUPelcplsoL0cMI56MBMyJAi/F1sm8TNG8xWnnkywArrz0VFTvCsfZf6S/20Ob7tUNTS
 xDxMdPYHJEfXvlek=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pHYqm-0007mK-K8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 23:25:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3418261057
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Jan 2023 23:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E75C433D2;
 Mon, 16 Jan 2023 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673911506;
 bh=ojZWPHS+IIMGuPGnsOHsgYoO/oDNhc0Uw7ZucK6fAJY=;
 h=From:To:Cc:Subject:Date:From;
 b=kDD+2LFrJFCh3ePeNzs/Ts07X6vxXzYMyoJjykhG5iXLBNj68HmB+m7WG96biPCBp
 kLBEWy3QjKnNO42SCANr2y+x79f6wSTo2BRebmeUGelYS5kQuV0vd+jLnObLfBudAl
 IPWdrYrTQzI7JOnFYVI/vBtJT8dzcVQVu1Nnj7MP0IRFxHYqCpfY/Hbqu9nA3QH8ky
 VIWIbPdJlje6MR2YvjEPU5itLKEQj+ZXK9jpD6MPrlKvHlBZuPOvHuzGO9ISqMtver
 vPJ788IVDsfNEyjVN2CYos8IRjKwIWDy24swBdTxaEFJkYrkRcdCckrifqlqPb/NT/
 uHIKJBysLZNzg==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Date: Mon, 16 Jan 2023 15:22:57 -0800
Message-Id: <20230116232257.64377-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Headers-End: 1pHYqm-0007mK-K8
Subject: [f2fs-dev] [PATCH] MAINTAINERS: update fsverity git repo, list,
 and patchwork
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

We're moving fsverity development to use its own git repo, mailing list,
and patchwork project, instead of reusing the fscrypt ones.  Update the
MAINTAINERS file accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd7..936cbdbc60eb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8520,10 +8520,10 @@ F:	include/linux/fsnotify*.h
 FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
 M:	Eric Biggers <ebiggers@kernel.org>
 M:	Theodore Y. Ts'o <tytso@mit.edu>
-L:	linux-fscrypt@vger.kernel.org
+L:	fsverity@lists.linux.dev
 S:	Supported
-Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
-T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
+Q:	https://patchwork.kernel.org/project/fsverity/list/
+T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 F:	Documentation/filesystems/fsverity.rst
 F:	fs/verity/
 F:	include/linux/fsverity.h

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
