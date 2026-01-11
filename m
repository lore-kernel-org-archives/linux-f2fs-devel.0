Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9ABD2502E
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Jan 2026 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xcx/0S/14EvlhCjovTyCVOLLfrcxrMt4VmWdmUmO6o4=; b=j8bgwbdw3yeozq5DmQMI9BSg70
	bJhOz3N57HW4ci+R86Uv57y7X/KfN2g0Flq4NfeAoii8XEg52b7Iv5/r9RFO1l7wrIskYSgoayALv
	EjgcE7V2YTROuTqS9c7l8hVcKWBPm0e/AsK+8P+WTTZ7/sOGEcRFK6+tjPXDP+KHoelQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vesRG-00079V-1L;
	Sun, 11 Jan 2026 10:12:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vesRC-00079N-RL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Jan 2026 10:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VzVndx28vpRx956/VNzPxMUArdQCxma2/Zzy9dSi7H4=; b=O50CfGEkxUAeSGGPT1r7GuIm5B
 fHF2eO2tMMKSa4RfPBLoMS95EHVvzNJMw2tDCSS0IKTDeGSxepxTrD+TtLG/zA1GO6S6X3VxobpY0
 wMzvpSeD92utU9XeXVrVAHAmwQ0NgX49D+bbbPEOFIfodBRF8rCyFzx7c70WXVfC4QAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VzVndx28vpRx956/VNzPxMUArdQCxma2/Zzy9dSi7H4=; b=Vm3RsEy4RKh0pWZcc99u5atSbD
 g1OPafuNGSemOOsb8moDygjBlYEVVGttLIISlqXCZiFUrp68N01ojvbx8bxSfkslp2ZM1JZJ9MS3o
 334zdvi1lWOt5N0jfAEi5nGf1hFFh9n5oivaV2b5PXn2KDjsXJANYd22pGY6LWNZZspA=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vesRC-0004um-1X for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Jan 2026 10:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vz
 Vndx28vpRx956/VNzPxMUArdQCxma2/Zzy9dSi7H4=; b=B8YrixWzj3kwhmNwfu
 BByk6LIsXQLQLxgeE0GG4fEEVIWMKc0xuBehAWGRhEPFT/C1oOpRrnkD2CZLPjIB
 enx/h+qRy50y1ilovCOI/dRP6jVzRHXzzdNBO56TJlK4kdWcNoGWufNhnAucJ4/q
 X4NMDpMgQ+r1b96iYg4zoi45A=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3lx+Ad2Np0FddBg--.65279S4; 
 Sun, 11 Jan 2026 18:12:21 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Date: Sun, 11 Jan 2026 18:09:41 +0800
Message-Id: <20260111100941.119765-3-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111100941.119765-1-nzzhao@126.com>
References: <20260111100941.119765-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3lx+Ad2Np0FddBg--.65279S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF43Zr4fGw18Ary3tr1UZFb_yoW8Gr1fpF
 yDKr1FkFn8G3yFvw10v3WkCw10y34kWay7GFWxCw1fA3Z8Xr93CFy8ta4F9F17t395Aw10
 qa1FgFy8WFn0qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4T5dUUUUU=
X-Originating-IP: [2409:8a20:4df2:4050:484a:1889:71da:fb99]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQUyAmljd4WZNQAA3Q
X-Headers-End: 1vesRC-0004um-1X
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: advance index and offset after
 zeroing in large folio read
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
Cc: Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_read_data_large_folio(), the block zeroing path calls
folio_zero_range() and then continues the loop. However, it fails to
advance index and offset before continuing.

This can cause the loop to repeatedly process the same subpage of the
folio, leading to stalls/hangs and incorrect progress when reading large
folios with holes/zeroed blocks.

Fix it by advancing index and offset unconditionally in the loop
iteration, so they are updated even when the zeroing path continues.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ddabcb1b9882..18952daa8d8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2458,7 +2458,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	ffs = NULL;
 	nrpages = folio_nr_pages(folio);

-	for (; nrpages; nrpages--) {
+	for (; nrpages; nrpages--, index++, offset++) {
 		sector_t block_nr;
 		/*
 		 * Map blocks using the previous result first.
@@ -2543,8 +2543,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
 				F2FS_BLKSIZE);
 		last_block_in_bio = block_nr;
-		index++;
-		offset++;
 	}
 	trace_f2fs_read_folio(folio, DATA);
 	if (rac) {
--
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
