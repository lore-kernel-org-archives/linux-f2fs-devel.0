Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EA60A5BCF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WqrTCgly;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jiR6kD5z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FglXbS2v;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kNV69Zgc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/KNiYR0Y1FJKexXNSEqWDf1DCqlJuEOEEfenPt19hA4=; b=WqrTCgly1GMu6LDLcyiCFLWgzD
	JEc9zn5XRaUuigoXPu2/NZwit2D65PiSHsInb5M5uW6XWZqM9BfAm4ztqWxKUPll+T/+B8CXk3s78
	b9swPR92b+LuF9xKAv+WWXUNpWLEbwK1FWwnA6uj/gxelwox19NLuczuyhIqw7uNvPGI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVwi-000000008Em-3cVZ;
	Thu, 12 Nov 2026 14:38:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3Ys_1agwKADcciknlTdhpldbZhhZeX.Vhf@flex--jprusakowski.bounces.google.com>)
 id 1xRVwh-000000008Eg-0Zcg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=chdsKhTOicvCPxU1lZpBQEsB9QRDWD9pdLuqQmhmbG4=; b=j
 iR6kD5zRAdc6grEQWcaSXMS8OogM7W5CmFTw7ljSKIrsKn2ebfmWmHJEQwwuHGnP5Wp2lB9JG+HLS
 EtwBSnsrVEtTxRT4ujuSTDNb6R+P2aOakv0tMxldwttZfOIJBsOViYZhpoc4EyJsgopMN8Bd4wcYi
 1mfJDwluKCt74UcA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=chdsKhTOicvCPxU1lZpBQEsB9QRDWD9pdLuqQmhmbG4=; b=FglXbS2vSVGAI6YB/t35hup+Rl
 DHIMPJkOvuhSr8Zbnq3dxGgD5l1kOHDPP4yZKlzbXvcS6gWES0wCJgKZoa7VBSMwCfJR3Sv1gKC8Q
 wgNunv6q51WkNFWzAqjRr6JhOcOzwj1vJxp+H4+iJ8ZkPD6u9lCCHYeLBAHmcN00UhCg=;
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwf-000000003PM-3JW7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:35 +0000
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6b42827bb4bso383094a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494307; x=1795099107;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=chdsKhTOicvCPxU1lZpBQEsB9QRDWD9pdLuqQmhmbG4=;
 b=kNV69ZgcSPehQ6GKwapGfByjD76NVot51fZT32kIwNmz8j3Z/+tWCPcOjq+jbVyHLE
 srDEgXARIGjPFg+NVSOq7ZY8kjZzke2uiqDRvegTQLrqHm7Fozyl6qPdM7hoGGRTKhVh
 GmL5Zkkpz2U8r+TJTBgEOM+1hB1QO3rWEJeZA1G8nJRkU8lcvWxaIHPqgvUadmJsrwK3
 8vy/uvnIft8gh64KC0kDOX/j5oNpJVPEYkbxnY4cwxKkZC7sLoywRHoE5iGeP+mVnmpy
 43CwtkaxTkKhrWDy295oRhIOdVabtRe1lffCzuzaBD8CB8fNhpBrNszA6getl6O9je7+
 zE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494307; x=1795099107;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chdsKhTOicvCPxU1lZpBQEsB9QRDWD9pdLuqQmhmbG4=;
 b=vLgLHws0NEBX4m3sC53Szcm5yAUoTSPabgGRuEcUt24ntAncHHs9AX885Gxihh304r
 lyk68CQKr0tZNNVa52DqbZYPqXqzdokRBTNVpV0lWynLmueRoNGyoVBVJ7LelU9s2XMj
 DQQ1SUWmXDqAIwSATTJxa8zmm/C36ddSN2FMcyvQrUzrEYTfSCJMCTGT7aXs+oR0LqyR
 5Cviy0s/9KdV7yk6yqJm9DXqS7SOtsx622Pa8POI+5scHQvfbFx12yd15hivdOPjE+HZ
 x758dxTuYBGyxFznIoHKCBbyKOxdwLXhoCTTAIfQeffJISDkfpHwZC9lWuVr7HuU4oQz
 WAlQ==
X-Gm-Message-State: APuU4Z/lRkp1Y9lnvWsP4xjdahNSq0PdQgTcDU5Svy29o/+WJOCphgWW
 gEAZzEuGzkrwMHBMogUkIInDyQOtqiTs/7nima71Fn/czQhYfN8V9wGEC5vag/4Cd4RxyPXptV3
 AbV8gJEoi6RxLLD3UJsqwHXbjc7vD9Q==
X-Received: from edqw21.prod.google.com ([2002:aa7:d295:0:b0:6b7:dc3:c9b6])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:310f:b0:6ac:8ef4:177d with SMTP id
 4fb4d7f45d1cf-6b7773fbc5amr3101064a12.20.1794494306680; 
 Thu, 12 Nov 2026 06:38:26 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:48 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-3-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwf-000000003PM-3JW7
Subject: [f2fs-dev] [PATCH RESEND 2/9] f2fs: compress: abort on read error
 in prepare_compress_overwrite()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

prepare_compress_overwrite() reads the existing pages of a compressed
cluster before they are partially overwritten. If a folio is still not
uptodate after the read, the function releases everything and restarts
from the beginning.

When the read failed because of a persistent device I/O error (e.g.
dm-error in generic/250 and generic/252), every retry fails the same
way. Commit 3147ee567dd9 ("f2fs: fix potential deadloop in
prepare_compress_overwrite()") bounded this loop with
f2fs_handle_page_eio(), so after MAX_RETRY_PAGE_EIO attempts checkpoint
is stopped with STOP_CP_REASON_READ_DATA. As a result, a read error in a
single data cluster shuts down the whole filesystem instead of failing
the write with -EIO.

Return -EIO as soon as a folio is found not uptodate. Keep calling
f2fs_handle_page_eio(), so that repeated failures on the same page
across calls (e.g. from background writeback) still stop checkpoint as
before. Both callers already handle errors: f2fs_write_begin() fails the
write, and f2fs_write_cache_pages() stops writeback of the inode and
returns the error, leaving the pages dirty.

A folio that disappeared because of truncation (filemap_lock_folio()
fails) still restarts via release_and_retry, which is now a separate
error path after the success return.

While at it, unlock the folios in cc->rpages before dropping our
references to them in both error paths, so that a folio is never
touched after its reference is released, and drop the check of ret
before the success return, which is always true at that point.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/compress.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9453254ff522..c5758da7c621 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1160,23 +1160,27 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		if (!folio_test_uptodate(folio)) {
 			f2fs_handle_page_eio(sbi, folio->index, DATA);
-release_and_retry:
-			f2fs_put_rpages(cc);
+			ret = -EIO;
+			/* folio i has been added to cc->rpages as well */
 			f2fs_unlock_rpages(cc, i + 1);
-			f2fs_destroy_compress_ctx(cc, true);
-			goto retry;
+			goto put_pages;
 		}
 	}
 
-	if (likely(!ret)) {
-		*fsdata = cc->rpages;
-		*pagep = cc->rpages[offset_in_cluster(cc, index)];
-		return cc->cluster_size;
-	}
+	*fsdata = cc->rpages;
+	*pagep = cc->rpages[offset_in_cluster(cc, index)];
+	return cc->cluster_size;
 
-unlock_pages:
+release_and_retry:
+	f2fs_unlock_rpages(cc, i);
 	f2fs_put_rpages(cc);
+	f2fs_destroy_compress_ctx(cc, true);
+	goto retry;
+
+unlock_pages:
 	f2fs_unlock_rpages(cc, i);
+put_pages:
+	f2fs_put_rpages(cc);
 	f2fs_destroy_compress_ctx(cc, true);
 out:
 	return ret;
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
