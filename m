Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DDDC54EBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB6j-0002Qd-Ac;
	Wed, 04 Jan 2023 21:15:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6h-0002Pt-9Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=; b=OGnuhGkuri2BSjeKjeCQc9gHxO
 6j1bj4xi9TdW1RMwmdpfQ9qkgyZF60CbK3V78kcJzxLQKM8YNbvKp9Ccpk+cwMUeVgQ+dgR1LLTu7
 76ItHfHTQ9qzCYCLbHv/Ou/lCMTknXRwpIhO4JfvFE43zYoj/Ydqhslm0WcVkb59FLsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=; b=AMjTUq1BapNZStJHcZ9qxhT3Vf
 KdSuWQ6K3veH2YbDUNqPpqcs+1YKBve7RShJhSmb43xEdq8A7pzh7lO6AioCI0pqIvB1hS49SdZVQ
 ykZwLNf05bx+ILzN8fD+rUtM/czjRmn0mWBWyB21JCpq2E2LpOvEOOuB4gzhdxnzva7c=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6g-000563-NO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:31 +0000
Received: by mail-pl1-f174.google.com with SMTP id jn22so37170814plb.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=;
 b=l0t6NL5SCvyD8kdyfFc7nOlzhreLq5VCcEZoAPCjS9SYlOOIdyy01o8enEBrI/r1kI
 ge7wlbNG0U5OHLin8Sv0DJ9D+P9p9F9nvhdVsVzqSo2MjhW1QMKBlTmQftWK0E3Sq3mX
 s5i3P5LahXYCAZDxiD7TON2xAC7xlyma9HMVO7+C60fEOzvSJBRZE+ygGDT49ocIptx1
 ZqodBy1UQufx3eUsdyctWHg9lneTCyK6t6QfTsYnGyQ1gnGKfPEGcEh9fBK7H9Fo86Cv
 0aWOKjYHhKUcF745lohZ9dh0iABWPhdJYkbVa6/m4X3OwsSxOaXcOBpLjiswo+OAnLFc
 jYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=;
 b=Qhy8lYaiXAZIWZhWgGGb4tEtp1VcycR5eCq0tVi1kDJdAwnnRXs572npX9LUscS8b9
 e3TMfr5alzETDcOiqYMMh2MRl9uYDQNzhTfRH7pe5pghH4sbK3f2t2bMsjIP53Kdt33G
 Mu1QC4+6biQiEgZa17C0JW61+jsCtDEQTRYGHLI7ViYpXQlQufIJM7SdNpWlxa12jfMh
 MYYwQTR/Z1llOuHHBMnRuSnE8sAOUAPyyz801Ip7W7w/eqbokFMHvv3q9de2Xsb9t587
 kHIbk8OQfJsWdmDTFPQmfQ6eatPB/WQ9Deo1QSkC0O1b87bM5Jrh36qYEiL6ZqD8Ij8M
 MNDg==
X-Gm-Message-State: AFqh2kpXqIXMynvQcVdD2gI2OZZwrmSQgOccpJgzxQ3mAlVuy2qBsngV
 p6XZl07hJDSjHrYde5KH+KM=
X-Google-Smtp-Source: AMrXdXtmjSnTHrGQEHw6VbNzkxfY/pt2X9Tas5/n9E/HJyc3xHf0BuAuSYZ6Gu+13LxzPXvTYPQi8g==
X-Received: by 2002:a17:90a:7341:b0:225:f7b3:aebf with SMTP id
 j1-20020a17090a734100b00225f7b3aebfmr34765688pjs.30.1672866924907; 
 Wed, 04 Jan 2023 13:15:24 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:15:24 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:45 -0800
Message-Id: <20230104211448.4804-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6g-000563-NO
Subject: [f2fs-dev] [PATCH v5 20/23] nilfs2: Convert
 nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
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
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). This change removes 1 call to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index b9d15c3df3cc..da6a19eede9a 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2141,7 +2141,7 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
 	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	pgoff_t index = 0;
 	int level, i;
@@ -2151,19 +2151,19 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	     level++)
 		INIT_LIST_HEAD(&lists[level]);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, btcache, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btcache, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh))
 					nilfs_btree_add_dirty_buffer(btree,
 								     lists, bh);
 			} while ((bh = bh->b_this_page) != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
