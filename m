Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0369C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:07:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s1WL9-0004bq-E6;
	Mon, 29 Apr 2024 19:07:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ryncsn@gmail.com>) id 1s1WL8-0004bf-63
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Apr 2024 19:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Reply-To:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Content-Type
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=; b=fPoHBsV2VINprDyaLluUmBjPvV
 IA4Yd6Hxwn5ek4ugjWbcWQ9nRzkBhlbUEPzV06pNhXkuBEr0HvIfuG/cJ8Ren7ovIGeGji8EN1Sz7
 Wbix6JT37A0rdpDwudbCYaAq1J36jbSuFE7spDc2GeilWp6qdxt7Kx/z2T1MVGZNR/Fc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Reply-To:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=; b=Z0uzGz4gSHf4SpgEVzyuNvprd1
 VB8xcRUvl9xJCobAi6mAOxffiF40f26ZnteFYuo09Djy7YycF/rybYY0WRdh4J5SeU4lJqP+lo2AW
 lAXaZBVpObbCZ7jzwGI4QVLPg4q5P5w/5S5IvfVAvdTIuSun+Nv7OeDqbu2ukE/iFcjs=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1s1WL7-0001Xz-Ol for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Apr 2024 19:07:02 +0000
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-1e834159f40so38879785ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Apr 2024 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714417611; x=1715022411; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
 b=Th/8zl22hjiIk4/KYhZpLCWXYwUCocfOKIObPPVK2t/I60mSWeNyEBFPtPPZaiu4A4
 gGMs2SLC8qAtCCen31CgD9whTRqOIDXzXLxtGpq5rl3sgRi4GS6ldsBtFTpX7iV2MDBv
 skDA3zwPCbSbahbTxUDfbbnCYpUlJBc4TIaZqfgiHT7Iqk634BCCxa95xIX4aAZvNU3U
 Wp8GZJsslDwKsZYc6TAKK7jgoMr/OoqlZq2IiRMSZQl/cpFDDe3UCNiqSxcPLS4LwWKw
 3BwPEkVr6tSHBS0PQuaizdcyy2WcKhZjZEP92NBTNq8vkGFdfaUqkNKuX+edrj4EI3c1
 uzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714417611; x=1715022411;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
 b=TPCcr4nOyJVcKUeNr72DVIqr5DA/qT/okZSlzIyT1Oj7Pv84gku0YXHTwm075SlSoc
 e9QKS6l69UNrG0tzFWXlzwj+fNFw5ylVtCV7+Eih/1qSGdS+EHtH4jKnksFRBRMnUQKK
 lcJvDgi6EI/nEsHy4mP/Z4eZ7j5gyd8aqkuLHq1kx3Kx///jKezKr0qRN9C+DK8ZZFbf
 s2xCy4J8cAKbTMzyj5qY6CZ0QpULmidWA2LmFeK82ur+sKRVBTzBpOMRP1++2kh5uiDf
 hjNK3sdoeLtd89dXjmH7U2tCgdQ58rjsmr4xMwZbAumSqCgGan33WxKJRmVMS1F//zj6
 cUpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsG6Rnpn5L/bM5k37XZJNaWrFwdW2K3JjwVqTQnf2bDCDIRF2PjG7ZGVKE4mPDn3CAlyu/E7vkNVLNA+Tujuj9HyVCWwXaQx1t+xO3fLpQutuak/c+iQ==
X-Gm-Message-State: AOJu0YydpaZRQBPugNalX0TeFbE+f+SkMMHrP0hibyrfxQmVBkEu5O4B
 BhAuTBaZ7mJ4WeXqTiRIfXisNffO2iCn6LE8OP9HoqaPdvNT3JWO
X-Google-Smtp-Source: AGHT+IEWWyXjXq5qxQK4Wj2h+dXwYC3HBxH2tY9g+B+mmj2ONuL2mZBA9D6pxjlnJqOR4++MfTCr9w==
X-Received: by 2002:a17:903:1249:b0:1e4:b1eb:7dee with SMTP id
 u9-20020a170903124900b001e4b1eb7deemr13466540plh.47.1714417611389; 
 Mon, 29 Apr 2024 12:06:51 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.06.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 12:06:51 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Date: Tue, 30 Apr 2024 03:04:49 +0800
Message-ID: <20240429190500.30979-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1s1WL7-0001Xz-Ol
Subject: [f2fs-dev] [PATCH v3 01/12] f2fs: drop usage of page_index
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
Reply-To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Chris Li <chrisl@kernel.org>, Neil Brown <neilb@suse.de>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Yosry Ahmed <yosryahmed@google.com>,
 Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, "Huang,
 Ying" <ying.huang@intel.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

[ This commit will not be needed once f2fs converted
  f2fs_mpage_readpages() to use folio]

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 961e6ff77c72..c0e1459702e6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2057,7 +2057,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t block_nr;
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)page->index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
-- 
2.44.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
