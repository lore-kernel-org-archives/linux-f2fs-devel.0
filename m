Return-Path: <SRS0=4Diz=UM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC27C31E45
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Jun 2019 07:30:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C9420866;
	Thu, 13 Jun 2019 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="BW6DLH22";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Xi6a55ZZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArRXqZVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hbKBY-0003QL-55; Thu, 13 Jun 2019 07:30:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1hbKBX-0003QE-Cf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:30:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=; b=BW6DLH22soU+hobixGQYk+14PM
 v6Ljx6jYe15D8VSgZFHIYSTKPP/Y6/WSAjjr91/bDYSc4ExFLs8bjBk8r8yweM0fGyUeOenXSnRZt
 g5n20XBFu5GUJ5jeFWD53lqo5yRhimvDMcvLLkMYpX50vqcXNgpesr3lsO7yDGn6nYbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=; b=Xi6a55ZZy8ArzQRvDPsD9KjCQ1
 P4RpiwXDL/vMQW4ORc3yzqO1LG0moI4I4Ok43E8ZQJ91GNkD8BhCwwuAy7uwvoD5Sr9JUOOCqHbSa
 o80gKTk5zpdTXACjOUF95s3EBeAIvPv1WctrM7UILpUb8EAO/O3jzFxArQw/O8iu9yLs=;
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hbKBT-00BDaj-Sf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:30:09 +0000
Received: by mail-pg1-f196.google.com with SMTP id d30so10421842pgm.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Jun 2019 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=;
 b=ArRXqZVW1D+UbLnknXN9OXsIDawu3+MiOzcE0HL982+wpMebdFKSa7MpmyxPH+55fL
 w8ALPRYSveL7+hP/WjTYfieqwTM3Y03Dl4WZ9qK0ZEMDjwlY2b416SXX02vhv8YoAnLe
 T/KrJaYvSWSktg0R3JoSEvfBgsyVkkdCbd8u5Un+XeebtbSr6Xd/hH9vBWULiGzltorv
 FIY5PLc5u6+oIR06lPJgF/IvszBhW67lDvCQ+XVG9bU3Ldo5y/YTDJz4fVHR71rLhctu
 jA1Xt2tSINfofasWT2yYm9+N4iIZIVS47k7D9RquSgi/RbktfwMtxAMtbk7ln+c6LNAL
 BOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=;
 b=Pt63WVI+cXOphS/m9x1pVcghfr+j4pwc8+EPWrT7ottjp5bWlb81pqBugvqzYg3zjw
 Oo3ftjBJyc6OEClJYxDETO5yIOxsT3NkVSY+7cSVLXHNY+q18JLigopxQAU/O0Nilwfv
 HiFg8jdo9qpdQoR0w7JnIpleI6pkUY0y37G4K4Yv1fUW/NmkPQdlinnAu7qjhCUlAHJO
 ez5INIbQiRwfWjVeqTe38bI3atRHZcc+FkFyYR2SZWxeYnhYQD2wCzPdxGTVQS0TYZul
 1pOdBnByDO7FmxjQyORCJOAPZooMSWnxVS2L5AjyihEpaAyABL6u8+4e1kDqO9ISPtCg
 GU7A==
X-Gm-Message-State: APjAAAUpERAUI+ZRcgQhqRSM68GOd0ZxLC1q/Zq36NfN/7bGT31S3PHZ
 1/zQUJV8wuNvUqGTbLIGKNE=
X-Google-Smtp-Source: APXvYqx9LOyJlN7JCESutjlDMpgZkKe8AL0z9fFbPjyztiBvf8HHIMUoaTqoW6bWdkPL3//MBb18fQ==
X-Received: by 2002:a63:5152:: with SMTP id r18mr5986063pgl.94.1560411002155; 
 Thu, 13 Jun 2019 00:30:02 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp.
 [39.110.200.14])
 by smtp.gmail.com with ESMTPSA id y14sm1325013pjr.13.2019.06.13.00.29.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 00:30:01 -0700 (PDT)
From: Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 13 Jun 2019 16:29:53 +0900
Message-Id: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
X-Headers-End: 1hbKBT-00BDaj-Sf
Subject: [f2fs-dev] [PATCH v2] f2fs: only set project inherit bit for
 directory
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
Cc: Andreas Dilger <adilger@dilger.ca>, Wang Shilong <wshilong@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190613072953.aHTXy1Ipc4E7k2ixT3mQebaatD0xX_i_tux6GJXShsw@z>

From: Wang Shilong <wshilong@ddn.com>

It doesn't make any sense to have project inherit bits
for regular files, even though this won't cause any
problem, but it is better fix this.

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v1->v2:
don't return project inherit flags for regular files
---
 fs/f2fs/f2fs.h  | 3 ++-
 fs/f2fs/inode.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd2bf0f559b..ab176a92fa55 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2385,7 +2385,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 			   F2FS_PROJINHERIT_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
+				   F2FS_PROJINHERIT_FL))
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ccb02226dd2c..8838e55e7416 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -343,6 +343,8 @@ static int do_read_inode(struct inode *inode)
 					le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
+	if (S_ISREG(inode->i_mode))
+		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
 	fi->flags = 0;
 	fi->i_advise = ri->i_advise;
 	fi->i_pino = le32_to_cpu(ri->i_pino);
-- 
2.21.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
