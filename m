Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E5606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hoQcPyUX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pv+o9ExS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lDNl6QWU;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/bENH9G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=mUZw+BAOkHWtp7/2E17DAAfdU1sXXBA9TizqRCNmWMI=; b=hoQcPyUXi3+0v1qAHENOqP3wFq
	eLEdY7HjOfXepa5kBoG2ZaSNwXS7DcF6phkcFRCFyTyMbmnIray+lnKh2VVNED7lbAvWwP9ZZwBDo
	YD2908VEGhWYexusf970UzYu391HWXzfGXSNsdvNNEU+WFpELMAWoRCXIsFRyZKMdebQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsO3-000000006wL-1fsJ;
	Thu, 22 Oct 2026 12:59:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsNQ-000000006lM-40at
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jZNTFDjvlc2OSdmDcua0wTZOBCzRjuz7YZGbODInL38=; b=Pv+o9ExS56lKAWUIghU4a1hLMM
 +nHIOtIuGsQhGYt/EaqWO/TpM4GWItElvLIb90yw/1d1R3XsnB1RrQzuASnLEexCWLzxxxZol1oGZ
 MCjM5isv0OMAdjdsihVy+yKt/+J6xBPGqUxpbyLd2KyjORe7OVSI9hFt3rwD6riTnxp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jZNTFDjvlc2OSdmDcua0wTZOBCzRjuz7YZGbODInL38=; b=lDNl6QWUpMXul5zZz75dpsm1vm
 cpaV9QqtZ8WSKspJsGg3K/x636gRKYoS6N2YBTFOBaRRcsYNYqxrKjtqA/n/4/oDq7LIGVPombccY
 H9F2Ggb7Q2z4yl46GsJ5Guut+Q+44XmS/R6jbMHSek4PS0Rm4vAgnpyuJszOXY3Lq32M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsNP-000000001SP-2PZ0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:58:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62D8C60A56
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252961F000C3;
 Thu, 22 Oct 2026 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673909;
 bh=jZNTFDjvlc2OSdmDcua0wTZOBCzRjuz7YZGbODInL38=;
 h=From:To:Cc:Subject:Date;
 b=h/bENH9GFm9FOHVlIydlO1kTVa/4DxCpbz4uyKCed+52CcwccXV5SdAnxucl9bSQ9
 cEemWV5IYwHPD+alsmzV6qCwljb2FyeLINidynzLIShcMERyvdVqXBY9SWbj4JPpIN
 TEhlY14Q/9YdvJlPcDdvfOpxD2ObuQFvW59C5mdWVVrdyTka5zjRsFzdMHuHx0+t3u
 fTnUAejYY+HDDEnu2rFRe+zmXLL93gdKh++BU5yo6tci62qt/U0rSTKeyjzV6G8Q8n
 d67H3aDYRsUDyWoPrU0uAIW4kIom6VW2CZcjGnRTW1xBLj59wY0iTA6JXnnwH8mFln
 c+jWhKg5uAYDQ==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:58:18 +0000
Message-ID: <20261022125820.2210579-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsNP-000000001SP-2PZ0
Subject: [f2fs-dev] [PATCH 1/3] f2fs: fix to account entry_cnt for all write
 bios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

Commit f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
tracks the number of entries queued to a write bio via entry_cnt, so
that f2fs_write_end_io() can offload the completion of a write bio with
too many entries to sbi->wq if it is called in atomic context.

However, entry_cnt is only increased in f2fs_submit_page_write() and
f2fs_submit_cache_write(), it misses below write paths:
- f2fs_submit_page_bio(): single folio write bio.
- add_bio_entry(): the first folio of an IPU write bio.
- add_ipu_page(): folios merged into an IPU write bio.

So entry_cnt of these bios is less than the actual number of folios,
and a merged IPU write bio, which may contain up to BIO_MAX_VECS folios,
will never be offloaded to sbi->wq, then it may be completed in atomic
context with high latency. Let's fix to account entry_cnt in all above
paths.

Cc: stable@kernel.org
Fixes: f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a8d39add5cbe..16ab2c693aa9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -870,6 +870,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio_folio->index, fio, GFP_NOIO);
 	bio_add_folio_nofail(bio, data_folio, folio_size(data_folio), 0);
 
+	if (!is_read_io(fio->op))
+		F2FS_BIO(bio)->entry_cnt++;
+
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
 
@@ -940,6 +943,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	bio_get(bio);
 
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
+	F2FS_BIO(bio)->entry_cnt++;
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
@@ -980,6 +984,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_folio->index, fio) &&
 			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
+				F2FS_BIO(*bio)->entry_cnt++;
 				ret = 0;
 				break;
 			}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
