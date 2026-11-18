Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF39606A338
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mmg8MCjL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jitwK0hb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mjsZA4E7;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZKJmbVi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-Id:MIME-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=GxzY4mF0lH+MnF1Fasye/FwmbQTEWLxFVQbvFmcOSTo=; b=mmg8MCjLAX52CNHh8xdxI9XVS3
	78Gcu5TY+b0/kPZeaZgXegbao5PX2ieQCSdUkfiKE1kHxhr/jx1Ct75+XHjx3gMAVvt3yyUeLpsoO
	R96E6j8Uxhp7IAvOvBK1FxPdSnwILZdLoEmqshQRW/M3VHzwH2jLS0nAhdG51LAb5p70=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTfAN-000000005bz-2gYH;
	Wed, 18 Nov 2026 12:53:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <devnull+shyckless.gmail.com@kernel.org>)
 id 1xTfAK-000000005br-1dTR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 12:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding
 :Content-Type:MIME-Version:Subject:Date:From:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a4QGCnrwlxC0s/gYdasEzGsyCKg5zxioqQGPp6K+YLo=; b=jitwK0hb9eIrkIc635gZgiSBoQ
 bD9ETUtTV1bg9CHe6vfxqR7XmFyb/rPPb79pTeUBdeIfimalmIx9Kfy/fj9FCN/G2/aKVH5qhPBse
 pUzQKowMRC42PqMSozZZcS9169qqknhrE2KFTNjw42nocSFaF2ycdHyyFDubwQqwpFoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a4QGCnrwlxC0s/gYdasEzGsyCKg5zxioqQGPp6K+YLo=; b=mjsZA4E7u6OZLOZi+AMSeWwshk
 omHr0oakWrpgKlwlco+PUX9JKY4GdIE2+SHhMGDdq/3eOAKvuouMw26C8S2xYIRhfb6Tuvb54PJq5
 y2IzbdL1p+lY7Af1QsEWxOLPnRTsYegfnNNBK+uhpfOlQghN2F+0uLiGuPhbNDFyihbA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTfAF-000000006kl-2cTu
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 12:53:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C27345C4E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795006402;
 b=ZxWpLHPcw827Ys+4xLgnnWWz5LlnCI4ElHGT8gTLSA2qOC+cHIYeNbaUaf+BpJZs9Xj4
 IP4tPPQw8ux/hPsCPnKhMJan7J9OUB+9J0SkvnjMV4AHgjJgJK0FF+lPQlPh2hcuWdwQl
 g2Iewhcieu9E6CcAYPMVxdY9LGOa7Qdgz8rP1qGEyLhisKVCc0si5wXV6zcefMUid9NZw
 MFU686zwRzWBZzEkrNCdcvr2JABYLcrx3JIVmdQue+FQg4cZTz16E/sJK9Eq0BWx2U/Lk
 Ks/mT9cyS+7vJyGV51YQlHWSt3DZaWmm+11N0dmP6G2yiRVKyHIR0BobFOwNN76umsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795006402;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=a4QGCnrwlxC0s/gYdasEzGsyCKg5zxioqQGPp6K+YLo=;
 b=MJlpgU94uWv1+QwxS19SWcug5wR7eTfQ3LfgkkYdP/xP8t+8LByGk3ayos14xLoVwFpx
 4Gj0oOJcVfQs94YqSMtoMrYHOGdv2Kz/KsL1gYCEQojD2GVwCS7O2vv4jUMjubNp5dUUc
 Vcwy4a8JoEvtpBb2ktvIlyYAXr93b2+2YegEuCqiKnVqtLcudPUFlqefxt4cGBT6r6Gyp
 kYrECOJYNHtDqz1x77mbzl/9iFOpdheadCl3aQQBRds3z4vLpHFRplyJTaNmpoOqFOwc3
 LYMTWxC5lB3sDSNS9B6nSsq77b24oSEW7ZwK1C1MZOEp+R8R1r2FTXfYhkMxTfZGNPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A4AD71F000C4;
 Wed, 18 Nov 2026 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795006402;
 bh=a4QGCnrwlxC0s/gYdasEzGsyCKg5zxioqQGPp6K+YLo=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=kZKJmbViIRsUXABtMSOvCpSbNGlw7QU5242iXLi1KMOxq5EPUVQ5Ua0FJtu3ScXun
 yXNLjWT5leVqRR0fPMt0rZGTWntsJP7HUB/zC5sX3C3ejddz4QzC6Ew281usGcyRS9
 BYdomIDbgh/ngqN5ba0Cy9dpEN+wPBkVZMsq3GFYkOt7M8oZDW9TUCn2S30MAPtEGQ
 bvcOWv1SAZVIe5HQRGffTImVkDTwZImPjPdSQiJFVrgrMfPIK5psO5EFmpG10Uv4/a
 ENyvDU2qPLqbmhjlR+Q5Q6iFYYBkb/uAsPnQKI37Kkvrx5CJ+vAaoOkstvtaLxfWel
 xxN68ba/c4cWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 00E274AD78;
 Wed, 18 Nov 2026 12:53:20 +0000 (UTC)
Date: Wed, 18 Nov 2026 12:53:20 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261118-f2fs-gc-v1-1-297612253f6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL+f/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0ML3TSjtGLd9GRdI3NLI0Njs0RzAzNjJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tACss0+drAAAA
X-Change-ID: 20261118-f2fs-gc-2792136a7063
To: jaegeuk@kernel.org, chao@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795006400; l=1817;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=CnaJBZLbNSkqbrUrG6Geieyu9/h+9hR1JQWRnrfCtG0=;
 b=gmxM3O37yU6iQwcn8i11c4Qjn9+9bQNCjnDuqrVqffwHf5d8hiGWVCyq2vaPTmw2NVbCSkv6H
 d5U2Xx0zn5ZClzra6lpw0eh25Uj5PSSm8QyV1/GXLzioyr6n3/nZmzv
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xTfAF-000000006kl-2cTu
Subject: [f2fs-dev] [PATCH] f2fs: don't read inode->i_ino after iput() in
 gc_data_segment()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Suyuan Wang via B4 Relay via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: shyckless@gmail.com
Cc: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suyuan Wang <stevewong@hust.edu.cn>

When gc_data_segment() finds an inode that has both the inline-data flag
and a data block, it puts the inode before logging the error:

	iput(inode);
	set_sbi_flag(sbi, SBI_NEED_FSCK);
	f2fs_err_ratelimited(sbi,
		"inode %llu has both inline_data flag and "
		"data block, nid=%u, ofs_in_node=%u",
		inode->i_ino, dni.nid, ofs_in_node);

At this point the inode has not been added to the GC inode list and
i_gc_rwsem has not been taken, so nothing else is holding it. iput()
may drop the last reference, so reading inode->i_ino for the message is
a use-after-free.

Move the iput() below the error message so i_ino is read while the
reference is still held.

Found with a static analysis tool and checked by hand.

Fixes: fc01008c92f4 ("f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only (x86_64, W=1 and sparse show no new warnings). The
use-after-free is in the corrupted-inode error path and hasn't been
reproduced at runtime.
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5b948c92f981..edbfb45f15fc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1664,12 +1664,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			}
 
 			if (f2fs_has_inline_data(inode)) {
-				iput(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
 				f2fs_err_ratelimited(sbi,
 					"inode %llu has both inline_data flag and "
 					"data block, nid=%u, ofs_in_node=%u",
 					inode->i_ino, dni.nid, ofs_in_node);
+				iput(inode);
 				continue;
 			}
 






_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
