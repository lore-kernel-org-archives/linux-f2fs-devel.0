Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1317FCD5BD2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mTzU1DpxMvV771BHbV5au7mogsJv9xaNbvAOToUaA7g=; b=dmz7dC0SzZEGMpdHAXodRFqlcd
	vsun5sR6sTh6PcQa3vOHobjc3cgNcbfbWMc9JhCmK5bDdEHC4fszikifq0fYkDa6QVMfCQ6YGyHlQ
	tH8+3odwU8D7VZuJbpxO4duMMxxIHcriGvHbbzjDbusON37JQHDeWLhYTZwveB/Ht1pM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRTlZ-0007H7-4S;
	Mon, 25 May 2026 11:46:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wRTlX-0007H0-RL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 11:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X5+abP3UnnxN7BlV9ZGzPIjCXHgbyHlMPqVv/kHZ1T4=; b=fcsKe98JX+qRAm2HqKCpGM9qYM
 LDKh//JEPtru8G5gjcGjGhKNBJ8qyU8UF/Dzn6HbzyVJj1LwTTTswtOMb60ir2E0+e8+qajkEx38q
 benSiezHUavkYabOIFIuHvcv57v07ptS+Ld8fPwjJZTpBMxieQeMDpuWV4//MqXRiNfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X5+abP3UnnxN7BlV9ZGzPIjCXHgbyHlMPqVv/kHZ1T4=; b=P
 DvB1KTwCimM/w3SqN/Njaj8r7l1dYOdrVS1JZANzqGmh7XkWGdjctKekSJgd1vgOJgVRSklfu/V65
 96vt8OoPugQxvb4pO0SALTzHL/7Y49h9qKnf+dTLctjl6FJm+It1Z530SfZ9TFek/dl1DP9QmHrVf
 9gx/zqHM20K9V164=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRTlW-0000Ak-Ja for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 11:46:40 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso4395449a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 May 2026 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709588; x=1780314388; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5+abP3UnnxN7BlV9ZGzPIjCXHgbyHlMPqVv/kHZ1T4=;
 b=Kn5BPCLCcaEt6kSV0Or32IWb+7u7VjkrlytdHICT5ZM4JyotemKog7E9k0Yo7Mfkdu
 HsaShwdaAW4NkQ2xdTMfCkS6Az4Y0T/NB7aXZYld3PHaeFOKtx63a17yXLhbCEl2lj/f
 lZgN6IDnIz3C8lKKgu7pDaVr45IGFwssCGQTHwJShk5+Xh9h8HmXofExouQpFqUOxVFQ
 hUWXouSq2Ck7Fbc2hzZ3tJQ/qN5Lwm9WOuADR+IZNOwOnYjEiX5da97dsghmPORjJfY/
 rVXXk4ebGClzCR6XaXZsVLUV1YRyJ7eW9iRmpzFZHKBDLSKWwXjKijGzphifuEkER4Bo
 e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709588; x=1780314388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5+abP3UnnxN7BlV9ZGzPIjCXHgbyHlMPqVv/kHZ1T4=;
 b=FoxljHEo/5DfNkwKYFIML7BVwBKZmJvXiMB3YkO+3IJTUPZ0+oaBHkPr2SNd9bmA5e
 PbhHcgqvdDV25lRXdg97atY0wfZz+qSFJwXbNRVKiTJoB72k23EamIfP2QWLBSj4iG7l
 9c7Np44QAja/mm9txWsgYs3A/xR+qfl+VMT7N0hoqxDtqe4h77hmwuMS786uqjL0QwCA
 B6Ca1J45grY2ABzx0vA0pM6Ysz7Y7LbfrPc+DOtQ8nsEJNLaTINhMNjVZzeRmwj9fGut
 ETXvpbRGNJM59m9/SeLwH1Yb65yTtGzQY+7nNU5vHU+NROeGkfI0NaAt4b0of77JzLRM
 DYyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zA7TpiTTpLmXMkL3pFFFd7rFC/ikUMciAtj/dLtoZ4Jb9f4AtQsK3ighY/HfvoniUFeGWBbkXkawqiGhhLlDy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyAH9rQTDGd3e0NfoZEk6MbqZam1X6oJgjjcE66XSWQgZvvImcm
 zcIeBNfaE6geniudYKlywm73ZhozxU9RZJUaZjEz9mqysOujSnNs0fqf
X-Gm-Gg: Acq92OHCb+a8fDdOtl415gSpbyGRIqzbrnvy/gmBgPNkN084NUB7Qaf1TCXieFhh/T3
 Bs8mzNhJ+k7IvpOdaWQlpR9tgVedU0EF4ATUzrGCP1haYWqYRYM8U66M9ook0nLZaLaoXGgpn2+
 cItsaXzPR0kksDKLl9IkYveIwVXnSLB+spH13bq5lVBAmFzxsrTlL4Veo3DS1YycuFOObdfbbJy
 uiMZziIWfHSHdfUhrixRFptwMCcBiCzRA7IYggHtNPb9rxAQp4tygQoaKxWlf0oHnmIsvS+ILJV
 PpX7W3Wqwxu70isbOBNM74xFPdjOPIXirLeD8+3w9Jtq55AsHjJADW5v70lFFLfZ6t0ijprX8uO
 RCDnXPc/pvkr3qKIZOHhI0lQlzjHY6ZXd6aZGdrIE3aKAOs7FyPdaGjqPeMXx3xEv+hZNHiTrsP
 SDJMLANrqOD5RDEt+/iOGWbiFGfjSefs5u9AdCqSC8k6TKql9tFLiTtZi5WjCEd/ZYlGCb47etr
 thxxlam
X-Received: by 2002:a17:90b:5785:b0:369:1dcf:4a46 with SMTP id
 98e67ed59e1d1-36a67649211mr13293548a91.25.1779709588226; 
 Mon, 25 May 2026 04:46:28 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6787fe2esm4402143a91.3.2026.05.25.04.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:46:27 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 25 May 2026 19:46:21 +0800
Message-ID: <20260525114621.571845-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wRTlW-0000Ak-Ja
Subject: [f2fs-dev] [PATCH] f2fs: validate orphan inode entry count
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_recover_orphan_inodes() trusts the orphan block entry_count when
replaying orphan inodes from the checkpoint pack.  A corrupted
entry_count larger than F2FS_ORPHANS_PER_BLOCK makes the recovery loop
read past the ino[] array and interpret footer or following data as
inode numbers.

On a crafted image, mounting an unpatched kernel can drive orphan
recovery into f2fs_bug_on() and panic the kernel.  Validate entry_count
before consuming entries so corrupted checkpoint data fails the mount
with -EFSCORRUPTED and requests fsck instead.

Fixes: 127e670abfa7 ("f2fs: add checkpoint operations")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/checkpoint.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c00a6b6ebcbd..fc72b69ff769 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -943,6 +943,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
 		if (IS_ERR(folio)) {
@@ -951,7 +952,17 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = folio_address(folio);
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+			f2fs_err(sbi, "invalid orphan inode entry count %u",
+				 entry_count);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			err = -EFSCORRUPTED;
+			f2fs_folio_put(folio, true);
+			goto out;
+		}
+
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 
 			err = recover_orphan_inode(sbi, ino);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
