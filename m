Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEBECC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nAiB0pQtbzv3PCM4wBQTnm8x+fwelogDqUeGCfSeAAo=; b=VZzsWSZzuVmlHJEtgzXnZqBPVM
	xkES2Y4TGQBcMhPZD7eEejaGyceK/EN6FA9IoU5FLH6rWlU76qjwPxWFCjLwAJMEcZ2CSR3UDMdOo
	Ks0VdMsVNhOJ64wfCTFlvwTlmqMRxGkt/pm/+B/v1AuD0KD5cwBHI4dH7UFP44Am+i8E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8f-0007ot-JS;
	Tue, 13 Oct 2026 11:57:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8e-0007om-6V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B4BPi7mc5/eRlUG4xDFRpSLX13PD0rb68uUkEag+4iI=; b=AeD8QBMbdAMyrNpFLXu2RrZWz4
 rdWDWFrdWWvxVrXOhK7bowd2rCfUJVmqYvVtvtvNDCmWngI/GPrfxgSX0cJoZO7sepgtQAKh5enMO
 XDYZabQFoY1E73u+evboTXA2mjRyzbmHtE6fUWZewBDtsl53kmA61jQoonGgE+iFiQWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B4BPi7mc5/eRlUG4xDFRpSLX13PD0rb68uUkEag+4iI=; b=NP12sX2360UeIPeJUUfew4rXrH
 +9pZs2c4XEhaU6t/FTjDGr2ARrJDvSmagVOeFAsk36V3N+dvpOAVaIDbKC4kpVDdIyp0zH+/ukEFa
 9hJIlsBJ2MXjmV0h2rFffrGsMCJCs3JO8gacRCXZpEM9DyI7Ytxv9mHfdNTiltUQxQM4=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8Z-0005SO-Ad for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:45 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab86ae9b80so1105252a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892658; x=1792497458; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4BPi7mc5/eRlUG4xDFRpSLX13PD0rb68uUkEag+4iI=;
 b=Jfzb7OAUHq5QC3+V9QIAaGv/ZtqBQuyifdqEqjG6jGu6HxqhfHX2Vn8xDHKRlU5z0r
 2I9PfYMjGQ/FdDaBDJ3Ipodcze531gkCf90hsBDDiUT8fXWt2Iq5lXpxcsGd3o905RwV
 HL1lzCdh+qGTt2QUpiH8yzJxVhL7vPgjprvY5mLh1QMBOjm7VOIMtaXxCc7EYd806gOH
 E5Qkl/4TAj01Re17CQXAOWCIn+0bAh4TOM0PDtvu6FnZtEo1Ma4kgFK12uTcyR0GWmvS
 7dkXi0HtRGqrDCSIHGe5Yo3MuxjZLIGeVqnTAuV6fpFIxO6E/u4ZQiaHrou6mwIM4Cv4
 Ww1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892658; x=1792497458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4BPi7mc5/eRlUG4xDFRpSLX13PD0rb68uUkEag+4iI=;
 b=Umn0mVg9Z2UdbpZmumOYiq+EtgIdHvuN9WvryIkTUPctSrhZH0vArwlzb214GQd0/+
 +lLioLaS6O/zI4EK9a6SSYZ25Wk1oO00JTgy1ad6rBcQqUb9jqx+71/dVyEKNYOoATnQ
 tT17A49uvJ72nmxzuZt0OgAdeiqNU9HcZb5B6W8oSCU04QG7uEm+7nX6GL2CRQC56gI8
 dtxx4XWtHortEZa+BiBU9x4fc5wSgobSVVGuEMjMslgKeDGC/JT7biPqhh8YNgRYMgBV
 5dHlrSNIwWDNZtLiX53GtlZ13kOKcsmfCW1Oh92ZJyz5UD8hnbmPkxIUpJFejueH2qxX
 6xQA==
X-Gm-Message-State: AFq9FYL7M3NwuiWgszDsg7nj8UHgKwo7MPMZrfOdZkp5rfV+JtKlt2B/
 CvbGpWBTJ/xB5aNevm+WudwdUtAO8R9xZFndAwywgZ/UASk5Pi1oz3clQaB9Gcpp9Oc=
X-Gm-Gg: AYBFou2samFchT9APvtfRSk/f7vv2o/KK1OjFtY9OyByEfB76ERqu3rUZTrN/bZgwY8
 pk8TD4scZGBt+gjedin2cONlpSEEER9U9u+xCB8MFQQBgTHRhAgcxJSs5CNtqUNsM4i0IKsisxQ
 eRO83XCSIQgZ2GUBJhn9nBD3gyhIxgey97CPDgFMeiMstZ+A6eUetbXVyb2/DTiDKAsUNrVPBgK
 vGVhavJaRiER9Wlz1bovXIf/RoF/+ealXUDg84/0OIebjFj80R7ksIOKSVAHTbwF7YLQfoTK2Wm
 Q1YLLLZzYgZn7lIKOXiU/4bjef2nne8KMQvcuL6Fx4jdFGy4f8mMFPpU2OEypzQMiCu70T+OSYO
 vzgV49yjn723A/vBBMvACjpb6O4rPzErA3tCOIOocpuyoKU94Gq+n7jvIVKiqZc6keVIMoc+lF7
 ft8GbsQzrYGbzmUx7soNumLs1VAhHwu8OcUqAJTKKmu/O+QIQfBMGiePY4L5oTiEtOs7JGvmTw0
 TgrovpbCuVqGseCJZiPQeC8wiA3D2Y0J+sf
X-Received: by 2002:a17:90a:d006:b0:3a8:6a04:80ef with SMTP id
 98e67ed59e1d1-3ab3a2901c2mr8466894a91.6.1791892657586; 
 Tue, 13 Oct 2026 04:57:37 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:35 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:17 +0800
Message-ID: <20261013115621.968742-15-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8Z-0005SO-Ad
Subject: [f2fs-dev] [PATCH v4 14/18] f2fs: wait for folio writeback before
 ffs_detach_free
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, kernel test robot <yi1.lai@intel.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

truncate_inode_pages_range() can invalidate a large folio that is still
under writeback, which can result in the following use-after-free:

 CPU0 (writeback)             CPU1 (truncate)
 ----                         ----
f2fs_write_cache_folios()
folio_start_writeback(folio)
/* submit bios */

retry_out:
folio_unlock(folio)
/* all bios submitted; folio lock released */

                              truncate_inode_pages_range()
                              find_lock_entries() /* locks the folio */
                              truncate_cleanup_folio(folio)
                              folio_invalidate(folio, 0, folio_size(folio))
                              -> f2fs_invalidate_folio(folio, 0,
                                                        folio_size(folio))

f2fs_write_end_bio(bio)
ffs = folio->private          ffs_detach_free(folio)
                              folio_detach_private(folio)
                              kfree(ffs)
atomic_sub_and_test(nr_pages,
    &ffs->write_pages_pending) <-- use-after-free

Wait for folio writeback in invalidate_folio, then we can free the
folio state without any other remaining user.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 61fe4a0c5..433d8f2b0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5427,6 +5427,14 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	}
 
 	if (f2fs_folio_has_ffs(folio)) {
+		/*
+		 * The folio may still be under writeback with bios in
+		 * completion that need to access f2fs_folio_state.  Wait
+		 * for the writeback to complete before freeing the state,
+		 * otherwise it will result in use-after-free.
+		 */
+		folio_wait_writeback(folio);
+
 		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 							folio_size(folio));
 	} else if (folio_test_dirty(folio)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
