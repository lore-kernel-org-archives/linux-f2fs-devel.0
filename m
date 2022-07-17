Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C910CCA47B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 05:32:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCwtT-0000pP-8f; Sun, 17 Jul 2022 05:32:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1oCwtR-0000pJ-FO
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 05:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ASDDzrl6KtIPnNeRWJt4W/N6mblU6X0/R3mt1arHEo=; b=fbGXd5QibYXcxSsWgGObIQQsjw
 H2Vm4zcZRqQEC2hnjZ0BtB1rBtGVLm/YWyiXxPo5IHtX+eiNkhvEbM6cBpASR7Rpd1eHQNE9h3li/
 cTkcaGT0yp0FecAl4Bym9GXUJjwG62bLu4qJ30aZOfrPSvuuLKablC1YPym/H1ZjZcXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1ASDDzrl6KtIPnNeRWJt4W/N6mblU6X0/R3mt1arHEo=; b=YEh1Ss9kzPP3B9UpBq8wlz9ubz
 MoFZ4mHjFTiYKcrYHluFKHJygh3tBX9+j+1PIZ4lbxykzdDLFKfhGK2XQw6xonI4LCp+r9TBSrHC2
 5kXSKWG8G9iZYrkW3O4BzpNMEjYlDu/uHctIQvtB+XVi8RTo5Qj/R0bHXSXJMktQ4oSc=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1oCwtQ-001ZvO-LK
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 05:32:38 +0000
Received: by mail-pl1-f172.google.com with SMTP id x21so6438771plb.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 16 Jul 2022 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1ASDDzrl6KtIPnNeRWJt4W/N6mblU6X0/R3mt1arHEo=;
 b=l4kMXdLDFp1rGhcKX7jdvhY7DSjZn4oORwlTJlptd1pGt2xE8bT86T+G3HaP0+KYXW
 a4IXJeZGF5XQ09JeMcVUJRFT0ykg+uuU0IIqZmz9AwjFrwrFkFTQkOPfI0ZaK+j4WNFl
 t6mQscqgrz+g+kZ27Xo/duLkDmby2XacmMHKTLBNfnjyjzUFKJB4eWpgkdwFJq5uwFI5
 IMT6MI03DIsBR9NnwSeC1iXat7LIpEvydsHeai4OkMYxXtlfc26Do/AUEC67HDyfLulK
 ov9t8ALAvRegCnxYyYEJ36LNvzVLMq4r9GkxjWSUi1hGqy7xEu329LGg7l+siytSThcJ
 hKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ASDDzrl6KtIPnNeRWJt4W/N6mblU6X0/R3mt1arHEo=;
 b=ubJD6DUkgGumPt8EfD1bPrs6PmBs/O9FplBUL9hieH2dBvVgrvxWKWrjkNduMLqiF3
 nxOUpCuSsP3kQ3ZsdLHxpEKq8WYDuC1Ks4lKpvVRdf/eBDn2WmztM0yqJMw75Y3ApfZz
 WJGdp0weZkENj+5Uoy1sbsLGyzwwZwIpaleR7uCXUKhG6xY2pkWdMAX7aO0dzjFQrkeL
 c6tSR7uZJa6t2J0yh2fKjFcfzfGAH3NOTfqtapusP9Ce2FAIYAhT+XJr6F1NRSHnvP+Y
 k13oKap2oCSnu6Gfhx7owpiON75vG0PaFAMLhY+O7FwZNMVFzhTeSCqOQ1z4ZMlnBqhP
 gDqw==
X-Gm-Message-State: AJIora9m4iTJTXkd8lDTugiwen7WSlqM7ZDR0M3Ntgq1jbBNVpthTWtZ
 M5YvUxT1BRlJRB60xpUJul4=
X-Google-Smtp-Source: AGRyM1uEbRqBc+SF4pXE4v1c9g4xYfEIq2TKDV73W4GcmatrsHfBAgmPudRRMKl6s9CGY7jloBblTw==
X-Received: by 2002:a17:902:d488:b0:16c:59ce:5000 with SMTP id
 c8-20020a170902d48800b0016c59ce5000mr21954265plg.134.1658035951116; 
 Sat, 16 Jul 2022 22:32:31 -0700 (PDT)
Received: from localhost.localdomain ([205.198.104.202])
 by smtp.googlemail.com with ESMTPSA id
 n8-20020a170902968800b0015e8d4eb1d3sm6488814plp.29.2022.07.16.22.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Jul 2022 22:32:30 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 17 Jul 2022 13:32:05 +0800
Message-Id: <20220717053207.192372-2-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220717053207.192372-1-fengnanchang@gmail.com>
References: <20220717053207.192372-1-fengnanchang@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oCwtQ-001ZvO-LK
Subject: [f2fs-dev] [PATCH v3 1/3] f2fs: intorduce
 f2fs_all_cluster_page_ready
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Fengnan Chang <changfengnan@vivo.com>

When write total cluster, all pages is uptodate, there is no need to call
f2fs_prepare_compress_overwrite, intorduce f2fs_all_cluster_page_ready
to avoid this.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/compress.c | 17 +++++++++++++----
 fs/f2fs/data.c     |  8 ++++++--
 fs/f2fs/f2fs.h     |  4 ++--
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 24824cd96f36..28619d45b5c9 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -871,20 +871,29 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
 	return is_page_in_cluster(cc, index);
 }
 
-bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
-				int index, int nr_pages)
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
+				int index, int nr_pages, bool uptodate)
 {
 	unsigned long pgidx;
-	int i;
+	int i = uptodate ? 0 : 1;
+
+	/*
+	 * when uptodate set to true, try to check all pages in cluster is
+	 * uptodate or not.
+	 */
+	if (uptodate && (pgidx % cc->cluster_size))
+		return false;
 
 	if (nr_pages - index < cc->cluster_size)
 		return false;
 
 	pgidx = pvec->pages[index]->index;
 
-	for (i = 1; i < cc->cluster_size; i++) {
+	for (; i < cc->cluster_size; i++) {
 		if (pvec->pages[index + i]->index != pgidx + i)
 			return false;
+		if (uptodate && !PageUptodate(pvec->pages[index + i]))
+			return false;
 	}
 
 	return true;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf979737..022d0a8715c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2996,6 +2996,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				if (!f2fs_cluster_is_empty(&cc))
 					goto lock_page;
 
+				if (f2fs_all_cluster_page_ready(&cc,
+					&pvec, i, nr_pages, true))
+					goto lock_page;
+
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
 							page->index, &fsdata);
@@ -3006,8 +3010,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
 						fsdata, page->index, 1) ||
-					 !f2fs_all_cluster_page_loaded(&cc,
-						&pvec, i, nr_pages))) {
+					 !f2fs_all_cluster_page_ready(&cc,
+						&pvec, i, nr_pages, false))) {
 					retry = 1;
 					break;
 				}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..df07c15a5202 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4163,8 +4163,8 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 							block_t blkaddr);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
-bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
-				int index, int nr_pages);
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
+				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
