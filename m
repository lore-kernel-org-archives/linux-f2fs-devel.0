Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF0C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mrr/VCf4U5y6cmMfs9FIO96elm+uxUPc0/f1UvlGD5M=; b=EnTuV3OITOUgtcBtSHRgDBjlTy
	5TNQfD5TKh6MfT7c/CJLWMJvYScF7QBW3mjS/cTTisXPLbnPGDdyEJ2cHVI8nWtNdijOgufeuw2S/
	vVtgMWBsQPxd/AvOe7S2gWpS3TiIZ/jW5CLSEM4AarnIKO94OnQwslAdU+s2Ij/B2+dA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjEiP-0004Vm-7r;
	Mon, 13 Jul 2026 11:20:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhaoyang.huang@unisoc.com>) id 1wjEiN-0004VU-78
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 11:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OTbG9KRJKQUT1m+1aLItfEcZaIClgYQ6zYydEWMP5KY=; b=i+lvHH+oFoaYiVPRSvpR1S8dfL
 /VwbOwwIfo0FtLyEQlp2t1TB66Yo90dapZtcAPaMtuGtKaJGyFw76nva2dEkLB289hH9b4En/MgY4
 8r7tJSU7ZPxaG8/tKj4mliBbKlWyh6O6cTGslIZzBkcyJTT6AJnJRZUeoenKwu62gZ4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OTbG9KRJKQUT1m+1aLItfEcZaIClgYQ6zYydEWMP5KY=; b=V
 XfyO5qRCe2dU4O3DFTwv6U/bVenm27WWU87EEyb2fKr0v2o9kLf7q5YBsbBwAiIAgF0JCV0lZYTM8
 +FNtYKf/j0K6TCBJ3x7llXI02W2TaMyB5F36isg/D0iFkq0OCemNjP3EF4vtPdiEutX5p2bR6iajz
 ql1pR3Df7gnY2h8Y=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjEiJ-00072k-4K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 11:20:47 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTPS id 66DBJqWt076499
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 13 Jul 2026 19:19:53 +0800 (+08)
 (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gzKhW4MCSz2PVB6x;
 Mon, 13 Jul 2026 19:19:23 +0800 (CST)
Received: from bj03382pcu03.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 13 Jul 2026 19:19:51 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Date: Mon, 13 Jul 2026 19:19:44 +0800
Message-ID: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 66DBJqWt076499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
 s=default; t=1783941607;
 bh=OTbG9KRJKQUT1m+1aLItfEcZaIClgYQ6zYydEWMP5KY=;
 h=From:To:Subject:Date;
 b=hlGi9m2QOCE4H+1cFFjooWasyI7EJwZWq6ONg37Ij+CSJKaExyaar+83Bnh6xGFvo
 MCMknlveGputAI/kcyH7vCI8FVo9Ws/vsMOkt7c2FSeoF5KZT6vX7KC3xJF1LMOqnq
 YyTKUgVNrKVw+V32dE9UQms8ZaWJXFTboCEHPEiqidlFUvBAvfQY1j48gLS0XQG08n
 djsllT4Szq9flkf/atWODBwr8CMF/B7uzUeuZw38k9RN7lZapU5/zAT2ptj3iK2LGY
 n9XfjVBJaVjVDHUrE04eCd2QCoINl9LqS0YN+Br9+Z/Ghd0xhI4r9HhQ5+61/T62fy
 iAGDct3tpnoBA==
X-Headers-End: 1wjEiJ-00072k-4K
Subject: [f2fs-dev] [PATCH] f2fs: fix folio_nr_pages() race after put in
 large folio invalidate
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
From: "zhaoyang.huang via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Our v6.18 based Android system is continuely suffering livelock and bad
page stat as shown in[1] which related to broken xarray slot status. By
investigating big folio operations within f2fs, we find below races and
fix it by get the nr_pages before drop the refcount and folio_lock.

f2fs_get_read_data_folio() calls f2fs_folio_put() before
folio_nr_pages() when invalidating a large folio from the page cache.
That unlocks the folio and drops the caller reference, leaving a window
where a concurrent truncate or folio split can shrink the compound folio
or free it before the invalidate range is computed. An undersized range
then leaves split sub-folios in mapping->i_pages, which can later
interact badly with truncate and reclaim (stale xarray entries and bad
page state when folio->mapping no longer matches the mapping being
truncated).

[1]
PID: 2594     TASK: ffffff8169b81580  CPU: 7    COMMAND: "Thread-3"
 #0 [ffffffc08ef2b8a0] xas_load at ffffffe52d1f42a4
 #1 [ffffffc08ef2b900] find_get_entries at ffffffe52c185798
 #2 [ffffffc08ef2bb60] truncate_inode_pages_range at ffffffe52c19e83c
 #3 [ffffffc08ef2bbc0] truncate_inode_pages_final at ffffffe52c19ec2c
 #4 [ffffffc08ef2bc20] f2fs_evict_inode at ffffffe52c4c8400
 #5 [ffffffc08ef2bcc0] evict at ffffffe52c2de9f4
 #6 [ffffffc08ef2bd00] iput at ffffffe52c2db1b4
 #7 [ffffffc08ef2bd30] dentry_unlink_inode at ffffffe52c2d7204
 #8 [ffffffc08ef2bd50] __dentry_kill at ffffffe52c2d3dcc
 #9 [ffffffc08ef2bd80] dput at ffffffe52c2d3c3c
 #10 [ffffffc08ef2bda0] __fput at ffffffe52c2b0a7c
 #11 [ffffffc08ef2bde0] ____fput at ffffffe52c2b1034
 #12 [ffffffc08ef2bdf0] task_work_run at ffffffe52beea200
 #13 [ffffffc08ef2be20] exit_to_user_mode_loop at ffffffe52bfbc17c
 #14 [ffffffc08ef2be80] el0_svc at ffffffe52d1f8e54
 #15 [ffffffc08ef2beb0] el0t_64_sync_handler at ffffffe52d1f8d10

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d4f1e75dee3..8a26f2d93c17 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1281,10 +1281,11 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 
 	if (folio_test_large(folio)) {
 		pgoff_t folio_index = mapping_align_index(mapping, index);
+		unsigned long nr_pages = folio_nr_pages(folio);
 
 		f2fs_folio_put(folio, true);
 		invalidate_inode_pages2_range(mapping, folio_index,
-				folio_index + folio_nr_pages(folio) - 1);
+				folio_index + nr_pages - 1);
 		f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 		goto retry;
 	}
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
