Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB9606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Nov 2026 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M7lQjJEy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d3TQ9Bc3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ml4OgPre;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+vc2L6w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=nLFtSA3GwjSjNUo47LmPo9unGIAA2pHNHuUZAJC4PFs=; b=M7lQjJEycFmMHni73qZrFf590z
	geOY+fJOdSCeRwu2fh8AGir1oYyNXaLq6QJzvyHZ/o0zMbBoWK/MkHPyUAPAZCUEubkolfGuHQB53
	h1CwyOd87IduNhzN9JcN9HQBzJwDpwM4nozCNH2hOOrIrMFD/sQpyPzUzKATyCW1Esng=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPZlZ-000000003UR-24tc;
	Sat, 07 Nov 2026 06:19:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jsjlee1020@gmail.com>) id 1xPZlY-000000003UJ-1KwM
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 06:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=; b=d3TQ9Bc3gsNY2xHv88a0pvOHsr
 oHvCjljFrCYAeBEWY0rbkEaM9sMlRTpiF3+maVrX/jS9zGgQKqwj8LmPepXYWdebMEsnA6NJovHys
 XH0Jfo7OfR/mCPhVF4OJeEJjtuoJ1cgC9pbk1uH7iBHeu5Yy0xZOdvSbNqtOzg87wa/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=; b=Ml4OgPreV+El9NeMNAeMD2J2Z4
 x6EC3KU3WTRdnVAAnz5MYyriakCJuNrIG4LfeX5uRiWimNAAZvtANq75vxEMRZNZgxBJep3XKqRYI
 OSxFturTsC/ORpqQdzg6fhZbvq5+UnCnXcWIjOsRgrgetedyoWLri+C9jxFq+oIbmyzY=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPZlX-000000007Wy-3kK4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 06:19:04 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so774508a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794032338; x=1794637138; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
 b=N+vc2L6wwRbg2I01mBjKTS+niFPwpVjRcRmxYxT8RyQvKrj9uTsSzaCcFsYf9qSZ4g
 bwx3lkqhoa0M1Ph6giUdSm2dXMI0i4QOz95ZgtBMlk5UWzBaR/ErFOobCQ1svOdYsRfL
 /eeTddlaak7Fo25SBJfXauVUq4/9v/eaXPYtPubN7BpjlSs0ui9dRM8L9U4xth9CbqT2
 CJ/DJvSzSFngpwCuDxHE8AKxM3IO8xUC2IYohy2uqzLnUDsIix//tNQsXVqzHmjfouZ6
 Cp0I+mUKQkPm1DJ1tJp5LHL7kacw2SchZdw3rx8RgmFHRj23Wstsl/Bl20mk6qnSuVnn
 q8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794032338; x=1794637138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
 b=ATuCdzwCw2uNgrDu5LnObUh19azJ6PN3zZRWbC5EOGCbMUnaZ/yS4cpbmuvDmTtJ+w
 q+lwze17qHTcqWbMI/ZGI+vbHFT1xNq6TD1WYx4LG2Qz54iI44sw0jQDOmraWBDU1O6z
 Qkni5dGqI6X7f9FAoZMQEIdb4aPZLXmt62e1DCXuw3wwoACFQoqPR45uuFL2vRWhGpxW
 gjQZ/SDm3ec78pjmo5bhpRnmT5cc2iZJXBReH3AQX9EAn1D6u6oXbx1NSfOTue9NIvmk
 ga48c6qrGRd8IBKgwQ1hNMmGpTKHoyFvwx4FdpQE5LuQv6zoylYlsYEJiIhiRLG3mHR3
 GLjg==
X-Forwarded-Encrypted: i=1;
 AL+hErGJ2OroVsB1jbeMBnTvTjgC1bop/BCBiimQ7EkpSIOhzluHuIeE9z2QGDN2SUeA/+u1i9/b3rWhJ5R9H4W7i95e@lists.sourceforge.net
X-Gm-Message-State: APuU4Z87TY2C/+Q6Q9lFXqMnejnTPwZHoHLrR/MHryMxd3mzSpnnYSuq
 IJeAEXlcAJA8nP1gptdbbUslPlbwsDOt5hbx0Dv1EVIM5gRRn7O/OgOG
X-Gm-Gg: AYBFou3BxD3Ie1D4AXM4Uh0hpjHEB/7PnnK3H3QQF4CcSCP58WUtTI9K7S2ymXy21i0
 x5u/AKUcIjzP/s9n3sAnY6XK1KfUaTmmb0BSUzxTL+tpOcUDRDC302vnsf/pPTL7tvCs5i4xDyc
 UIV84vPQlCoQrHL8HX4sqQFI7CwhfPkXP1l01k0Y/ifnJb+Tax7WD4Qv6CKI9XTGQc/hcyOnnm1
 QU2Q0hj3C4u8UPDDPXolQU/4f+RgzhAxGuOg2Jf1pGpxB5L0GDSzb/sDebIk9yPnd4+04s1t8Nn
 qKXdj00awX7INGwyWV7TniWYz4TYwgdJYwipuKSDk4rwfKWKrpA9Rw+KSxNkBBgZjJ2pQuSOj4p
 NlN/WSOhC3YGWgSJrgrVn3eclfDzLQyMCmmMSPn5ueyP2piZQ1sIV31J3Xqo5p/OkC3HAkS2rnh
 BDV5J1MJQT9jYdyhk0SOe1FCBJRhNBS3sc8KEIalOvMeFSWSVu48nusQM9GqE1ZFkwZ/pThZfNf
 I2cdMCUuU227wnk/kGRIqRbLBkTefq5YzHMC/UsHVv4hBYn7b+2gx7MZzIIIXbBuo1NGiljCb4A
 sFiAJksLpXDX8rmGY8c1UIdJK+Rg/RvdQ0FQ9MfaeSqI0491mLVAcagdw2C15lexu/i6qUEfeeT
 8iS1M0RRKDAsLqNVv9LiG45vQUuA=
X-Received: by 2002:a17:90b:5107:b0:3b0:9f53:e8a8 with SMTP id
 98e67ed59e1d1-3b0db712d66mr4613324a91.52.1794032338089; 
 Fri, 06 Nov 2026 22:18:58 -0800 (PST)
Received: from
 codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.119]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b101c28791sm1340220a91.3.2026.11.06.22.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 22:18:57 -0800 (PST)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat,  7 Nov 2026 06:18:30 +0000
Message-ID: <20261107061830.30764-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xPZlX-000000007Wy-3kK4
Subject: [f2fs-dev] [PATCH v2] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, yi.sun@unisoc.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When update_sit_entry_for_release() encounters a block whose bit is
already cleared in cur_valid_map, it reports the inconsistency and
corrects se->valid_blocks and del. However, it still proceeds with
the discard bitmap and checkpoint accounting updates.

This can clear the discard bit unnecessarily and incorrectly decrement
the segment and section ckpt_valid_blocks counters when the block is
not marked in ckpt_valid_map.

Continue to the next block after correcting se->valid_blocks and del,
so that an already invalidated block does not trigger further discard
bitmap or checkpoint counter updates.

Cc: stable@vger.kernel.org
Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")
Fixes: a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
V1 -> V2:
- Add Cc: stable@vger.kernel.org.
- Add a Fixes tag for the discard bitmap handling.

Fixes tags:
- 81ffbd224e5f introduced the segment checkpoint accounting regression
  by replacing the del-based adjustment with a fixed decrement.
- a66cdd985532 introduced the discard bitmap update that still runs
  when the block is already invalid.

 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 51858f64e43e..fc2f0fd8e318 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2560,7 +2560,10 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del += 1;
-		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			continue;
+		}
+
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 			/*
 			 * If checkpoints are off, we must not reuse data that
 			 * was used in the previous checkpoint. If it was used
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
