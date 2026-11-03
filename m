Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E9606BFA3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VGq9r80z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZffR0lTq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MsYupNYd;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tn/pHOcM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Vuu2RYTBkKX7NhDNDojwP1yP4T9bw8pCaraCEP56uzw=; b=VGq9r80z43Fph4lgWBzy+U0AC/
	YI6D16+SKAI16idUzVyEREThV8WA4qhEWuALCIOQQknjhKWyIPQ44UKnAKzd8pKy1zpsxpVt4HzO1
	uwMJscZgSU0SDyG6z84luK3PS7GzFY3EaoDV+sKv4nzipy9NAAJr5cdEbiBTDrc2SrB0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOBV8-000000005pV-1JHa;
	Tue, 03 Nov 2026 10:12:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <seungbum.ju@gmail.com>) id 1xOBV7-000000005oi-00qY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:12:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=; b=ZffR0lTqHaGis0I5TJIzyHirIt
 xHdOYc8gOSWG9zSC1b1XQfzMpgkjT8I7/u9ZA5X4XxAqZqpC9MCAFHkbIcvIGQJzb2SI6qDkFNBFz
 u3k2vTb9mTNDMem5SJoSRmRdH3QcgNLblgN6PaBW0QRNg5+uFd7MuHG8vgrXYXkAJ+p0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=; b=MsYupNYd/Mf0xfmQoTlNC6unVA
 fPFlE7Vie5SkCnt/yxbQrFHSIvGaPCV1VNzRxsjWz4B3WVdugb1gNHD+54gteW/pA15jimxZhPc5S
 YdGWLIcHXWJsvgza+UwtGicECEegZsZFB/Rnw+wN9Gf+dtcvG5lY4lIuvD2xFA9Wm2mE=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBV5-000000000Xd-2ezU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:12:20 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ae6b4c669fso332054a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793700734; x=1794305534; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=;
 b=Tn/pHOcMJEu8dyYH21vVHoutO2+V8WH2rF/eWKWXULrHj57UYDFtOTiggiPyjLHImv
 +RvwX1fclmWos7Dkx+TpVQg6+E+EZZ5Y7nbRpfucT3lZru+31LoI++c3IloYmUTKz/0q
 J7rheVG4tPifPH3mtayzlEJtYJ6+QIBsCywzd+V1SOl8fV+DtWOJ6DARKC8ZEjr2zwdd
 ++vB4wwpQSP/GZJAv10JVTUAV1yJH1Sxo4hWRq3mQhc2XYPnMCMRcuPThymTfVgnNP2g
 MRaLlYJNZZyc7Fzq12GeezJqIxNNPd5lueyLnjyUqF+6u2awkS4z7DnrLzNASw/LsJLm
 +MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700734; x=1794305534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=;
 b=kKmcFPvpFx3x/6LRAjF1p7IH9uM60/2o3kPP4FC4OeX9callHykOHFdkQnUqKWqnaA
 w6qnfxPQHdjluTVjgFUZMgG213GsV7s4y4xdBwAE4CGk1SWjeIyQH8GXQrdBnZhrjPjt
 hXM+8r6t5s2+7yj/kQicTZaUQX7dc92H1G98HqYDM6mve4g/FYNjD8+YJhTieeQ/2cNo
 1u1tnJc4pgjI5F5C+WBarWzT31hnJQktIHIuBCEySzhMDmRTx89DibUPr/3bGHyXYTZ3
 xG4AShzHYaRkKFMC4q9bdUrXzHO53Qpx+EoSfKU3cXmxyYot5+1C74oSbL/OWFHGNPHs
 dtCQ==
X-Gm-Message-State: APuU4Z9NMwefKgXi0FaFsbkF/ajg0X30lPBTH9dq+xGGKXYivfYpNbco
 jGS+/przp9d3FesDkYJ7U9ZsT8xzE4Hf5Rjvhkog2Tga7IejqZR4EnOE
X-Gm-Gg: AYBFou2cg8Ndy9TA8DXujzBCTwTKWwM8Z+Caz5BGw0n1PbVUs7LSxsQYaCT0zaPtnt3
 gIElLsiRPWFawoasRXVnbi1nvhFW9H0byXZaOVLcmU53J8gLu4Pgd3gngjmG7Lf2g2dbtG/tv/b
 v3HECHUPkGxW8bXNTBC2OJmWtAHLTWMU1InWupDRBw4Osao92X//fPUgUrqCczrxw+HE/ED30/S
 gkO3QyRHKe9ibUSilnEk3ClZLpj9ph3w1WAwSUSHj1VIhTynZ4AxFR/MW1ZGcdNL2KFSnGPkcHn
 fqdwN078+RZFoXatusO/W3kz8eBJGNFM6mTLLugHUwwBoF/v+EMokJcWD/Cq5VEc1SatAVWov6K
 XRznrZqVCU+zgUpWrvwbgI0/bj8qd5xnL/gyi8+dFED16XAfaBcqvmdnhpT8MjQzLSLPvPvIBkF
 Xs8hibzaCRFI1oSWlOaxkMHkJ9hI+iSyeef82jbtIobsgAoiX4yP4YJScPh8SBafAcHnhUVm10m
 c3cbcdVpEMzwivk3Vaw7E4CiReGZdvRGW0tccJorGEJOg4jTwvQkeIDOSKXJSrxyC6KiQdPSCo8
 bwYkuP6v5aLr+8Sb9wjDvnDAAtC9AI1UjsEdgU6/K209OmLoXt68TVZSIIE=
X-Received: by 2002:a17:90b:1cc5:b0:3ae:3d82:5d88 with SMTP id
 98e67ed59e1d1-3ae8917bf84mr7426716a91.0.1793700733700; 
 Tue, 03 Nov 2026 02:12:13 -0800 (PST)
Received: from localhost.localdomain ([106.101.10.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aebc89475asm4934624a91.0.2026.11.03.02.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:12:12 -0800 (PST)
From: Seungbum Ju <seungbum.ju@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue,  3 Nov 2026 19:12:08 +0900
Message-ID: <20261103101208.4550-1-seungbum.ju@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOBV5-000000000Xd-2ezU
Subject: [f2fs-dev] [PATCH] f2fs: wait for node writeback on the first fsync
 after a checkpoint
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Seungbum Ju <seungbum.ju@gmail.com>, linux-kernel@vger.kernel.org,
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

f2fs_add_fsync_node_entry() numbers each fsync'd warm node page with
sbi->fsync_seg_id++, and f2fs_reset_fsync_node_info() sets the counter back
to 0 at every checkpoint. The first node page fsync'd after a checkpoint
therefore gets seq_id 0, which f2fs_do_sync_file() passes to
f2fs_wait_on_node_pages_writeback(). That function treats 0 as "nothing to
wait for":

    while (seq_id && cur_seq_id < seq_id) {

so the fsync issues its cache flush without waiting for its own node page.
If the flush completes before the node write, the inode's fsync-marked
node block (needed by roll-forward recovery) is not covered by the flush,
and a power loss can lose data that fsync reported as durable. In our
traces the first fsync after a checkpoint returned before its node write
completed in many trials.

Start the numbering at 1, so that 0 keeps meaning "no node page written".

Testing (kernel 7.0.0-42, f2fs built as a module from the same source,
QEMU/KVM, block-layer FLUSH/FUA model with dm-log-writes replay):
- block traces, append+fsync after sync: FLUSH issued before the node
  write completed in 29/30 first fsyncs unpatched, 0/30 patched; never
  for later fsyncs;
- crash-state replay (28 cells x 3 recordings per module): SQLite
  WAL/TRUNCATE/PERSIST, LevelDB, RocksDB, LMDB and an append log lose
  acknowledged commits or become unopenable in 24 cells unpatched, and
  are clean in all of them patched.

The same code is present in Android GKI android12-5.10 through
android15-6.6 and in the f2fs dev tree as of 2026-11-02.

Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
Cc: stable@vger.kernel.org
Signed-off-by: Seungbum Ju <seungbum.ju@gmail.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1234567..89abcdef 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -361,7 +361,7 @@ static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
 	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
 	list_add_tail(&fn->list, &sbi->fsync_node_list);
-	fn->seq_id = sbi->fsync_seg_id++;
+	fn->seq_id = ++sbi->fsync_seg_id;
 	seq_id = fn->seq_id;
 	sbi->fsync_node_num++;
 	spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
-- 
2.45.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
