Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78672606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I6PekCpP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lo+Hc0lf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gXdNGNXo;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqKRgOQr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=hooUZLH/9cVGiqbYjqUhf5Hl5NJuLB4kV9KVapwinN4=; b=I6PekCpPcjNBfVSMZfI51+KD43
	DofqNItUnMMiSKOAYaysdUVu7xHKOs1N+ROU3uWB5KkOrL1uSytcyqv0PYs7MtGxejBox/rro3FWT
	PZx/gNhhrMJ8EN+Tbqu/a96xq47k6oIa8orgCnOYuOC3UF/IwkFEAYb/uRAYAUfxR5Hc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW7cK-000000008Qh-1tFQ;
	Wed, 25 Nov 2026 07:40:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xW7bu-000000008QM-3ZZZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 07:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=; b=Lo+Hc0lfOEqByCnBnR8pB/94Qj
 EQiYMDZz7+0GRtViN7+OxRgyXFj1GKHmpAYFa8OHNL6jN5/+KTTnM4nuWMktWsvjchA5jx+tl+ZZl
 gUf5TBxUCkNo93flBN7Bbk36fVbs4SE/sdgH7LBqFcPxcd53tPfLB6GPWyfQ0Dqa960s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=; b=gXdNGNXoD6GZIbc+wnQ+EwPXUQ
 XppEBJ85AgtTBalnghBAT9J86TIYQ1TB6qHC2QmSUD9Qe/+WRrvIzYuCPzQ1Y+Rmjio20KMaWieoz
 lK6t6a7jHGXaqvoQxhHFlOWibERJeMZ2fNq4FNLrlGUVCHmXFVjUC1Ve3FQ0aZy4Ljog=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW7bs-000000000kA-11LJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 07:40:10 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso2460309a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 23:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795592402; x=1796197202; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=;
 b=pqKRgOQrfwskWAuFyEq1gEtiMrKcTaXHMLsKKkr2SFf0liCFvcK+wWALF8J30zB4RN
 fuUow9kN6dNqPw9JnpFbDR2QyX0T21k/OHw3IjlAQV2dumfQpccz3qnF7B/pnYQyro6P
 HXudOjGIbGvMpMxnitX4w07igpCaMKWR4PA3ajj5OrIUBA0RC63f8ULF+E4aLh9Vg2zO
 VRZVrcH+rbJENRgU/n7sauZoNMB0opSk6KekthN1eee3HywfcnuJ6l07OyF0au5oTSiy
 8mzV+gm8GT/I5oG5nnuh33wQAa9ol/sHb+oliFdQ9pwJGDc0UlcOUMg6ARTyYGRNFRg5
 nmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795592402; x=1796197202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=;
 b=rF9lVq1t5MxOJsOha7dzlCMw0xFDK1d7/NyZxjzrBV3/RCc03Lgaq87JmavpNd/HOd
 0pevGj7kqWnp5CKfGN7ZLQddZk1DZOM+fhCdbl5TvJvjMhrdwKvtDeRzlHHz3zIG1qoz
 DjaRm2dWWNnb/hgAgOHC3/WYaol3X3Il1vAWnCS9bzkAjdxvR22iN9AsmnIi05oTAkm9
 8Qs7PsqXwduphI4UXCe18+ic6bzo1OSUwyGxJ+RGXRdxdP3aSxhJ27WhwC71H3zBehx1
 gWor9K6hqvaMGOqAmCYVeD5lut4pdqcqmCeM7NxvbISqPacyx8BvM1/XhLreSW6x0Lly
 GoBw==
X-Forwarded-Encrypted: i=1;
 AL+hErFJRPcKmn2JIQQyjPIz9OY+zOhEA1tMTVF062gFRqAIOXjCE6LvW8KpqfjGjBqunrCoT+yl1eF+F1ZJ53lo+L0V@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8bi0rMBS7Iv0wz5sm6/fu5YKM9aSfL00g5dikRqIm13Sz2YuYb
 9HVmwzVlmnUp8VGXRz6FOuB65DH5CWu+mnZwJD54DEp4IZrrTF72KV9s
X-Gm-Gg: AZFdTZeFEvqDo0boqhT4iprjqLfERHHNuCWIbz9lj37f9RSQxFILm0U5RBbCzxAntiW
 diCrlAWe94Pk9G1chnL3UUG6EPf+8Sssx5/EUv1QnC4xJC4zS8bPGysMb00H3xw0+EiEPtVY4vv
 s2hfgaGAu3Tjo8QFJeZep2D1wK65egKtZqkwYsF07H9LONhKbRi1ADVAC7SWIhkXbAeROhvlUo0
 CQm5ZkzuLEPhvsN3Gz5gPtGYUUG/hUUvzqYK+MI2hDZfGd5VB2obmBbIt5YovcgZhn+e5xTPRur
 j5W3nVWCOF3CKM00kzRNBwNlpbKacWEGIa0AcBDe7fPN1XzkE3wTjjYwU5aMw19cL04EBtXaIRF
 iO/vBauJr+IROc2y3KcomV0dqa7WTwI4P++cGBpTAS4+7YArHP9yhVl0+mKCpWCmLQoBMkBhmVh
 mULtV5WtieII0MoOqyTPFRAi4rv7hDloBqBWEhmHkgU7yFn5cAhDfEZXI4tSWAF66PzV3v6qGQO
 cIpFj+yGj7OSKPa79+D1OPjJuOXQQOAdNEwGK1HP6SewuYXRx3UXWQA+w9FWVd2gVnfiP6VagaE
 xy5JuhY2oqwtlRN8idqMHbvtm+XNI3hYRaPmlc0U+ij+Fw==
X-Received: by 2002:a17:90b:48d0:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3b41c96cef8mr16857502a91.58.1795592402400; 
 Tue, 24 Nov 2026 23:40:02 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41abb2076sm26773960a91.2.2026.11.24.23.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 23:40:01 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 25 Nov 2026 15:39:56 +0800
Message-ID: <20261125073956.2927907-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xW7bs-000000000kA-11LJ
Subject: [f2fs-dev] [PATCH] f2fs: don't BUG_ON an inconsistent node ino in
 roll-forward recovery
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: yangguikun19@qq.com, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

do_recover_data() asserts that the ino in the NAT entry of the node it
recovers into matches the ino in the footer of the fsynced node block.
Both are read from disk and nothing checks one against the other
before, so mounting an image with a wrong ino in that NAT entry hits
the f2fs_bug_on(): a kernel BUG with CONFIG_F2FS_CHECK_FS, and without
it a warning, after which the NAT ino is written into the footer of the
recovered node.

To reproduce, create a file, sync, write and fsync it, crash, and change
the ino of the file's entry in the NAT journal of the checkpoint pack.
The next mount gives:

  kernel BUG at fs/f2fs/recovery.c:698!

Fail the recovery with -EFSCORRUPTED instead, as the ofs_of_node check
right after it does.

Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_5CEF90115E2715D386A8349FCA28D7D4D607@qq.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested on f2fs/dev b61a029304bb with CONFIG_F2FS_CHECK_FS and KASAN.
With the ino of the victim's NAT journal entry changed from 4 to 5:

  unfixed  kernel BUG at fs/f2fs/recovery.c:698
  fixed    "Inconsistent ino_of_node, nid:4, ino:5, 4", recovery fails
           with -EFSCORRUPTED, the mount is retried without
           roll-forward and succeeds, and fsck.f2fs reports the same
           mismatch for nid 4

The unmodified image recovers the same way with and without the patch.

 fs/f2fs/recovery.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 54b5246609de..c92da18f553f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -695,7 +695,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (err)
 		goto err;
 
-	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, entry));
+	if (ni.ino != ino_of_node(sbi, entry)) {
+		f2fs_warn(sbi, "Inconsistent ino_of_node, nid:%u, ino:%u, %u",
+			  dn.nid, ni.ino, ino_of_node(sbi, entry));
+		err = -EFSCORRUPTED;
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+		fserror_report_file_metadata(dn.inode, err, GFP_NOFS);
+		goto err;
+	}
 
 	if (ofs_of_node(sbi, dn.node_entry) != ofs_of_node(sbi, entry)) {
 		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
