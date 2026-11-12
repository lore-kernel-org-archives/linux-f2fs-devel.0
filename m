Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C93606A896
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dj0vs8jT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aIWbnIov;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mjrOXO0i;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NwXEGQe+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wDWVQf+oOVKLA9Q5bh+L5xylc5gLHsVQpCVZFa01kOI=; b=dj0vs8jTNsQW5tSYY+xvFQ5VSP
	rNmzZYdnjbuwHVd43JQ260CV9t2bFpEWJb0r2pPKPLFKpg4JOgefT1nMrj/YV/BQZ438wIJGIV6Id
	WLVjr1MEJ6wP8LyrG9LaDYxAGsnbukm5o6GGYDgHigbp25JlqbeHevZkIEi66DUgO1cs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVwk-000000001if-03GV;
	Thu, 12 Nov 2026 14:38:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3ZM_1agwKADkekmpnVfjrnfdbjjbgZ.Xjh@flex--jprusakowski.bounces.google.com>)
 id 1xRVwh-000000001iX-10SH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pZVnsGpsllJ3BwCa9H7SVmcidWV76cNTLyaa8xLLihU=; b=a
 IWbnIovoqSNPBOMeHCBtWxtMe5PWeucOwASKXuk1zYKcxHFurft3r7buWSsiLHcTzBCYLE4i2Uv4R
 YJ4/9h4jHUpzd1N63i4nPHesJ0RbUkPB5YBomn9WS4hEg+fQwgIvZ7mAf1XNEYgGNVSHh+L61uWS2
 +vYyAWvuKW+bb52M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZVnsGpsllJ3BwCa9H7SVmcidWV76cNTLyaa8xLLihU=; b=mjrOXO0iFd/+nJWamJaXbmrc4E
 iOkZSLcMJM6xbU+VEkY2nuAt1fnE0L/ToXK1QrJgz154r5LPmk1w7aoWlDrW4X8CeUIoLUr4Qs2PT
 GvgqJpgUHk5LHHWCiqS/p8D8A65qDSnw3TlSd3PPZ1Uw/jCYVhrVfTwObLkBWnu93Nzc=;
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwg-000000007rG-3Nwv
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:35 +0000
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c293e604f0eso412572066b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494308; x=1795099108;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pZVnsGpsllJ3BwCa9H7SVmcidWV76cNTLyaa8xLLihU=;
 b=NwXEGQe+BJaAW48jOi98cyFEs4Z4y1QxLM88yiXPal4lHGj30NJ1DDh7Z+YRPrK/jA
 ebw8ZURJRnBZ4/c/5/8v0CGGeTTnkfHPOwNxICLFomGuPqpbz8hgdIaZLwRFG/Qws645
 L/R8bQNHXCirekpNluv0ihQA+bdG3hZSnmMucelQMLhoPxsNv2iMVZutvjuYFwOK9MrC
 I/RK5Xluii8k/+8fXIYoEMNJbhD2QE3XVGFKYpPTnx1irl2oim32sLx1uK38GnCFux+h
 GdOp0B74uUwEF3Os/W6gt8HJb7+E2sPhH61R84WnTg5XxQypHjJxAMDivyxuPuGuFfLc
 potQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494308; x=1795099108;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZVnsGpsllJ3BwCa9H7SVmcidWV76cNTLyaa8xLLihU=;
 b=OxDIiCrDtWDse02IYbSbNYZZgNTdm8F/KWlp3gkMlQP1oKhRjky+muyjfsxjMZJvhY
 T+7nT/A6D+ftE72CnTheuXJ71PW011L55pPROuX9gkY2SosMNIIy52pKQG3CcCRxb4yK
 d8YW6S5ZWdizOuOXgv9WdZ6V0004Ob/lvpriZOx3Ozlla993rtXJCjdCSOwzcmbb4mdU
 9kuBq66YxlJfuENvx+/aiARzjH2gkHjvccGYokGmseJrnuNgVJBHEaZCqfIsGBKEh+rF
 Z3q+YJRnQTNvPP8UsSsQ5MzyWcmxhZT59bknG5E+oCoI0EvruHplNsfxg88e5sDSD6Q2
 CTAg==
X-Gm-Message-State: APuU4Z9mElK1FOcIFV+h+ZvA5os+wrkjjc4f5ZIVm9rshoj2LxPdt52R
 rhlwaClpvOOxVZM/UGSscG38SPL7CzBlWvn2jCHh6TlOv+VBGzitampOrHlW6mPC8Yj+746RMtB
 NbMTphUm10q6Tc13ew9BJCtRs48bzxQ==
X-Received: from ejcsa5.prod.google.com ([2002:a17:907:6d05:b0:c46:aa24:8716])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f597:b0:c50:6505:624 with SMTP id
 a640c23a62f3a-c5066d83fb3mr434447266b.43.1794494308088; 
 Thu, 12 Nov 2026 06:38:28 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:49 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-4-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwg-000000007rG-3Nwv
Subject: [f2fs-dev] [PATCH RESEND 3/9] f2fs: keep old block address when
 out-of-place write fails to allocate
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

If f2fs_allocate_data_block() fails, do_write_block() ends writeback of
the folio without submitting it and f2fs_allocate_data_block() sets
fio->new_blkaddr to NULL_ADDR. f2fs_outplace_write_data() then still
calls f2fs_update_data_blkaddr() with that address, which replaces the
old (or reserved NEW_ADDR) block address in the dnode with NULL_ADDR.
The block stays accounted in i_blocks and valid_block_count, so the
in-memory metadata becomes inconsistent and the old data becomes
unreachable.

Only update the dnode when the write was actually submitted.

Allocation only fails after the checkpoint has been stopped with
CP_ERROR_FLAG, so this does not reach the disk, but it keeps the
in-memory state consistent for later reads and for code that rolls back
failed writes.

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/segment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a5f9de723a70..a26cde2dc60e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4257,7 +4257,12 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 		f2fs_update_age_extent_cache(dn);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, fio->version);
 	do_write_block(&sum, fio);
-	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
+	/*
+	 * If block allocation failed, fio->new_blkaddr is NULL_ADDR and the
+	 * folio was not submitted, so keep the old block address in the dnode.
+	 */
+	if (likely(fio->submitted))
+		f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 
 	f2fs_update_iostat(sbi, dn->inode, fio->io_type,
 					F2FS_BLKSIZE(sbi));
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
