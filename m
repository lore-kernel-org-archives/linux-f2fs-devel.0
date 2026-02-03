Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8D1E8306E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxjTjTFUCXwJxud4VOE8S21IftNqe70TgoQBcPshJZk=; b=ED/gLe+HjPP2fIpM3NiuLT67kP
	ym5PiO18mBECb9uCH4XuPUzDdq6d7XylAP4OmWStKzjLgXIOGao+WB6HI0cfw2l8XieUtCzikAA0w
	DtSw+W5FxW6UJyCNS2/bQIMC4mKd9oR9MnrEpSmLF6KjO8nwQQVwdr/XZaDNvAX1xbmg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnCqB-0008DH-2g;
	Tue, 03 Feb 2026 09:36:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vnCqA-0008DA-Dd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZaOWG5B+PSwIJ8DzEujwyITzMsylr1MZ9cnblL/mATw=; b=h6jpwPyfMqxEmc2+zSexbfVYjM
 PpD8k1VnB982a0dlCzRiaNY44aLxPBtyIDvK7tA1CCE8fDhrobxHruRpFS9YrgnB+S6Mr9K6mOsui
 Kf2pCJgyVfmpiGySZPTpB74JPKIVzvTT8Z/AICukCZSVJI1WZwkk382Nc6E0NuFV8gTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZaOWG5B+PSwIJ8DzEujwyITzMsylr1MZ9cnblL/mATw=; b=Qy+I+/QLTq0m2KlpKYPASccd36
 X80x5D828qdJc4w8PG6cl6Ns1qVVzOv/zMaJKPSuyThEXoaNu8KGgpbKPzVNXuXTPIRxsRyAMZBSO
 SpF9nJxBV+ygqtJ7zg7uldsoVNWKJrfVi1vxTdNGEHYknZcyIJnrwTSeuZ9DeT4363hQ=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnCq9-00067o-KP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Za
 OWG5B+PSwIJ8DzEujwyITzMsylr1MZ9cnblL/mATw=; b=dHdOPx5JFmfMB9gte1
 rhWTk1StJgNQCEsnmrVfWKkTgw5/+jijJd4Jgx6WLajdO13gKUabHmYM2zW2vUI9
 4W+IjNJmHtaincyV8Swf+HFrxLzpAvD9HNneWGX/68imTfj6X8FUvRQTG5mjXuOs
 8rsH2jQQNg94//fmZftFLI3+E=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3z5OjwYFpjYYQAA--.45631S2; 
 Tue, 03 Feb 2026 17:36:35 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  3 Feb 2026 17:36:12 +0800
Message-Id: <20260203093614.857390-4-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203091256.854842-1-nzzhao@126.com>
References: <20260203091256.854842-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3z5OjwYFpjYYQAA--.45631S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW3Cw1UZF1DJryftr18Zrb_yoW8Ww1rpF
 y5KF45Gr45u3s29w4DW3Wj9r1rt3srKa4UZa93Z3srAFn8J3WfKa1vya4j9a15XF97Wr10
 qa4jyFyUWF1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziJ3ktUUUUU=
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogRUJGmBwaQucQAA3E
X-Headers-End: 1vnCq9-00067o-KP
Subject: [f2fs-dev] [RFC PATCH v1 3/5] f2fs: Preallocate partial-write
 blocks for large-folio write
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
Cc: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In the case of large folio buffered write, if we pre-allocate partial
blocks after acquiring the folio lock, it may call f2fs_balance_fs and
need to unlock the folio during write.

Re-locking after unlocking can be troublesome because a large folio
carries additional f2fs_folio_state metadata, and partial truncate can
cause the large folio to be split.
At this point, the large folio is still in the inode->mapping.

Prellocate partial blocks in advance to avoid handling this.
Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/file.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index abcf6f486dd7..18a9feccb1f9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4995,9 +4995,20 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	/* Do not preallocate blocks that will be written partially in 4KB. */
-	map.m_lblk = F2FS_BLK_ALIGN(pos);
-	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
+	if (mapping_large_folio_support(inode->i_mapping)) {
+		/* preallocate all blocks for large folio inode before write to avoid
+		 * unlocking large folios by balance_fs during write. Rechecking the
+		 * large-folio state is unreliable since partial truncation may split
+		 * the folio.
+		 */
+		map.m_lblk = F2FS_BYTES_TO_BLK(pos);
+		map.m_len = F2FS_BLK_ALIGN(pos + count);
+	} else {
+		/* Do not preallocate blocks that will be written partially in 4KB. */
+		map.m_lblk = F2FS_BLK_ALIGN(pos);
+		map.m_len = F2FS_BYTES_TO_BLK(pos + count);
+	}
+
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
