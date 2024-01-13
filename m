Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA06C3DA79
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Jan 2024 00:58:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rOSLt-0003aN-27;
	Sat, 13 Jan 2024 00:58:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rOSLs-0003aH-3j
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 00:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WwMOv20L6mcoR5r8Xi4uOTrP99y9fZsD2LnXxinGE64=; b=kjS8Fvha7ouEjrMzJBTs1jsYpQ
 yeSAXGYNKPWzg5V79jPcQI7km+kmPXmdWqaCO3SqW83usbw2ejKf2qlUmYzY17RlTkEElIDZfOysO
 vvrC1nrv6hz7vDddV3n6MsZd8S0lS8PVr1Y32xSrmRpgH/Qmllo3HjBPqBlA2fnavhsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WwMOv20L6mcoR5r8Xi4uOTrP99y9fZsD2LnXxinGE64=; b=Os4VcRDc+IoC3B2V1Df+LZ1uUd
 zNMQvdviLt2WECgS+c+kz12ovf5RiFr+yfsI6BYiTUV4bheJFsrapCD5i4d/xfG/yFsmi+vlE0GGO
 m1vFH8d6eTp1vovauSYIHrq/hZpnWk8keAI0H9AQGlPCOba8el+xt0ir2HURMDDfVc8c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rOSLo-00062z-Lg for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 00:58:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 35DFF619B6;
 Sat, 13 Jan 2024 00:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB788C433C7;
 Sat, 13 Jan 2024 00:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705107483;
 bh=RxNtLoFlaYoXk2ozFC0KCCJOZR/NiydpaY6j5+vbHVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eODxrC7KJqSVwjjWLGXQnRd47j8WYnKrpiPNO7IihIkKkB4n2mbS9wn1Y7t/UBE1N
 IGKLNLQr2frucR76YgODf7qO5MDiwAuLPffUHVJMH4GqwDi4/KUnjqWPw5zZmi3A5z
 45O/WtByzkcXfywjqipJ90rkNMB1pwC18+7YL9Zcyjo6OPamM1XLTCmigXuvjmSai5
 OCEsehxvzP4ZDOvvgqUTMyUkIAzQbTjuMoeezu1HSZ1eQAW7bOxnkSdCMzysp23qEh
 q3SFWE23VnPmVlSFEr9gLRF75sK2cyKE2qVGFzQOk969EHHku9p4f2o9JL/DtE8cnY
 KbJbg2TJR23JA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 12 Jan 2024 16:57:47 -0800
Message-ID: <20240113005747.38887-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113005031.GA1147@sol.localdomain>
References: <20240113005031.GA1147@sol.localdomain>
MIME-Version: 1.0
X-Headers-End: 1rOSLo-00062z-Lg
Subject: [f2fs-dev] [PATCH] f2fs: fix double free of f2fs_sb_info
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
Cc: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com,
 linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

kill_f2fs_super() is called even if f2fs_fill_super() fails.
f2fs_fill_super() frees the struct f2fs_sb_info, so it must set
sb->s_fs_info to NULL to prevent it from being freed again.

Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")
Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000006cb174060ec34502@google.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d00d21a8b53ad..d45ab0992ae59 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4873,20 +4873,21 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
 	kvfree(options);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 	kfree(sbi);
+	sb->s_fs_info = NULL;
 
 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {
 		retry_cnt--;
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
 	return err;
 }
 

base-commit: 38814330fedd778edffcabe0c8cb462ee365782e
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
