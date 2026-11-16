Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2077606A887
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eZ10NvGR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UcKoHYtq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BicZ8eNb;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOFGXWgA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=YzVTkxuluYKC+/lsiAHJhxW8Zyp/tpCBvhP7bJYXARQ=; b=eZ10NvGRqvsBuBDcPPzmr+hzul
	3BpJNW7RDUp0HHyQWF0+baFuXQdQdTIPUk5xYAAUOG6VjwiAVLwoUA1SIKz5jGSHArO2uHOzsfpU8
	OjnnpZ9cXtn/YDDRf1k82gz3ppZyb48rXS43I6HSmdJDdnnchSFQlHeS2PSs+vzYGqQo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2O-000000006kY-2OH1;
	Mon, 16 Nov 2026 04:09:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2N-000000006kA-0q7i
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oHMCTpM5FOw3/cBC9wgKrj6AogBZVAMTRb9RMaIUNTs=; b=UcKoHYtqWvEgAbJ4xQj+giSuIS
 RFlyWiJ6DeYJDUc2BnWbjll/IANW80odXuUpqPjIr7rwi4eVn5Db1Fgxgp9tFpWqfIXgbuYIl4Qsq
 PKZ7figkMirwCF2Y7gpp+WhKltcVDn7W1DkyYJfBOv2bHcpE/MLJDsqqoCuvJxlNv97E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oHMCTpM5FOw3/cBC9wgKrj6AogBZVAMTRb9RMaIUNTs=; b=BicZ8eNbxnpo52u1IxA8d0/gar
 oPVAGYi+Gb7HkvO+mBT7Hhf8SkhXXTBHPmUqUU5vhMroW2iVTH+WFsP9YGKJsq0EKWDwJ0T1E7TX9
 De51mfkzWNokSDpx+EUkVEd1KFVyDAzFbGmfDOKYTgeZLbgnhN33RtxAQeMf8/CiOthU=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2M-000000007dE-0qRF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:47 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3b16896b8ceso1330419a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802180; x=1795406980; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHMCTpM5FOw3/cBC9wgKrj6AogBZVAMTRb9RMaIUNTs=;
 b=vOFGXWgAOBrMRdS/6kDyuxEKROGT0WVT6BQ1bwgM8WKv19g6ynl1AzkamypMe7fryu
 UjNJMO4kV7FMqqIPFr540d6TObmnvRIYEq6+IhlgIJlZiVLO6bwdsWWH9YiVkp1KwBjA
 kMNwyKEw1tj0Xq1xaVMRBYzor3LaB3P2YNZsScoVAYcvjWayOWlPvJr9BgDAvXpUdJ2N
 fJTSfMnsrEvEdn5J+eLK4W6iSZRXUAT+GpIBU8gHhtZ+XrESawkrgGyVOs676r0XMLzi
 SKo9sGELISrgwNuzUetbCEJL5xvfA5SP7kln2j3JfsiYjNoM4NM3T8WBdg4aOR+mXLC2
 nwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802180; x=1795406980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHMCTpM5FOw3/cBC9wgKrj6AogBZVAMTRb9RMaIUNTs=;
 b=CH/9b0IlfZSkvFVGFvZ6i6ZpirzFLk/gIJB75h900HH9FnRyhz07h9NTfWzwRvtP9d
 A07Mbbi1I2jZ57Lnyq8kiMgQKX5CqCWeZDcmxf+JapEwnHQ44LEwwZ7MIl+zqBCqrypH
 yG5MWagthClkfMEOEPbyBTeIHfs7UlsSWrlnJBXD9FkUO5hq6coqF1M+qd+ZnVE+atS/
 O5Ta9eHqHg98REx8wVTUsfcZz+kCqRTdogBgz7NQct8nGGxOEmvvESVFrFpRNd5ggD7K
 1Sw469vXQe5zdgN0kXk0sVsn6Qm0NJLpYCllUVcRAm+ucvc9cYrs0NbLd+u5yWiaa9C8
 xZNw==
X-Forwarded-Encrypted: i=1;
 AL+hErGjdxXnQaO7oPqM17LIZR9MBnCNkGpxe0N/A5dZgrtSzzfmhdBSe11PNrPFlXqrfuKp0h3zCdrgPxHdFLJ2v+Li@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8tEsx3Vpsi88nHQn/gOGdLp+8W/h3DFE7k0djKgpenJ2PxAI26
 dbETxKYDyVAwVf5v5BwDA9JiKHSUE3wf6dHBSw6pjLLnFoPvaR1lnQqo
X-Gm-Gg: AYBFou0o+vK0MiJ3e/+u92UgyGlR1VhNc8XIkOdgvdTsS9PM/UmWzUsIkAzMgxPApQD
 BovwZB+juIMbijiNfscSHZBJv7/9XlS7cVr5EsWgYM+Kx4H6+j1zTpM7js11J3v/jlVttJ2xooo
 NCo3SKn6xyTZ30ec0nVO/S2iUXi/9jpvaWADAI7SV5kIE4whWsQF/aplqjY64nzT4k2/xEgSoUL
 Tqe2YPE6itJxUth2NHFBn++aRHyAIb/3Z0rDoUGhyD2/ef2DiOAP8sKLGXUqiudTevHsDnc8JyE
 U8LF5BkRo7tRVLgP2csyyE75+0igQvhs4uTZSLH/0JzKIbNfMxnUfnjSr5dAEkPS/DFOuFvwGQ8
 Y4XzjD+o12aDJbzk3BAwiJIyhE3kDragZG08vGH2aYDA9P/kv136tNOCPv1Pxg7FVpvA34JI8di
 IUT5VsrPCrBiGVnTUeWwmgvxpkVGwj+QgldeXbETxkuFWz4crfFjNWRCxh/3urkwXTC0+EB8u8C
 JcnTW4NE1WLPK+EC4cf3eIcv617wEg5JLoFZaWuIettBgPH8bfyGdgOcuksI8lU0tL3Uq4kYDJG
 Ra14CqYyKxt8vM5TZAsY6mMkl8BJkkEmWFm3UsoDGkhJZ0dh3hJ0lVw0H2CgvapvQwTometjnzQ
 nMHZz8WbOMYdnTQyCjJG4fJTWyMmYKbkkn/XFQ9TjdWByh3c=
X-Received: by 2002:a17:90b:2b87:b0:3b0:dbc5:c56b with SMTP id
 98e67ed59e1d1-3b1b07e9026mr7927230a91.6.1794802180411; 
 Sun, 15 Nov 2026 20:09:40 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:39 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:51 -0800
Message-ID: <20261116040851.2849696-21-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2M-000000007dE-0qRF
Subject: [f2fs-dev] [PATCH v2 20/20] f2fs: enable subpage block size support
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

All paths now handle filesystem blocks smaller than PAGE_SIZE, so stop
rejecting a superblock whose log_blocksize is below PAGE_SHIFT.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ac024c089710..2f9ef2abfba8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4173,13 +4173,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
-	/* Subpage block size is enabled after all paths support it. */
-	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
-		f2fs_info(sbi, "Subpage block size (%u) is not supported yet",
-			  le32_to_cpu(raw_super->log_blocksize));
-		return -EOPNOTSUPP;
-	}
-
 	/* check log blocks per segment */
 	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
 		f2fs_info(sbi, "Invalid log blocks per segment (%u)",
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
