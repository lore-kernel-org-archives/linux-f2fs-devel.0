Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A4606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=biDn6sra;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jkRIJJOS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KOM6DF1u;
	dkim=neutral header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C0yt7kdc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=jImFuG46QW2J2jiSI1KINagzzl3s5MYe6SjUEQ2qCiY=; b=biDn6sralK4bzrDgWk8QUFzYKh
	CMWNNZQcbgAkDpD+B2Kz6dQozFWzTJRUrCzIACGacoPsd2j5SG9RSCX0B/Qpdk3z3DtQht00NQYTh
	9TqrlS9w+8fsG7DqX9R0yaZidDuuUXTjetNbRsQ/KddLtrxhEYWzMjgDUanRnPO9lm0U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL9d5-000000004i3-0bPJ;
	Mon, 26 Oct 2026 01:36:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yaojiale02@163.com>) id 1xL9d2-000000004hp-48gd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 01:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G8Ajzz5naVzS35r8PFaFnbKVlFcksfzdUJCNllkRj8g=; b=jkRIJJOSYngCyh1jfFVOdzze10
 G8N+EHFCLlQKE+ty3fLgQWshHEbs0Br6Bq1QOWckJUhb2XE/tpH3AR/Xtj2ODR678eVJOJlxS/eho
 mE9vIoNmHG44Ev3+K9p4YNlZ4JPRa+qAJmJp00/ZGYD9GqDgaWajSucXE5YTrYhkajco=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G8Ajzz5naVzS35r8PFaFnbKVlFcksfzdUJCNllkRj8g=; b=KOM6DF1u5MsnH4gUnJOzdfhzb+
 dgAcA9Jwg2Y+ff2Fvb28F31jCLuOQ3dOg+gUZ6cHzkt+8pneKKe2RWcz4NOSBGVYUEhS33n/Q9oVL
 JPBNM8yghQya+eIxEvk+S0cMH3Cr7bTMYpio2j1JMGlaizVAndOXAMs5mVZH8haHHjgE=;
Received: from [220.197.31.3] (helo=m16.mail.163.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xL9d1-0000000072e-3ysi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 01:36:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G8
 Ajzz5naVzS35r8PFaFnbKVlFcksfzdUJCNllkRj8g=; b=C0yt7kdc8QkD8nEMLs
 nOy+HMUtKY19r0Hku8zoF0FyLwn91CLqB1OWomSqiRdsFk5PZIfzva4lCPhabPJJ
 0B7I+buCWSNDfo/AFOPGoqf2NuKVFuKPN79JGS5Ospszq/zNVXC15ppS45CaLeky
 fakiX4WAfR6YiEhFA9qjgRykI=
Received: from pc.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgCnH55prt5qhnFSCA--.7906S2;
 Mon, 26 Oct 2026 09:35:38 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 09:35:36 +0800
Message-Id: <20261026013536.385261-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: QCgvCgCnH55prt5qhnFSCA--.7906S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF43ZF4DXF4xuw4DWryDWrg_yoWktwb_Wa
 4kC34UXw4fGF4fXa1Ikr4fAFWvv348uFyfGrWayryfC34fJ3yrCrn0kr9xG34DZFW5GF98
 Gr4fXr4Yq3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbLihUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQoYUmrermrlWwAA3D
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xL9d1-0000000072e-3ysi
Subject: [f2fs-dev] [PATCH v2] f2fs: drain in-flight DIO before buffered
 fallback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A partial direct write can fall back to buffered I/O for the unwritten
remainder. Other asynchronous direct writes may still be active after their
submitters release the inode lock. Their completion can invalidate pages
dirtied by the fallback before it flushes them, causing page-cache
invalidation failures and recording an I/O error.

Wait for all in-flight direct I/O before the fallback dirties page cache.
This only serializes the internal direct-to-buffered fallback and does not
change ordinary buffered write handling.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c759cc99054..e54456e3a226 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5596,6 +5596,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		 * The direct write was partial, so we need to fall back to a
 		 * buffered write for the remainder.
 		 */
+		inode_dio_wait(inode);
 
 		ret2 = f2fs_buffered_write_iter(iocb, from);
 		if (iov_iter_count(from))
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
