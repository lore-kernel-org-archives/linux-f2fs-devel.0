Return-Path: <SRS0=nB2U=U7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D8FC5B57D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:39:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91452146F;
	Tue,  2 Jul 2019 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="hyHE/wQj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QEkoVaHV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Rctr8X8N";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="I8u313E8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91452146F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SkOBizpS0RI8Ora4fbHMoTODRk4gz89hNp2h49DaAf0=; b=hyHE/wQjc0JmYe/YnR7EiLX1tJ
	S05KOX3ekA7jneKCdPrKJn9V0XxL9/xH6a4ZMzpXTAoWj8JfgOsJz/pl8hwvJcQzO0ZhYvWYxFcPt
	7krEAJCwd3wUKyCLgHDZ3BKboLhCpmR1iHmUV/rleEPb5Bd59Bu+I17RSRYfJk+95E2Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiDNb-0000qb-VY; Tue, 02 Jul 2019 07:39:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3hgQbXQkKAOkZNPLYNSPYRZZRWP.NZX@flex--oceanchen.bounces.google.com>)
 id 1hiDNa-0000qU-6V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 07:39:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=; b=QEkoVaHV2Yd0ID4xzQ1oSXXd1l
 j5a0YpD/2Tp40PX84hE31o1Rf92BKdXw99LDVJsJJ2ihw/PrJirySKkmevnqZ05iO55sUDAfKaOmT
 ghDQIUnd3gFeCO8Xoy38wDrYggYT8EneX1F9s+EAXANEARuvlwwbfatMEaUctjRHr73A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=; b=R
 ctr8X8NqA8JoIfwqDxO7N8kPWwbnzekYeIvgiVEo5KbeYNa+QId3xNw1RwsivSFeTfj2cTnRJLpnE
 pxlro77Vicwjk7ieUKYBNs2MvV0npTApsxaAO0LcOfaSAIudplCky4bBEWaxxJQudC3jZ1eMsVJjD
 xLnTfndHnJ2L5FYA=;
Received: from mail-ua1-f73.google.com ([209.85.222.73])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hiDNm-001ahM-Pz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 07:39:21 +0000
Received: by mail-ua1-f73.google.com with SMTP id q23so2921147uam.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 02 Jul 2019 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=;
 b=I8u313E8FBDrYJbHjZTqlq9VFU2xsZDW/+q0ovmtc6t5f9akeBUHu4ahrsM5qqlBxU
 +wqic6S14w0ZfSbKtCZYxIRdeM3SNZscRHz6YumpcCn+qA7gKfM6ZLvRQTljOuNl/7dY
 0vogG0ZPjZvUecplrxHpwaDiB4qufA2wonaIZUY1hq7CrZc1BsWNwOsvN0XgOEPInKA/
 a3sAOB5ExVdMRqQJZ9PMTxtKQavFNSontACIoGATuBaO4n3/BAN4e7YwXZHaz/bCnoWW
 Bdb0IPtLchhv0XEsSS70YRGodKiO+AwwnwC1HYxrKSw4nco/9zIkbV7n5viarectEKop
 6b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=;
 b=dPS3rRlSgn3fUd4VEHFRTGIYtx/i8X5BxcjYorGP1H7+ZzcP1ILnNvnGOW+BZ+WEec
 j4aQXK14oDAiH207QH171GdtTEdp1NZ0LnafHCJ+k030bAAD7auaa6XfGgJTjjDrq1D1
 gdPyIp0B9Mfivr4iCZt/vSzZxuJmUzTsotymbso0XB7zPeN/hgqVt0GAp+gMjCJkpY1k
 H2UyvVe0/n1T9WsxhOtHjJ774u0e8WUa8Xq0IS/VIlK+CmMolb6plV78wQyg3AFiKHtr
 MKsG3NMDrcejzkLV7rF3P3CUSxgYvPW+U1mmV/sW4DQvQy3tHDkeQwAW3NKchnCP3s5e
 eKLw==
X-Gm-Message-State: APjAAAX/XqDBbmupqxGtFN69PA0UZCbMkwdVdLBoL1iQI0TiY51b/3hB
 0ZCnQQ8Aa2B+u/7IG7t8OjDWSHBuW5lWakE=
X-Google-Smtp-Source: APXvYqyNbkUWK4ZjMisvx3QNm+os2jiG+ShivAJCx8Dft26tvmFVMGPVIfe17cJhkyVPwEZgQqTehJX9HdetKU0=
X-Received: by 2002:a63:60cc:: with SMTP id u195mr28865210pgb.13.1562051718453; 
 Tue, 02 Jul 2019 00:15:18 -0700 (PDT)
Date: Tue,  2 Jul 2019 15:15:10 +0800
Message-Id: <20190702071510.158351-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
To: jaegeuk@kernel.org, yuchao0@huawei.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Headers-End: 1hiDNm-001ahM-Pz
Subject: [f2fs-dev] [PATCH] f2fs: avoid out-of-range memory access
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
From: Ocean Chen via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ocean Chen <oceanchen@google.com>
Cc: oceanchen@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

blk_off might over 512 due to fs corrupt.
Use ENTRIES_IN_SUM to protect invalid memory access.

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..b83c23ebae1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
+			if (blk_off >= ENTRIES_IN_SUM)
+				return -EFAULT;
 			s = (struct f2fs_summary *)(kaddr + offset);
 			seg_i->sum_blk->entries[j] = *s;
 			offset += SUMMARY_SIZE;
-- 
2.22.0.410.gd8fdbe21b5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
