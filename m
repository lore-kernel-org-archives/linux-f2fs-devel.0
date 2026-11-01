Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3155606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bUzEdo3k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j8GfPfbP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kAdi0GoL;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CS/gaT+n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=1PYdqHmE3xdrnUBj+y26tii0P08ElGpxmDRwGXGHat4=; b=bUzEdo3kp0Q4Gc6q8AM6a2NGXI
	cYAcxpUqLOcHqp26LkmTnJ7RkaHwa6mezH3aTkzlAQkJ40Cm1V/AzlITDSmDSrPSudVbLpGb5KaDo
	19UjM3c0TmsEphZoWtg6WAbOzdToyb6qxwHwZeVhpkoMswFFUuHqFXwBMN687SGeT6zQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNecu-000000002qB-42Xu;
	Sun, 01 Nov 2026 23:06:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xNecu-000000002q4-0AHs
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 23:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J+cmiI1xqp/ujbUXhzswjXBwhXIt5ytt47fzXP5lFa4=; b=j8GfPfbPJLfvBYile31r2g4pKg
 DcBknozY6DNWOuIsnrSNIdTVxbmI/OJvyaSyyOOmS2IX7DUOBUKjCcs25jPnmwRNfKwfbUafYOANe
 XMG14u7Krk7FZGWARRTPvISZHp8t+fblA2MtEExfgwA/rJ/DPbMAFwPGZhyVRIReX9Tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J+cmiI1xqp/ujbUXhzswjXBwhXIt5ytt47fzXP5lFa4=; b=kAdi0GoLRi6VP56SKQCcISSoOw
 mWWh9Eu9mKbcVXkpAk7rWG98XEJfvqBePz/J0FIPdp3kQfKzY3V2SbaNKpqUAL05uQA9krdcKsFxQ
 BYTXW7jzurXS2i8WmNiY9GWH/VXUv48WgpRkszbytPV1NPLWJavYdkTFq5+4XLIyvM4Q=;
Received: from mail-dy2-f7.google.com ([74.125.229.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNect-000000004cZ-2VPw
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 23:06:11 +0000
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-368c26de2e0so763955eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 15:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793574366; x=1794179166; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J+cmiI1xqp/ujbUXhzswjXBwhXIt5ytt47fzXP5lFa4=;
 b=CS/gaT+nPnrzEFlf8p62mjke93T5Hu3D74cOKqJjEBirq5dmEMjmo/pffQE5iJK/DC
 r+SlXmK9JOB0XdpE5V1zN7oUSdPNn/nNyT6/gActI7/OH5FcIFn23GTIZQ6wskNm2yAU
 MooV+NxY2Gkxm3rpaxqFJiasVw24b3Gl3tNhDqb/BFuPU6EvtWG9NELrukJK6P2fEJfe
 tKrcOw3p75s6lKiEdpIkAznzWyG8noCAJKX7nm7o3t5y0vk1iPweQHXjRmyGNJAht/0t
 75Nhr5Dl6m8VGGaI3lWVr1XuZzyt5ZG41/2OrfgTaHiwXY4mH+sfWc6M7UiaGShCVJUp
 KHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793574366; x=1794179166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+cmiI1xqp/ujbUXhzswjXBwhXIt5ytt47fzXP5lFa4=;
 b=14yaJTVRS1OuJN5BiHvdJJqGuTBKrUnZLpD8YWBhMkTVTRzeDO1UxeV4Atp5V2sG9S
 YohKPZ/ATqVEscEU+TCHloojvxQg1m/d1TwIvlv4lSd4O9/wYlx3yUnBRFjqxQkwZum5
 brcHb2ppq8IWFRH3x//155iMojUT0KlPwVc/umr5JETGTn7mhFngowO+TDrGOcnD2R2U
 c0eOU5OHKQcUTBPdsWaXf49u6kDA7RewkpGoj6TVOolO9+R8Pg5iduU6IikDLQ69k3Uu
 yUi9gPk9N0/u49gOEiTLY4OKVBbycK78WL6w9tTAaO0mQ44blAvUQapBJF7neP6TABsV
 rvNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTC/EmfoSuv5XaZUxHB7BK53mEQKysGCfVnb7Kj6JlRa38Gj4ryDLEti+y6xFo6WgfxY75Q/qyW7o1EsgEBcyL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/qCjEnBQ1U2TP8ylATi6KbYuyO6mOpThdkbaN6ed7/wUWJRZ8N
 Su2PhEkaIVCq5PLc41b7qb8ne3Sk6XFYQf94rpL3gMMAAKzuA56plFreZPP+L7w1ZFE=
X-Gm-Gg: AYBFou0U15rxtwFr11cwrzxT8RxF2usmMVqSzS25gkxgMG6SeBVqJYRcZexiogVAUzf
 63k+8TFvUOzQkCRCnBJWSCXxP1bPTHj/CjVHebR2q5h/+djfOQzjklDvLRf7o9s5N7coGtRMWOP
 T7eSy3/wWYrnL1s4iXkCg3cdspQgF6h6KmVdKbaYuhI8K28RaNdNKZDk40liftGFHscE2ln76Ei
 nJMrcMsL9SoumZ9ThBwmaYLQcQbFmeD/5lPkAO2sMlx6pAYfoVCz2ixSXGr2K1ajH5+mK5fd754
 CUF8t+wlCqXpWwtit0qEusqUNh913MPG7uGE7nvUN/tbRMG4XcNQ9mFqcK9OQAm1O5hzvKS4AGs
 DJtjaiR/+uE9vK+zPJacnX4JSOZsBwFMIWXm2DVqC6qPyvOJI8szON9RC2aVTbmLXQtDrgfEBE9
 xmR4EoeNEnS92hX8lBFh/Nyz8EVAziwAMgqAhzdrGtFe6JUpvsU9pItA+vTRYxmK3al3sm1/cp7
 5O1KGmpzGjgm1r8GPyfc/OM+28Qo8kcdXyw8cmwqW77sRBS35DoebB4F3VEgjdL8BjxaBqtKWQG
 jqSc5cgGZwPXsypzLCs6zIVdM2KUbZJIJ3/vGsJL49XnPMupr0VaY+p0
X-Received: by 2002:a05:7300:d0a5:b0:36a:1b23:a1cd with SMTP id
 5a478bee46e88-36a4239359bmr12353084eec.9.1793574365578; 
 Sun, 01 Nov 2026 15:06:05 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42662f23sm35600582eec.2.2026.11.01.15.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:06:04 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sun,  1 Nov 2026 23:05:52 +0000
Message-ID: <20261101230552.55034-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNect-000000004cZ-2VPw
Subject: [f2fs-dev] [PATCH] f2fs: report sub-block project quotas in statfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-kernel@vger.kernel.org,
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

f2fs_statfs_project() converts the selected block quota from bytes to
filesystem blocks before checking whether a limit is set. A nonzero
limit smaller than one filesystem block therefore becomes zero and
skips the project block statistics.

For example, on a filesystem with 4 KiB blocks, setquota accepts a
1 KiB project hard limit, but df on the project-inherit directory
reports the filesystem-wide capacity and free space instead of zero
whole blocks. Quota enforcement still rejects a write that requires
another data block.

Check the byte limit before converting it to blocks. This distinguishes
a sub-block limit from an unlimited quota while retaining the existing
rounding and free-space calculations.

Fixes: ddc34e328d06 ("f2fs: introduce f2fs_statfs_project")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1071059f2cc2..f1e98f5fa350 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2228,11 +2228,11 @@ static int f2fs_statfs_project(struct super_block *sb,
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_bsoftlimit,
 					dquot->dq_dqb.dqb_bhardlimit);
-	limit >>= sb->s_blocksize_bits;
 
 	if (limit) {
 		uint64_t remaining = 0;
 
+		limit >>= sb->s_blocksize_bits;
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
 		if (limit > curblock)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
