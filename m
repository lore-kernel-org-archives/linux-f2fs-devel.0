Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3EAD7830E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:42:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tI4oo-0002JV-6D;
	Mon, 02 Dec 2024 11:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tI4om-0002JP-UG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Dec 2024 11:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VzCKyn3kipdrQKkmdpjzPMEvjuaa7ZFd20pow5cmRcE=; b=KHEJD/AMpCjoYNWZJRiD4B2j4E
 2YkICX0kvQS7ZrH2ak1BrofAiFKYiXFzpGSRdVHfutD6kRiWmlm3uPgDDHdqRFW1AJajKud3kpmbW
 FeyJTJkPoTIWkK7sFTQv6qE5PEJZ1qkhloW5FKukucPsdSY0WiBsasJifA7ZmhJGJb8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VzCKyn3kipdrQKkmdpjzPMEvjuaa7ZFd20pow5cmRcE=; b=MYpkuo3TrdhQt1DHu2Q1ymjPvh
 GUhxy3xF3GLixbzWKapy7eySdPAtVnFhF0+tLgBJfMAup5EorEcO6vb9fswGrA7ounlRPQSzedH4I
 iOc75x9MRKLBoLGbYfpZWMycipdReG/8YPXpbtfo8HX3QWK0Hooy4+LOK64UNZFCU76Y=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tI4om-000627-9Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Dec 2024 11:42:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 40CF7A40B40
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  2 Dec 2024 11:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF1C4CED1;
 Mon,  2 Dec 2024 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733139729;
 bh=Nnyh6xskfE29vfL92J+XXFzsEGl4lmpiruvLoSERMBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h4I6b/KzQHaGD2AYRELrgNM77ONY6x65fBPMeuTHqPuvJ512xcAvfNUpV0B0lLDs4
 0VpaDo3fkgg2Dq1fHTgnF3B4AhUnzCZ5V8Thu7RJhS59l7H8uyRW4snzuJ5WU3fUFv
 KmsLAn/zvunikO+F1Ws5vZ1pmPVDYqxHp552k7vJY7To/YmP0fV/9kYI8u5yKH/7+L
 lGTDpeKAsSezK8BYn3MHXyuH83qHgAJJZox4tazWkbl6bMQhxIAnpVVP4V3q3YRR/x
 eLRk3QNNLZBk6wRF8wCpOkkbwnl3SwdB+H8fphpmot5AEl/5rCpVmy6aSsJVx6auDb
 5gFDHyLCqa/ig==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon,  2 Dec 2024 19:41:49 +0800
Message-Id: <20241202114149.2666-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241202114149.2666-1-chao@kernel.org>
References: <20241202114149.2666-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tI4om-000627-9Z
Subject: [f2fs-dev] [PATCH 3/3] f2fs/007: update commit id in
 _fixed_by_kernel_commit line
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

The bug related to this regression testcase has been fixed by commit
26413ce18e85 ("f2fs: compress: fix inconsistent update of i_blocks in
release_compress_blocks and reserve_compress_blocks"), let's update
commit id in _fixed_by_kernel_commit line.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/007 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/f2fs/007 b/tests/f2fs/007
index 6451d4b4..37388433 100755
--- a/tests/f2fs/007
+++ b/tests/f2fs/007
@@ -11,7 +11,7 @@
 . ./common/preamble
 _begin_fstest auto quick rw compress
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 26413ce18e85 \
         "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
 
 _require_scratch
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
