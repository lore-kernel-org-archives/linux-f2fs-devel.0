Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF06CD128D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:52:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrvQ1-0002lt-3E;
	Wed, 03 Apr 2024 07:52:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sweettea-kernel@dorminy.me>) id 1rrvPz-0002lm-Mc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dazOs86ddv8Itb3DPSz/NqiiNaYofvrmL1F8lvug2MI=; b=YppUCurwBotg64qKmLvqWMxB/Z
 XElE+QIBbkGXKgvuMVaQw3vUQgUWnMOZrFOXlNR28OqLhqETIHkOgGqT7hk/Nnptwya7jTC8VZS6n
 hHn0tGi2YNn9/1n+wunqh7cAPO6/v2yNHftL9YeBnoJWdLDNbneJyqPb0CTfqnvZ82vU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dazOs86ddv8Itb3DPSz/NqiiNaYofvrmL1F8lvug2MI=; b=CjZlfyn2+g48yB5w+zuJom6gBr
 XfCsS3iNV3Fpnzd9RKUA6L+tqwlcPNUtf/GpZrAg0qvI/TvXc58A1291RPKV7xT1VypYUUkj4kKLI
 fi0AKmqCl3ffRFqDXXqm21osrBViaRnfyILf3oqFoMj9pHwU0Bj8DkVWxq/EbFSg3A5c=;
Received: from box.fidei.email ([71.19.144.250])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rrvPy-0001l5-W7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:23 +0000
Received: from authenticated-user (box.fidei.email [71.19.144.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by box.fidei.email (Postfix) with ESMTPSA id 2C4BD809CF;
 Wed,  3 Apr 2024 03:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
 t=1712129623; bh=Yn1zFOsTbXIkMwMfnGhDkiIuwvzgn3xDfiaec4KzrE4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=sDsi6DwW7MGDTQ5P/PQD0Ea0WGP4MIUzVgMSpVt6+MLu6GooeRA15R0TNohgh6qiL
 gbBK43U0gy8PnlGmzx5AVqVZKXPV2FapzHQ+oZPLgDBg8vwg4O10OxkgIWX5xngwfS
 PH2OvUg5EIy5Q30YenZnXA3NlcNTx0gX57l5+aw+qpCar+CfK/i0FS+xCo+A9QqgN4
 6P+NdsGSBq4lgIOk6OA7brNJULtIuyL3MvLZhdqTZi4EiuscId9aGny9zekTgpcN+q
 HHBbpXQKtnX9bDxNcRm1osXmflca6Y1t/MYnIvBMaK6dyDUapKLFgLTXR2osI5KMTX
 neuFRfY2pFLuQ==
To: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Wed,  3 Apr 2024 03:22:54 -0400
Message-ID: <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
X-Headers-End: 1rrvPy-0001l5-W7
Subject: [f2fs-dev] [PATCH v3 13/13] bcachefs: fiemap: emit new COMPRESSED
 state
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
From: Sweet Tea Dorminy via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/bcachefs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index d2793bae842d..54f613f977b4 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
 				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
 
 			if (p.crc.compression_type) {
-				flags2 |= FIEMAP_EXTENT_ENCODED;
+				flags2 |= FIEMAP_EXTENT_DATA_COMPRESSED;
 				phys_len = p.crc.compressed_size << 9;
 			} else
 				offset += p.crc.offset;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
