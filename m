Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2355C6FA8D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo7l-0002o9-I8;
	Mon, 12 Sep 2022 18:25:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo7k-0002nn-7q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=; b=WNozUAnnk3vCFTTiPdohZffxrF
 r0mCVarURdDXX3wWGhV4BMgLdCGOXrs6ClxorJ0I6A3cwjePcCKbsJw+75SAjh7ReLy1ZjJhUUCxn
 iWTwYTY4G8tpBbdt8UfsTmnnXrRTeJ8b6AsBJXw5BBsDbIW8QLDPoNFoNaOawccr6SG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=; b=bbva0pvo08qE8gJNqc60mwnF74
 xvJlM+GRmg8nObraNvOLId694oUtUVMFpS8XqbVe99ABlMXUxmIc1ZkZE3W2LxM8V32xj5W0ceFIB
 UTDNkd3Jr5JwMkD131Us//0oF4c3ND9BWp1IB3V1WMlfS+p47m7EDz4Kk9ZZqLlMrdZ0=;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7t-0065RR-G3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:48 +0000
Received: by mail-pf1-f175.google.com with SMTP id u132so9429251pfc.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=;
 b=kUSUqB8dlabq9sW6UND7hIVWrf55QnN41yW1Ws/gSxB38+4EodjnI9LsYaQN1pMaEt
 vcUQu+3f4pKT6w51/iF50tVvuObtbeMnKiwQt2oaCHK0gcXc/f2dB9h7DKEPuXJ7HWdH
 ZpLw2vnH5B7/bJKVQmKAt6vtNrGedmqEMuaUbzJZJfle4i//kAsUvgKl5LdIzfZtaNMY
 5bytt+NGi9rmXEbPiSV9YhrOUqEtjhXJLdcRdwYRyjRlbha9Ca93KomE9khZSI37XP4C
 sblgMtHoYQcnK1+RtGWvytNWIig/lb0LSKVXD+DlGvOgL2nsC+H3kq98z+0KLkWxnnHN
 pyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=;
 b=4L9WvHZsUu1bf8PnQwE8sNzJQuHM7Iywm3uHiSy1WXMmREHUxzgCZ8tijgg2pf0cmr
 j3Z7a709eqRjCoEEckpOvOYdfkmwzLcBxPEVeu/WI0IziwjZo7ICKtTMJRt2B62F0HA4
 vE81oQG4kcwdlAsuCFG8D2HqEy63gjaIBy0WdgTKzo4ghJ19wU4qpFDU9A8k5/yhQVQw
 FSwXDy2z2IcgRwtQwE7ptOCAAw9KyUPbn6QWbDk7H6W4gixOgXiSEpyBrnm+SP12aXlE
 S4X0DeXhf69rCdudI4lzuM2NleL20WBhSk8AzWSCzYYcmbpGRf6PDuSb7oxFn/co/fY6
 x7sg==
X-Gm-Message-State: ACgBeo0cTvFbhx+Ug1KNGegxMYCtX86kCHl9uPlZoJofvjfce347gQmV
 15Kyn+40MYmJC0hbUAHojm0=
X-Google-Smtp-Source: AA6agR4xhmDo2NN925j0731w9UHbCazwEGTp4E0/3zUMlL+kHDi2lzVAs9T0G0CKuZY5yreG8GKchg==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id
 h1-20020a056a00218100b0051b560bdd30mr29359093pfi.44.1663007139855; 
 Mon, 12 Sep 2022 11:25:39 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:39 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:12 -0700
Message-Id: <20220912182224.514561-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7t-0065RR-G3
Subject: [f2fs-dev] [PATCH v2 11/23] f2fs: Convert f2fs_fsync_node_pages()
 to use filemap_get_folios_tag()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Does NOT support large
folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e06a0c478b39..a3c5eedfcf64 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1726,12 +1726,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			unsigned int *seq_id)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
-	int nr_pages;
+	int nr_folios;
 	int nwritten = 0;
 
 	if (atomic) {
@@ -1740,20 +1740,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			return PTR_ERR_OR_ZERO(last_page);
 	}
 retry:
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				ret = -EIO;
 				goto out;
 			}
@@ -1819,7 +1820,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (ret || marked)
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
