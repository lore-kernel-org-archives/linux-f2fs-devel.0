Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D8606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FY5X8bs4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RC6e6N99;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZpvBA8mP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JxgmvRCZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=KTCm65Ey3q3/Ht37XmtLchTVqJMjRdMtCn1Ws/YRX2w=; b=FY5X8bs44pr2GTdRXOt0s+Vb8C
	ewEN28Nq2yRB5xo4JEfxC1yT3FFsw3VN/tluFyry3zcMAxw4dA7HYY8XfLG/MCJquWbb64BHkb3p0
	fn/Ed4LxUKbXV1jB35EABSsQWcVCKPy9RJEKrpLoTYdwCJmPk2Gx5wZAG5Gxyt8KNucI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL2YB-000000002j4-417e;
	Sun, 25 Oct 2026 18:02:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xL2YA-000000002iw-0lEk
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=khTvN3xc7ITOTbWXYLQA7dLPyGE8iHwlLNDqLgj2tM8=; b=RC6e6N99WJt33bFWHwK46Pybuz
 obu6293WhNz22w4lSZ0HyqfmU5OBdJ8inOJvjydAqbR1gtLUQFZw3T9Jl2IP5VLL97g60MvfVTbNR
 B/NjMvq5u/s13fniQU6GSAwlr/ycVY2lKo57Xxl39ggFJkzS1TdYy7XSJ9EJrTH8Zxpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=khTvN3xc7ITOTbWXYLQA7dLPyGE8iHwlLNDqLgj2tM8=; b=ZpvBA8mPL5ykFD7cCAljZNGsUh
 yRW+QAlK9mtCa9edQpltqBEJGmgXfrk4+NS8saJs2Gw9xtwCfU4WTBjY4Gg/2C//0FxyE7Oaf6rQ8
 ztk8266jw3grbQ0bQ+xVOCA2IpMC7Bd9xbvXw38Su4LTnMyO7fNZPoFAF6SZ2WnRqWBs=;
Received: from mail-dy1-f181.google.com ([74.125.82.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL2Y9-000000007kP-3IAQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:30 +0000
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-35d0be18c71so3991292eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792951344; x=1793556144; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=khTvN3xc7ITOTbWXYLQA7dLPyGE8iHwlLNDqLgj2tM8=;
 b=JxgmvRCZ2RcCIpYCVuGD/0f2OQfGC0Z28i5HVXQdq/IqTYdsl4MZku1jXRBeg3rHF6
 z3KTiLEh+HtLB3l+VwBu2HKCm92BryCEW0yPj+TfluYrCNwJrf5+qpALOk8pIuIwajZ4
 TNYwNrnbs4mVa48MCOFp+tS6Ayp+6uDHIADoLiJiiLSbDPyaV9PSnznJUNOXj3gIRpov
 nNhWCVGm7aSfFM/D8zcR9bMTOL2iv5nIc1uBXF+ZevGWU9zZf0r/tRrSMqrp/ZPDi1AI
 657bICLq1clzu+/tiKf3rvw1haqrz4QS94ahyP2wpWtQd15IYtd8hwVz21FQgkXIrUya
 2Egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792951344; x=1793556144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=khTvN3xc7ITOTbWXYLQA7dLPyGE8iHwlLNDqLgj2tM8=;
 b=fPxdYNg6QV2zsxaU3EJC7nbS/U59HI+IfBPPEkRilR02R9Qd9OKQt8W2TPbDVMHOMk
 EUzPlCv/YpWEwOOPfn74PwQs9S7gVnP7rranvs71z2syojh6dBpC9ijFe0uGAHseDZhb
 gLtE+hhUYbTpI4oiJ0X/zNPCezoZba3/QqZqyq0h8uQQFAGu++GA4blxboTGLlbDu7KK
 A7PfSD17g2qzewGZoCjdXn6ytDuUHhRFThOxofZmrUyHR6RGmUn6Y13vOUsApHMNU5ux
 Drxq7l+hUYjyYCG4NfXkAkrW4fga0XqadIStLYwI8AD5hB27EYVnrlWOuV6E0OOKd12Q
 0cKw==
X-Gm-Message-State: AFq9FYKkRp1wAmokq2Gbi9OhNo8ylEUeHOEwaxuJgYSFByN2aftROEFO
 HkpbamzhhwRuhiDrwryLlE0YhtqD2kFQ68VMw+j/Ffwf0Udgah9x89Ls
X-Gm-Gg: AYBFou3k14hgVUZFSXBAjpY40E5G8UKL28TiVzxaxWEQK2Qx7ve7l0szXAYvrrXdFYO
 Sm9m/FEQtM+Q5656WKuZWS5fnLmm4evxhoQ3uh6dfJORKlL0GPWfSkENRyMVzcMaat/xEviP3ce
 0uhR4U0FJKBQgcAfAwsvyDZurNP4n7NOKTVYN8HsoFcwzk97NUsjSho63VvWSnPCC6LYO4sx1kI
 qHcJINC04Pc+YR7VQYYqnM4wjPQEUt5n4QphnyvwMXqZexP2aXXVTLWxVSW58iZzuwEt+YQZRoh
 O3ghcWEbKB0kGajpi9e5JZ5WnrC+/9nh8oTKk2Ump67E/HJMuo7RUWM978CaHfGulAJvV5ZY8tc
 GoG2TGAgntDx/XcTlCAWDfpjV3/O0+dZj/G3em586phZHbG8+zRAqU2dh5uUaGilJwl8wvfoRLK
 khMfqTG4c+zx2rf93dNEwxWHGjDjRs8dQ+7Wtl9SXvLI0vzF0q8n3ag1Tff4itSTkAGTKDxfq9k
 RRex46xLCTX94xscHS1B+c568TYYX2iRdne12k7S8Rgz9svI0nmZTnjdopWYrcYydDWTJlEEWKU
 ehI30Ue6AKrPIhFS84CtVgpE7giz0DdZeqrbCFSO
X-Received: by 2002:a05:7022:d41:b0:17a:a3d4:8b17 with SMTP id
 a92af1059eb24-1994e81a865mr6545141c88.12.1792951343776; 
 Sun, 25 Oct 2026 11:02:23 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5a515sm16099227c88.19.2026.10.25.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:02:23 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 25 Oct 2026 11:02:05 -0700
Message-Id: <20261025180207.348498-2-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025180207.348498-1-teel4res@gmail.com>
References: <20261025180207.348498-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xL2Y9-000000007kP-3IAQ
Subject: [f2fs-dev] [PATCH 1/3] f2fs: reject non-directory parent inode
 during dentry recovery
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Cheng Yongkang <teel4res@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

recover_dentry() takes i_pino from the on-disk inode and uses the
resulting inode as the directory for __f2fs_find_entry() and
f2fs_add_dentry().  A crafted image can set i_pino to a regular or
special inode; the recovery code does not check S_ISDIR() and then
writes a dentry into a non-directory inode, extending its i_size and
changing its directory-only metadata.

Reject the record with -EFSCORRUPTED and mark the filesystem for fsck:

  F2FS-fs (loop0): recover_dentry: ino 4 is not a directory
  F2FS-fs (loop0): Cannot recover all fsync data errno=-117

This was reproduced 3/3 times with a crafted image and the patched
kernel leaves the target regular file unmodified in 3/3 runs.

Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/recovery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index aaa5227..e40f66f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -209,6 +209,13 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 	}
 
 	dir = entry->inode;
+	if (!S_ISDIR(dir->i_mode)) {
+		f2fs_err(F2FS_I_SB(inode),
+			 "%s: ino %u is not a directory", __func__, pino);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	err = init_recovered_filename(dir, inode, raw_inode, &fname, &usr_fname);
 	if (err)
 		goto out;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
