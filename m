Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ED6CD3447
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 04:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oWECkAsiToauVw9/dmRFKeQ1nz7Cjm3qJ7JrEzdIc6k=; b=eIXgYQPNJQV5379C+7fv4aR6Kn
	m7bNf9YjJ9jAbUGmi563hjRatNJ98BUncQFlP+09EFc93CX1ivic0nzHpdgRrmygcdb8Q+ngV56P5
	VLUwzFlqbGLIL2Fz2L8ytgAtcWaJaX74prskfiMlnOMVvRZmWGfBOaxstOywkK1M7Z6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLZDQ-00071L-VF;
	Sat, 09 May 2026 04:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kartikey406@gmail.com>) id 1wLZDQ-00071E-AL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 04:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ohOtV8rB+CS/jFzAppee8CMCT1yPc+ITAAm7H1vRX4U=; b=MxGotuYfzpuI8O5lu4nZ569ITZ
 z6LHGka5lTe0ZSsWKi5Ist7JbpLcsPFcIOahVUL8cMa4DUndQNnBRSpuuoiL/vt/kM8xoH2aJsc1P
 Smmicq471aAv5m7LZn79pL35nNPX7L4Q65LNopyHaQdYN2cUxQyeMzzVax9jCtG2qZoc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ohOtV8rB+CS/jFzAppee8CMCT1yPc+ITAAm7H1vRX4U=; b=D
 qJztKL9qk4ZZxlgk+/NmVAd6MvBvCPbStA321vqGoBnRDXXhXAkHbesDXF3q3ox68cpyEstkxNLp8
 NTdG+sXBIY7PyzpcXGUd4+z4EgLdMYpcvpDEAxLQFap/7j+egABrSq99ocC7CeUMbzze0G8rIH0g8
 JzON2OP/KXfUmdds=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wLZDN-0001eF-9r for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 04:22:57 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so1490118a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 08 May 2026 21:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778300567; x=1778905367; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ohOtV8rB+CS/jFzAppee8CMCT1yPc+ITAAm7H1vRX4U=;
 b=pgBCoJCM/XGol8j6GOGcoKS1YYY9ECC4NfQ21MSyWqCp9MN3o9dKO69bOxhuT6hSm5
 BWh8qQlUs53QQLd8FujaOr0RZPl9UR6DKwk1l9kMNZPxY/9Sxp7SPs6w5VXRtEuVI/T8
 //s6M880+HEwI6N3cI0qS/dL9ZKFQrLutnTRR4aIlkYim4/aSEePFCfRVFeTTptrfxWZ
 kk+DTSGr6NghztYzXfCJp5+oqSJG9P6V7GR28uaufKN0R8hVyj6BLRbj371kdYng7PUb
 PpX3ZHWLOOx/aeDUGHJLgcrOkczOowCcF/U0MNvLbO9YUJhWvv/e5UyOQltvOJ/uCzpr
 f+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778300567; x=1778905367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohOtV8rB+CS/jFzAppee8CMCT1yPc+ITAAm7H1vRX4U=;
 b=jtX0wK75/STeF7Cp4ZDGyXTlLrMfVXbtO5odznKAIUMpbLofDeP7PJuREGzaduH0yu
 BYaZD8CP39Te1buPuCVrFo8QBxD4kERPX+J8s7pWOj6JRsWjfUultYIzne5ARiHBWoUO
 ZqbTBnd4gbivID05Fom5qtTHYK8f4Zo6Te7tHn5Xewo/+3fjUvNKTfcZAtB6mX4h/QJt
 kxFG5sMk0uI2NkKajfdC4VIPmmTwnFYYiiIj/No79HQrKy2LUvnkVg8nFqJ/aFm/11pW
 JpWwbzlhTrGNbben7Ao3BZl9bnyFqqQhaGy1el38r+goyNDNVjVG+mXXUuOH9/bVlhlE
 H6lA==
X-Gm-Message-State: AOJu0YzwGxGCTRSVSGHrsUNbYaF6S/S2saKiIxtomJN0qieFv+Of99SB
 HoxON8KKqHrPhhfN+OyJOHvJXBgX0oAlUGK3B5nI0bHe2xXQqkX94KoE
X-Gm-Gg: Acq92OGmkkY9S4rO4A2J+W4UVyZ6WVULoULVAOe0j7SWCMYMo150VWYe5KsiFaJ4cO8
 31mKFaD86Z1EgvTq8FBLCAq/BTTc7rMyiEsVyrCtlYXsQdX/s/dhQsxHRKF5IsUJ2phpeDu9fhq
 Oz+J28gchYwg49daUmULn4QRrv9/ztSDGE4cswyg2puDvBCqgVodiaeW13HKedDpZ1IRtXtiW2n
 TTM2BZSzFlif1xTTfW57M90LM7InpHmOY6nMWu64/15CVQKr+IRg+Gj4Mau6fmgQDXjQLVxj2Lc
 mtttubiWk8wsEdX4CntJ/qMgp0zBn5mvdv7WFnZZhrcMrjo+NOzQMBMqUSpLjzICanFO0OSMhK7
 KFIGi/oqREahQ+CExqUDaaS+v7GINCQAkr7fXGkuGvjHpczIrt+7FhbEuAdDNsqFhUugptgl7K+
 +uoS31ilk8e3qqYrtj2Uz29KzCbPa3iZlroBKzoPVjNgIv+Uz3IQT5/d9DflNXYPGRvCFUcU5SZ
 HeGrPw=
X-Received: by 2002:a17:90a:d646:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-366055e69demr7918237a91.11.1778300566469; 
 Fri, 08 May 2026 21:22:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:1ef5:8ccc:13df:edc6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d687a2a8sm676599a91.15.2026.05.08.21.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 21:22:45 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat,  9 May 2026 09:52:39 +0530
Message-ID: <20260509042239.87763-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wLZDN-0001eF-9r
Subject: [f2fs-dev] [PATCH] f2fs: initialize ino_entry_info before
 checkpoint load
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
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When f2fs_get_valid_checkpoint() fails during mount (e.g. due to an
invalid checkpoint CRC on a malformed image), f2fs_fill_super() takes
an error path that eventually calls iput() on the root inode. This
invokes f2fs_drop_inode() -> f2fs_exist_written_data(), which acquires
sbi->im[]->ino_lock. However, f2fs_init_ino_entry_info() has not run
yet at this point, so the spinlock is uninitialized and lockdep
complains:

  F2FS-fs (loop0): invalid crc value
  F2FS-fs (loop0): Failed to get valid F2FS checkpoint
  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  ...
   f2fs_exist_written_data+0x53/0x90 fs/f2fs/checkpoint.c:787
   f2fs_drop_inode+0xda/0xbf0 fs/f2fs/super.c:1852
   iput+0x651/0xe80 fs/inode.c:2009
   f2fs_fill_super+0x6047/0x7850 fs/f2fs/super.c:5461

Move f2fs_init_ino_entry_info() to before f2fs_get_valid_checkpoint()
so that sbi->im[] is always fully initialized before any error path
can trigger iput() -> f2fs_drop_inode(). The init function only
depends on raw superblock fields (BLKS_PER_SEG, F2FS_CP_PACKS,
NR_CURSEG_PERSIST_TYPE, __cp_payload), which are populated well
before checkpoint load, so the move is safe.

Reported-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eec8f2693d71386bd600
Tested-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/f2fs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c6afdbd6e1cd..6a231a5b0d62 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5140,6 +5140,13 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_page_array_cache;
 	}
 
+	/*
+	 * Initialize ino entry info early so f2fs_drop_inode ->
+	 * f2fs_exist_written_data can safely take im->ino_lock if mount
+	 * fails after this point and triggers iput on cleanup.
+	 */
+	f2fs_init_ino_entry_info(sbi);
+
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
@@ -5184,8 +5191,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_init_extent_cache_info(sbi);
 
-	f2fs_init_ino_entry_info(sbi);
-
 	f2fs_init_fsync_node_info(sbi);
 
 	/* setup checkpoint request control and start checkpoint issue thread */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
