Return-Path: <SRS0=R28F=VF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08644C48BE7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jul 2019 05:06:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C454B20659;
	Mon,  8 Jul 2019 05:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="H5bKjmTC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CA6ehysX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HY8iWVme";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="sKLUcW+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C454B20659
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=koHZqZSM0OTBHGd8CGNXJ/7zfR1sfTHBlK3cpsRosX0=; b=H5bKjmTCXHAvLCrwOtE67c6PP9
	jOboXTrOeivM5GTtfRhq4HxhpnKhNx5kFpjPVsCMzUSD/32/w5KD5PQN4Lg36EmaKuoulJRaGTFr+
	JojeufD9LbbVgstboRHuDRd50F8L8Dbh/VNAI8PWtzOgEKhVhUvfsAeAxJUHunTr2c+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkLrJ-00030k-TP; Mon, 08 Jul 2019 05:06:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3-MciXQkKAAMrfhdqfkhqjrrjoh.frp@flex--oceanchen.bounces.google.com>)
 id 1hkLrJ-00030T-1O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 05:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=; b=CA6ehysXns4OGddl3mVcaDOQz+
 HliLcjAkbYG93a2u166KewK5fwvQh6GCgWqviv4Xjgen2D45NzrJ/WrcXDkigT0p5eI6Yl6H2xqbD
 2i2uhw9PMG/DehU0EtNnykE7WOcRwK3+XdfzFnjHY4I6tF0Cw0xEuAztXMUU6GSsmOSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=; b=H
 Y8iWVmeHx8h2O6XPvXUkzoPdaYmdEubtGpkdEHqHfhklaeYgyqTtHCndv/lMe6t+E5KQ8viOk7jp0
 vTS219UWWT59LmCNrlM4A0iy1rxaWFVV7dGf6D6Es1mucczu1g+ZS3FtnZVNwVKBUG9u/k76/AkTt
 0nPSpsTGOv1iHMiI=;
Received: from mail-qt1-f202.google.com ([209.85.160.202])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hkLrU-00AxyP-AL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 05:06:53 +0000
Received: by mail-qt1-f202.google.com with SMTP id l9so8712955qtu.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 07 Jul 2019 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=;
 b=sKLUcW+1AVvD4gurjkaUeKr3T3h+1Ce/zVIQuwkXpjtLjl5Lu6U98TWRFj3lYeAPVn
 88/uzOSxmYlvCTjRXWoKzf28dtWHwwBSj98/yd3x/vwbPRD71mJyF2VC5k2Cgv6kZSzi
 kVrDeNiy3xnjrissfSeVPEHPcrO0nh+FcH4z3p53prykjMbt8H5xkIZifHoxSrsBDX3X
 yVNN8P85FYgnhgnR10ON8tV4JkT8vrP7kaJU3TUBmoJA5sG7AIuukJrDnKEKpZhd+LmK
 fwMj+FCCkexrg68AOKq8lqUD6la4/0W+VpR+my+KLuCG4mt0kFJUxB5lJ98rCi0OdlN3
 lt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=;
 b=TAmie+V3Ss+ap9W4dgT6ER12Pf9KnGXlbfCeeKx2XWt3rF5nPZm0gJ9RpmMqLRXovt
 6jQzEMxvOO1uJcmYopGctfX4UOMPeKzmfyY09GzVpRgIm5FADv0oGqpoHGXE/I5Yp6vc
 BhNBSU8FhIQ0cba+rXdOREbaRw0rJBnKY7spjBlrf6k0sGWL6iz3lgjaSxf7I1gsInX+
 aijbp87rrtBblMwfmybVFaWaCPOuNKfmpIndPlvXEPTlXiIwO6h2vl1a3LhGpn0C5PNF
 ZvQORLmhtWFA2CBQw9Y43VmjpFhaRQXnSsV2iFrDCK/M31PGADofgppyzgkTuMIftWPA
 URpg==
X-Gm-Message-State: APjAAAUAChgnbPZaolH4R2R0oAm2GFfuXnL/ZkgpDbGgpkUMNyBidiup
 GE4D1Ak6heG1d385pWvC/cuL9816gWBdYok=
X-Google-Smtp-Source: APXvYqzxmwyW7+9NChV4+1X0v1CXImtnFbHy/0ZLto0TjMjM8rtoUvRfouj5xppedFpXjkwtCOzh0qJ5l2M4SUc=
X-Received: by 2002:a0c:ae24:: with SMTP id y33mr13364324qvc.106.1562560504076; 
 Sun, 07 Jul 2019 21:35:04 -0700 (PDT)
Date: Mon,  8 Jul 2019 12:34:56 +0800
Message-Id: <20190708043456.24935-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
To: jaegeuk@kernel.org, yuchao0@huawei.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Headers-End: 1hkLrU-00AxyP-AL
Subject: [f2fs-dev] [PATCH v4] f2fs: avoid out-of-range memory access
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

blkoff_off might over 512 due to fs corrupt or security
vulnerability. That should be checked before being using.

Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..ac824f6632b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3393,6 +3393,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		seg_i = CURSEG_I(sbi, i);
 		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
 		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+		if (blk_off > ENTRIES_IN_SUM) {
+			f2fs_bug_on(sbi, 1);
+			f2fs_put_page(page, 1);
+			return -EFAULT;
+		}
 		seg_i->next_segno = segno;
 		reset_curseg(sbi, i, 0);
 		seg_i->alloc_type = ckpt->alloc_type[i];
-- 
2.22.0.410.gd8fdbe21b5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
