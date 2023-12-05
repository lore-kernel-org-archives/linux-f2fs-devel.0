Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D4AC10DC1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Dec 2023 02:38:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rALKI-0001D6-Gb;
	Tue, 05 Dec 2023 02:38:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3EY1uZQYKABg1FCG2B4CC492.0CA@flex--drosen.bounces.google.com>)
 id 1rALKH-0001D0-Lz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 02:38:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=; b=BZPA2gKOuHfluET6u9bNdUBGp0
 /2cGsshg+N4bBapvF46rDMrgJacKHRGdWF3+y4gI1aREEYJtPghtOslf+dTvYt6aHwoLw1SnDJ7JX
 eXB9ktXvCiPl7nCQbQZvedHYaK2gcg1Rby50DOw7ih18wuRyoNGU2SSQyja+Z1cmAjcU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=; b=K
 NcfibxptjD7vfw/04uIaq7FEd7d68TT/zcnkIb8kTlq+5SQLzTXO9ZT7f4HiuJWdBwxQ6w20W/yLe
 44IREWwC/u13mKNSQcD6DeZDE/kV58Ht+nxhxfi/j8HP77kRJxdH89v8fF6A3RPJo6Fv6Wyp+CwqD
 nFf5Mz5rc1kaN0CM=;
Received: from mail-yw1-f202.google.com ([209.85.128.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rALKG-0003ZD-Pg for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 02:38:21 +0000
Received: by mail-yw1-f202.google.com with SMTP id
 00721157ae682-5d064f9e2a1so72856777b3.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 Dec 2023 18:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701743890; x=1702348690;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=;
 b=05ag8xMG+3wfNM45MPnltPCV1w7rFXpE39wA8Jy2Jov+IVdnUZcnpeIeBxTtQGFEqi
 tF/pv2AXgdawaVktUviuceMb46OGlXIcYZuPM5MYHOr6/QMvzrm7ktRq6TRLnDYqDuvx
 6ubw7d4YcxeBFr9poWDnd77qzG4xpO0L9WbbRJAaosifvCZOUwV62deshTrbiY/DqXlS
 hMTuuS5R72igm2IX0ZpVveUBKC3DXLDd99fn2RHAIBy9eKF/+Lo0xPo7dMc3DGIsBRXT
 gpApG89SOWRYIPDwAHlvEPhulc0anPS5r66IHjbeSfmLTOQctqijB7RwpHFcSrJgvrFr
 fUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701743890; x=1702348690;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=;
 b=T6YflQFgYVCww7fNpbwQNTqt/xhagUkinMXGjVXPLoj/GiC8DV5V0ZnTOcGUCb0aLV
 gIdQLjQZrR3rvos35WOjTv0ZmpF6pG8adIkFyQ/f89d6IK/9a4lsBfsbD3qNpqDJf3c8
 z7f4kCsTsJSOuIG6qGSC0/eSFXsGuVoPw6zf0ujp6PpuFKl22Lu5MfJ4hwJhc8KMRt//
 wzt8SX0KCkNY9nu5ea6NLxc2PWTiwga4UEVmvcXmjBsayvBvuSgcwLNYJkBEJOrVUvil
 P+M2x4pYALYupWgkRmDrzGGS9jc+Y9g+sCK1E+GQvGoFXlxcmJHVbnLdvauEJIjCs4+k
 uhGw==
X-Gm-Message-State: AOJu0YwAokYWBUynHA3pcAlMg0ksLfdna3VElx8DdZJtC/iCyt3+hD2T
 ZXirXAFe1wDITYD2OYuZbA0IjVoqnRYz+j3D5vbvZVHryb9vppewJMbUKEPPsBHsPa9HvCGQYKJ
 uVnp1HUYn5LNaOPRCSkuRgOqfEWCUCTOh1A2YgoQRbHxp3eDCV36X4bR0Wd5VAokDhPh7rncsFT
 qVGGL1xJ0=
X-Google-Smtp-Source: AGHT+IH66c/DcXoUES/OjQFHfKfa4wp28KTZsImTGDG6MYhRnIRLKo451oU0sYuWQc272uiv+NUawl/qMJw=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:5074:e7bb:c7b:6a8a])
 (user=drosen job=sendgmr) by 2002:a05:690c:2509:b0:5d8:5d2c:121d with SMTP id
 dt9-20020a05690c250900b005d85d2c121dmr102229ywb.7.1701743889565; Mon, 04 Dec
 2023 18:38:09 -0800 (PST)
Date: Mon,  4 Dec 2023 18:38:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231205023801.3669458-1-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rALKG-0003ZD-Pg
Subject: [f2fs-dev] [PATCH v3] f2fs: Restrict max filesize for 16K f2fs
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Blocks are tracked by u32, so the max permitted filesize is
(U32_MAX + 1) * BLOCK_SIZE. Additionally, in order to support crypto
data unit sizes of 4K with a 16K block with IV_INO_LBLK_{32,64}, we must
further restrict max filesize to (U32_MAX + 1) * 4096. This does not
affect 4K blocksize f2fs as the natural limit for files are well below
that.

Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..5dfbc6b4c0ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3364,6 +3364,14 @@ loff_t max_file_blocks(struct inode *inode)
 	leaf_count *= NIDS_PER_BLOCK;
 	result += leaf_count;
 
+	/*
+	 * For compatibility with FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32} with
+	 * a 4K crypto data unit, we must restrict the max filesize to what can
+	 * fit within U32_MAX + 1 data units.
+	 */
+
+	result = min(result, (((loff_t)U32_MAX + 1) * 4096) >> F2FS_BLKSIZE_BITS);
+
 	return result;
 }
 

base-commit: d346fa09abff46988de9267b67b6900d9913d5a2
-- 
2.43.0.rc2.451.g8631bc7472-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
