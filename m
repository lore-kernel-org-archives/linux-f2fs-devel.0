Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65181C531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qG3shc44xN1m7iGu3mtVYC8x3Pq1541O4wTUhSIwjeg=; b=Nl4yDHNQvneECZcH538woIWL2p
	0+4cu1c0kxNtyc9HLIHQaOvZ+8sEdae5sqinO9RkGjvttqAUcyOPFzhsn2tZIsCHbblS+YOmSVT7x
	aURQJSul3zt7S/Lv6JexBASSRcUanJh3h0QwHCXmjbeuLwJv8w1HbUW4g8R6Blu7etdM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woL0h-0000ZP-GI;
	Mon, 27 Jul 2026 13:04:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1woL0g-0000ZI-2h
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkQDv6RmMZI32C7coY/qIPlobs7MyQ4M7KSkvQYDZSg=; b=N53QaaDN4muJs+McL4S7/G47Wj
 i6XNeegxAJr5B2p7r18t0n7UJr8dPgwKrdGW/m31TpnbEyVetCRkGyN5Rw58GSy6eMIeqB+zIc1q+
 3BYvvKGw63mlMib/79bEIwqs2BI9hvz2kb1FJnenZPgFwdfcR9bgKRxUyTLezE6qwDW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rkQDv6RmMZI32C7coY/qIPlobs7MyQ4M7KSkvQYDZSg=; b=Z
 ovUoTDOhzaOCWuofqLt6SO+XKcBevFcxoV1y6fc31PfCNZDOuppIJxTF0hGMzV0kVfNMEK5f19hI3
 xkm+ZVPPWkxzcJTCfb7b1SvFpvWm0+URrkHcwUlycae6DyyY1fypCpkl9RFlLDE8cZz3jrMuOLJpQ
 UvQp2/fKueMkkYl4=;
Received: from mail-qv1-f50.google.com ([209.85.219.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woL0e-0005mi-Lm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:04:46 +0000
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8eefd4a8057so26183026d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785157479; x=1785762279; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rkQDv6RmMZI32C7coY/qIPlobs7MyQ4M7KSkvQYDZSg=;
 b=sM/xGHEtBBxNoEt1Q1vVPEa/qXMPddMCVkIn82IrpSiRwttJXDTn890k77rEFTxwpH
 1e4rHSfm/nIq/iCWveHtfTe/036h9rUlbhgHtWLN+TDQwbY5jdMm4SaESUQfmjKm8yOQ
 Fk6M/wwR+UspcnRiQqXa2j/GB3qtLt4CiIn+xpagnopuzkW2UdppLjrH8H1Fc6tCLemF
 j5PpHd3PKIzdD4ztb4uYOQ3gYp07E4WHYHSyTlfFMtXZ4EXvZN2gCpPjvNUQOyBTnzA8
 KbzZ0zvuCvIuVHyzPsbEEhcbHlvVA6xZbEGiPXAVfz1+LmmWDb6TP0LDTL8QKngmxeNx
 cIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157479; x=1785762279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rkQDv6RmMZI32C7coY/qIPlobs7MyQ4M7KSkvQYDZSg=;
 b=hwMsJ7zN5OeoXaE5UI75RgjPFh/GThlNuX22fiJt+iK/er10LFfnJQNcdJvZkba+U2
 nY3lIEy8wKqQ26R7sRZhMfVEF956bI0NDtbgYxF/D65NdyxfeKtzm6Ahzn+4Gq/hHRFu
 iugjIhP1I9tZn+xuwIKXOn9Bo9QQXNUEXsOoISXwMNTlQqRKKcfiEwQN5P12cCOSbNNJ
 zaCzVq5UFEWpKd2BSLov7VBfzth5VrLN+fTbOsbwl6pcO79z0JKvKy0KddtdCiaSmAK2
 qd8QE+wLHCNkXpYPIMuPK8+Xwl0kE45thcL+ocf5CbNY/1NDOU67yoIt4LMp+b5ED+g+
 CfEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqlxesco3eE5rB6eyz2DJvhI/mYIsvEmsanbHx9oc2ntf9EQplOIAJE6RgOmLSb5/RCuhKIFEB+XH/GwI6dE1N0@lists.sourceforge.net
X-Gm-Message-State: AOJu0YySYtQpZkciIHGOEHSQ5WxD+PiSfh+HgUkMsCWkq0u6m+HjLcw6
 2go7r7nEX+bWADrL4cuVdwZ/yFejFsULhVrJFDPlKV1+kJ+jLyWujpcY
X-Gm-Gg: AR+sD12mrAKyMt6vAIT2Ab4XIgJXG0D7CwfCuMoLkrRB3sWdYUEEpZKMCV23tkpj912
 NyKhiHQTaeBjL+e4ue7uiadPxp2BlN97eZErKb8OYLr+xkJ8v4X5Kw93mZRhJSSc6qwt4EgG8CT
 Eq5DgcZhXxjnT9Di+sQLQN8ptWQEWEdgFjdXYbjUZ5dqJaObTuEFwqlJY0OkphFfZ1K+IogMizQ
 c/+QqVFkz70iC8lz7Z1QaSX6Uo5ldi2x50K4s3OJHB5pXeFGyEvQmiqPxwGmbVDpbkdvmCHexYk
 icK47sUYS/XKSAeOnFFM+PMNKRTRpejAWOKczOJjMJasE52TM+XEcKIACziU3Mg8+7uOhSAjs51
 RV3pSBU/n6PFm01oqStNvjKLxJOTD6KphduS8uzU+P6WoR6Y2DZ337EnBQl0P2nWqwLtpHv4wIB
 8c0grMb/4jruBekgcMhyWwZ/vAmrbbXFmwndF4EQ==
X-Received: by 2002:a05:6214:5783:b0:8f0:b75:c4aa with SMTP id
 6a1803df08f44-907ec804305mr101984466d6.35.1785157478703; 
 Mon, 27 Jul 2026 06:04:38 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e86d7367sm64308536d6.33.2026.07.27.06.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:04:38 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 27 Jul 2026 21:04:29 +0800
Message-ID: <20260727130430.2109181-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1woL0e-0005mi-Lm
Subject: [f2fs-dev] [PATCH] f2fs: only redirty pinned folios in
 redirty_blocks
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

redirty_blocks() pins folios with read_cache_folio() and then walks the
same range again with filemap_lock_folio() to redirty them and drop the
references it took.

Commit 5951fee46bef ("f2fs: Use a folio in redirty_blocks()") changed
the second pass to a do/while loop. If read_cache_folio() fails before
anything is pinned, page_idx does not advance but the cleanup loop still
runs once.

If readahead has already populated the failed folio in page cache, that
extra iteration finds it and folio_put_refs(folio, 2) drops one
reference too many. Later drop_caches or reclaim can then report
"BUG: Bad page state".

Only redirty the range that was pinned successfully.

Fixes: 5951fee46bef ("f2fs: Use a folio in redirty_blocks()")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Observed on the baseline after a FAULT_READ_IO-triggered
F2FS_IOC_COMPRESS_FILE:
  BUG: Bad page state in process bash  pfn:1190b0
  aops:f2fs_dblock_aops ino:5 dentry name(?):"redirty"
  page dumped because: non-NULL mapping
  Call Trace:
   dump_stack_lvl+0x53/0x70
   bad_page+0xd4/0x220
   free_unref_folios+0x72a/0x1320
   folios_put_refs+0x348/0x590
   mapping_try_invalidate+0x236/0x2d0
   drop_pagecache_sb+0x116/0x330
   __iterate_supers+0x183/0x200
   drop_caches_sysctl_handler+0x72/0x110
   proc_sys_call_handler+0x352/0x540
   vfs_write+0x5f8/0xf50
   ksys_write+0xf9/0x1d0
   do_syscall_64+0x5f/0x550
   entry_SYSCALL_64_after_hwframe+0x71/0x79

 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..bb89dd738e96 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4479,7 +4479,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		page_idx = folio_next_index(folio);
 	} while (page_len < len);
 
-	do {
+	while (redirty_idx < page_idx) {
 		folio = filemap_lock_folio(mapping, redirty_idx);
 
 		/* It will never fail, when folio has pinned above */
@@ -4492,7 +4492,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		redirty_idx = folio_next_index(folio);
 		folio_unlock(folio);
 		folio_put_refs(folio, 2);
-	} while (redirty_idx < page_idx);
+	}
 
 	return ret;
 }
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
