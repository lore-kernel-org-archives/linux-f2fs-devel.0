Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C26C53210
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 21:15:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDB6i-0003Tb-Vn;
	Wed, 04 Jan 2023 21:15:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1pDB6g-0003Sv-Kg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=; b=QqRtaxYm5jLLEevi8ihJIgWsXw
 SgFo7LDh74Kwxnt90BRWY8wW6oRwwZCnmhDIHXH7WuLazBwgFeQ65efc9VVcSISQmQd11uJi3TzAr
 aGpvZYrjV4IU9Q8+xE3mSEbQnN1r6GyvZHOx1BE/kwZIjwCF6QltWfYeJtAwj/Z2xSy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=; b=K3tiPS6gcMj5QbiPpI4Kpb+Eli
 sD/UbvrVjpBf+/nWhBogyRX0gy2mpXIp8sOo7WvYi28CmNvG76x8OwFxlhsuQyiqybAjEghmDnqI7
 JZ48vdTWjeoz5kr5X8us2jXNXoHRMNm5ZbhZwne88o2b4mrdFVQfcMGttVD4exSnnz8A=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pDB6f-0050ya-52 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 21:15:29 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 n65-20020a17090a2cc700b0021bc5ef7a14so35837118pjd.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Jan 2023 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=;
 b=JiIf52J13fF3RZdd/gu8czce51QuNDKyRmp/RhQBZpiZeU3XEs1WalfwDAIkQP3i1h
 7oaEZjWzR8v45uiToP37QSjLBQ6hFoKkzsu//TvxJBpZZTHSu/Ti+0DB14c/uViJpKft
 LemnBJAU1yNQKcrmO0+Bqi75NqwYHFoh6HrWlcKcA9N4lX0TdQaGXSiQJygzjTysgH/H
 Ppdlz/iLT+f5FltAthrg93ciA4z+S+CmoY6IExMFrN5abl65NskD8ykG3req494jeVOI
 SIJLZug6nx7VJLjV0ukQMkHOfmOMT4MrYPY4bGDi0laktjz8hyQhgyGhNDvAUwE+FMju
 93bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=;
 b=A8s7O6uAttrYKr9FLatslHtYdlsCDO9HcpEMn8kW8gzLP94dm86GdPDWD/6t2qFarb
 D2L8g/D4QdRxwFHk3e7NzOb6kHS0qU5JbFPr2JY8n9O4UrS/P1Xc9ktN03wTUTzUEuVC
 U6Hy1NuulC2+fWtT93R0dHVqV4aJcCdgdYrQvacC3EnmfCHL6fy/dYaXURroMP1bH57M
 gB+rB/VgXurV+9NpFIw98FzsMbMUKuWL+MFufUT8PjYA2gHLE4/YbBQTw1yJ+VqRauPX
 q67A+EwckLDeL9mj6Aipny48HiTJKaA0SyB/IeXNSbW6wr99fZ8YyRPm+5ZyB9NG/Jsi
 zG4g==
X-Gm-Message-State: AFqh2kpmaezZUPe1k/0kv5FPQTMxejfRRrrtw4ARkljGSwsd+TbejDt2
 UIDaAgvxdO0EPteGfdeL34o=
X-Google-Smtp-Source: AMrXdXs7s+m/7nsrgJ9l/mJQIpEV7Y/DeAKat3L22TbeUL9zUgX6QTynjS3828Iu+F7/uHuvxs7fOw==
X-Received: by 2002:a17:90b:794:b0:219:64ca:49a0 with SMTP id
 l20-20020a17090b079400b0021964ca49a0mr53526904pjz.22.1672866923492; 
 Wed, 04 Jan 2023 13:15:23 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
 by smtp.googlemail.com with ESMTPSA id
 i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 13:15:23 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  4 Jan 2023 13:14:44 -0800
Message-Id: <20230104211448.4804-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1pDB6f-0050ya-52
Subject: [f2fs-dev] [PATCH v5 19/23] nilfs2: Convert
 nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
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
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 8866af742a49..da56a9221277 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -737,20 +737,19 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	struct inode *btnc_inode = ii->i_assoc_inode;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
 	if (!btnc_inode)
 		return;
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
-
-	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btnc_inode->i_mapping, &index,
+				(pgoff_t)-1, PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh) &&
 						!buffer_async_write(bh)) {
@@ -761,7 +760,7 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 				bh = bh->b_this_page;
 			} while (bh != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
