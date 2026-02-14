Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06318EF584C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbfU09QFWh3gACBhZS5PWmSHSrSBrXj4K0t5IvKVtq8=; b=QoRLGE975lUjttPVR1YRj5PhNE
	dClRi2D0oG2XCjtQOeQ7drlDQzbR02vgBiOgub3z0J4F9+jxiHC/6o7aJk6XuH7H/tiCzpuC98OQD
	voZDC9l4xyMa1VSPKrbzwPb2Gg6jAPSrFSG0qfP6/n6O1iNZ+mtQlbV2d15o9itnfeiM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrMKb-00074B-2V;
	Sat, 14 Feb 2026 20:33:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vrMKZ-00073w-OK
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tkUA8ktbkYiWa/x6JFodpj4cUsQEuxbGLvrVpCV4lm0=; b=GXJhsG7ih6Ys/PgGGIy28JvT/y
 ebebOSXHynm3wglGicobynL0RSbrlYJa7Fv66e8iFX1Zji7SIHH0sKmlI+mPSVAKIC9FsS+LhXS75
 as4fbBIyJWkVhWwqcjnJ57+qHSL/JTo8FFHYGHnvuOm86jh2TbQo9qqHdJwdT6E5dG/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tkUA8ktbkYiWa/x6JFodpj4cUsQEuxbGLvrVpCV4lm0=; b=IF7jbaGMcjMdV44QQZVEVIv1t5
 ApekHk60zLgs6BobwQoXgI2ixuUSm17Vb4r6kH9EQATnvD8LbaAJI3ES3gLOYVyLhl3knL/3xfqai
 M1yaexOmldIxYYhXCaVRg0YY20zsBx/bAV/s5eeKAUOSD3Zhw3FYhn8+gYWc4WEVB3og=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrMKa-0002z1-3M for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:33:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 128236012B;
 Sat, 14 Feb 2026 20:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF3BC19422;
 Sat, 14 Feb 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771101205;
 bh=SqjZE7OWr1LYIbtS0mF/zGZQM1kfgP5bCqVDUaHH/3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GlSgUq2i0I1AM1xAu9ior2ocPVR26OI1VJE5y8JZ/f27QwP88DEaJjau1r/kJVlgs
 VU/1zlwJ5GaFA+ga7V3Jf99TlRecUZ+5ePixRy14X4Qjt57e5TqRK0E2va7VdMc/+Q
 92EMEDuGMj5W/GhDcneaugwXRhD+sEtmLQNouSEZKgQhkGu6nm+kP6zNETQESddgs/
 4FwJn29/kd5Pv2QoK/siNWG/Gk9zelriYO1XpyuAG88WACX+xbecMEzeMHVY529SvQ
 F/6RAnD/tj5sDbPvjr5GQ1/wgRSfETIxbCwElOf6S1+XMK//0WjzJCabt5Yt1roHxF
 8sEzpoRk/JkHw==
To: fsverity@lists.linux.dev
Date: Sat, 14 Feb 2026 12:33:11 -0800
Message-ID: <20260214203311.9759-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214203311.9759-1-ebiggers@kernel.org>
References: <20260214203311.9759-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vrMKa-0002z1-3M
Subject: [f2fs-dev] [PATCH 2/2] fsverity: remove fsverity_verify_page()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now that fsverity_verify_page() has no callers, remove it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 31797f9b24d0..3e38749fbc82 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -431,12 +431,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * verification, then bio->bi_status is set to an error status.
  *
  * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
  * populate the page cache without issuing bios (e.g. non block-based
- * filesystems) must instead call fsverity_verify_page() directly on each page.
- * All filesystems must also call fsverity_verify_page() on holes.
+ * filesystems) must instead call fsverity_verify_blocks() directly.  All
+ * filesystems must also call fsverity_verify_blocks() on holes.
  */
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
 {
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fed91023bea9..6de3ddf0b148 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -280,16 +280,10 @@ static inline bool fsverity_verify_folio(struct fsverity_info *vi,
 					 struct folio *folio)
 {
 	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
 }
 
-static inline bool fsverity_verify_page(struct fsverity_info *vi,
-					struct page *page)
-{
-	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
-}
-
 /**
  * fsverity_file_open() - prepare to open a verity file
  * @inode: the inode being opened
  * @filp: the struct file being set up
  *
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
