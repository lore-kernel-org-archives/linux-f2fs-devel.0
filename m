Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FAEFCA17B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CSuzzv8j/TTaxp8pVpu3DLUx/omCGGTKBlak1A3+5xY=; b=l4r9AMGV0Wl4tXN5gS87OrmS5a
	S31qO2891a0AgvKrpWqEePNzfjwcW266/Q4kon7IyUlxqSsm+q2gO/i+jpPYNBIP9evQymNRZ1tVF
	AD+ohUVCZ2iw4cPIVp/vBmJKq5wx4uQi7Wf1Crs5ImSgel9ojWIb7mZ52cx5IoBPZkaw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzgDY-00086q-58;
	Mon, 09 Mar 2026 19:24:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1vzgDW-00086d-Rd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1k2hm2i2h46H6U/rzGpxy5F1hc7G0B3aCj4dogEdjEE=; b=Qvb7wRr62BoR44B2iE2ohOcF25
 qet1+y1Cfh7rJ8I0t4sBolJiifrHsVAjc7GdLICcdgpKSkTVkHI2c8/u729OpoKWo0zXE/uUxfTrP
 Hlq9TBXePjb0NfusQmp8rctRBuIAxcdDsnPnCtVpbu80nJuFRTKuTSThVLXDDcmjkrUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1k2hm2i2h46H6U/rzGpxy5F1hc7G0B3aCj4dogEdjEE=; b=MunguI/+AQZEgoO6njXm2OPAe/
 g6E8l/+orFjLa7f35RFaSPNsTTSJPdNtT3t4O+epbxu8LB4BRwG5yE1M1G20kXX2dRCXHQkQEHGn4
 PbYQtBGiJhN0nbn88rL0ZJJMS7EcjGamHcB09BkgZHcLkDOH85gNzOdtIdOC9bwONzDI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzgDW-0001Ep-BX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:24:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BFB0D60054;
 Mon,  9 Mar 2026 19:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED76C2BCB0;
 Mon,  9 Mar 2026 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773084267;
 bh=DJSVKyGg+4R0k6WRAuNIeBNAD9pdSqrckhsLvnGW8L4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Grn19QkKj5XpSF3fVfFe9jhpynhhJbkH1HpjjsPMvNtLiRgaHBWl7hYjbE8y+UKHa
 Gpxb8xC3TMlgOCWiYVCuZ1srjv2xRWkDQ7yodZPEumxG+Qj+wnSBxlM1zwoQhlLaWO
 F6Da5wljSesnhgjWj0io2Sl1Te96tnH+a5Tx9/snzo1DO0YWICtuFp5nO6M/lKJWpa
 cc6YTLg8NVTQ5ML50KHeDOEJatNiMWizF8B9qqKCb7t//TwL+ypU5A2wRJ/zYob3A+
 KUbdgxrFrBEEwDyF41ZyGJM5pdGjM357a4JlszzJbrj/86JPKDKQJYHJDY8HC5PemN
 3H89ld61kv1cg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  9 Mar 2026 20:23:18 +0100
Message-ID: <20260309192355.176980-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vzgDW-0001Ep-BX
Subject: [f2fs-dev] [PATCH v4 03/25] fsverity: generate and store zero-block
 hash
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compute the hash of one filesystem block's worth of zeros. A filesystem
implementation can decide to elide merkle tree blocks containing only
this hash and synthesize the contents at read time.

Let's pretend that there's a file containing six data blocks and whose
merkle tree looks roughly like this:

root
 +--leaf0
 |   +--data0
 |   +--data1
 |   `--data2
 `--leaf1
     +--data3
     +--data4
     `--data5

If data[0-2] are sparse holes, then leaf0 will contain a repeating
sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
because its contents can be synthesized.

A subsequent xfs patch will use this to reduce the size of the merkle
tree when dealing with sparse gold master disk images and the like.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/fsverity_private.h | 3 +++
 fs/verity/open.c             | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 6e6854c19078..35636c1e2c41 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -53,6 +53,9 @@ struct merkle_tree_params {
 	u64 tree_size;			/* Merkle tree size in bytes */
 	unsigned long tree_pages;	/* Merkle tree size in pages */
 
+	/* the hash of a merkle block-sized buffer of zeroes */
+	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE];
+
 	/*
 	 * Starting block index for each tree level, ordered from leaf level (0)
 	 * to root level ('num_levels - 1')
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 0483db672526..94407a37aa08 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -153,6 +153,9 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		goto out_err;
 	}
 
+	fsverity_hash_block(params, page_address(ZERO_PAGE(0)),
+			    params->zero_digest);
+
 	params->tree_size = offset << log_blocksize;
 	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
 	return 0;
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
