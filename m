Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7273CC98328
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pdT4P9TBqnjCEZ/wNNn/g9XOv0gl52N+FKZIB1ZHYB0=; b=O3DYmL3UTPQI6/Koa+IIctRXOP
	eIgjyOGp6Y8d5IWALYproXJp8DHIY/0hsPuLoWaa9tgvm+IkRpzMQF3uhxjlJX040CB7hRM7yrJvt
	kf32xjkuSE1jMCHDF2wgRoV4jmhLD+kb0EmX7jOgArU0h+7avIfMb8cdUxkjjYc5qXYk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAP03-0006Nw-Mp;
	Sat, 26 Sep 2026 09:47:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xAOzm-0006Nf-UZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 09:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BkkBSW8zyrhYaiSfn9iaShOaguO3DdlMUvXnosyb8cc=; b=C1VUUboKL5AMs5psKVQ1GJCEWD
 0kl++wKXNVLMuRAlgmhj+L0fLziO3VQSCTKuS2mGINolwq4UqpMLO+dNk53OIguOrOYAEh8l+xvs4
 YnmiwyCPGde1DVVEIfO/SRhakRlRCW+dRgUY0zn8otnGjQvNl287+S6xBNUjhH6duRrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BkkBSW8zyrhYaiSfn9iaShOaguO3DdlMUvXnosyb8cc=; b=f
 ihlgGMFFQuqrHavr1O7CwNZc5bP+4+kXc8vhE/cAiq6Gko2gIt40EdaeB55QXIWuBh2lRLak6PMvT
 dwYqBlaNZ6j7TNXrlcoyrrNezfDM6xVEiXlOENB/YyLnD7GJeHOo8vPZURKiTpzQUe0u10Rs94TqE
 tAaMedeO7UutfkAs=;
Received: from mail-pj2-f41.google.com ([74.125.227.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAOzn-00080s-AI for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 09:47:03 +0000
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a0bd71827eso804579a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790416017; x=1791020817; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BkkBSW8zyrhYaiSfn9iaShOaguO3DdlMUvXnosyb8cc=;
 b=hbmInpGEBzg8xUEp3bXdKgMZsGJgCGaCZ7DPbraEdUONrXfPqUNAK50JiIQ+SC5zhQ
 q0Gh87RuZfQHHKWr4oLJotopMWWRr3tLOz+xRwVYMVBt/aZ4if3THtX9DT8HpPm7JMpT
 yD6PCjqIjxZX7hJVSa2G7tWvpyoqaFBMNxIxu+wRUj+wDYbuJBungOy9ncwYwuTLZJby
 XnKKrA5GWtJ6xNc09SxIY1oCXfJfrfaXSmM8U88ct7EtgzZwrPv3Yd9NVeQUfq/FqNYq
 xmhwaELf99AjmyxKt0syXYJYRTm7B4SSMVEYK2YGP9TwiB5Zfq2t3tdgn1dmcrKOaSsC
 M6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790416017; x=1791020817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BkkBSW8zyrhYaiSfn9iaShOaguO3DdlMUvXnosyb8cc=;
 b=gNDHdNTrtAcrbQJEd/5h4HW7n84r4CwtJ+qBmwCX8T2n1vdbpf4NWNNUzCS284J7Cg
 NVfCS30Nn907yCABuwPyZgSgUkHr2pRhMe56G7f97j00NcZGq+7Veiodm9j0oCK1V1F8
 bzWGAXTVFBq20reei4G1pJE5tGIf07gldmsJxIjyyL7X0kmTphOKwJSIxcT3QhHm6X5N
 k1GlAXjjgO2iPeCskOq2kDt1W39l48CPL4Gzr4068lpji1Jj5Rlsg9mhn4qTCEbsljiF
 JR1017SL8qCTIvauzWVNuBy7vevLt4DnTHC/uBnXoBRYhDr0XK3FbNanvnjqyK31JrBc
 QKWA==
X-Gm-Message-State: AFq9FYLJ/dQXuOQTOABuaoOt/6/mMcPazaalhirqy+I62gVC80++ytdv
 zaTQd88xrlXHH+qjxttkVruF93A6xzaVHq+6hg7p+yAmUrZ7dTxp3zHa
X-Gm-Gg: AYBFou2ZNm5wSDeieKoqd7QEeEFOWw+ycfGUvMvmIo1ttS/mmdhEj+TGwiOxb139Tsq
 ZaEfIGWG25y6rKOLMA4g3gz8ETY05g0lMYvRJqo33wvnbf1eJprCVOPE172pWS9FrZE67jmr6dD
 cDw1gtjbm/XXXKz1E+pMnyLtDJNnIGExTLLM7TNM3h5T1fdLiyW1SGopVvdsv11Ry7I24kOFu3s
 sZb9ECkNIg2Ix83C2WFgzFYuopYjszM1pSKvinkzKVYIZGNl2Xw+qNLRDiMYmGvjh6egeMjB94W
 QZoywi4g3mV6+hxH4DMOpe3P0KJB8elGAADLMdxGsxh1pettUJWYEUOU9hVYdVaVIxzeXr1/9Qv
 Nlh6I3CVjzkQXrsHzpLuqi4sguKIwODTbeiNvkKKMFBSVweSmYp1D1vLDcMjSwZlYTNUFbSSJqY
 58jgMYBCg8qE7uWDKJZOlCUydusuAppWJnJ61fgKKmQao4X6dsDE/LOQON9BbJ5zf52o54+KWit
 JkdltcxHVzrbmgl3IQh9hn5fKM2MLd39bHXKbqEEHSVlly/DqQgvVXiJAqPSp+kBNeLMz6ybKEw
 zg+Ekmk=
X-Received: by 2002:a17:90b:48d0:b0:3a0:f432:2684 with SMTP id
 98e67ed59e1d1-3a0f4322bffmr34471a91.9.1790416017472; 
 Sat, 26 Sep 2026 02:46:57 -0700 (PDT)
Received: from
 codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.116]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b7d11124sm10180912a91.10.2026.09.26.02.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 02:46:55 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sat, 26 Sep 2026 09:46:48 +0000
Message-ID: <20260926094648.12124-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xAOzn-00080s-AI
Subject: [f2fs-dev] [PATCH] f2fs: batch block invalidation in
 f2fs_do_zero_range()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_do_zero_range() calls f2fs_invalidate_blocks() for each mapped
data block. Each call acquires the SIT sentry write lock and updates
segment information.

Batch contiguous physical block addresses into a single invalidation
call. A NEW_ADDR slot does not end a run if the subsequent physical
addresses are contiguous.

In a microbenchmark on an F2FS loop device, a fresh 64 MiB file was
written and fsynced before timing fallocate with FALLOC_FL_ZERO_RANGE
flag over the whole file. Across 20 runs, mean syscall time
decreased from 16.436 ms to 10.011 ms (39%).

Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/file.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b0bdc7a977b9..c227b7603731 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1713,6 +1713,8 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	unsigned int ofs_in_node = dn->ofs_in_node;
 	blkcnt_t count = 0;
 	int ret;
+	block_t blkstart = 0;
+	unsigned int blklen = 0;
 
 	for (; index < end; index++, dn->ofs_in_node++) {
 		if (f2fs_data_blkaddr(dn) == NULL_ADDR)
@@ -1739,16 +1741,30 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		if (dn->data_blkaddr == NEW_ADDR)
 			continue;
 
+		/*
+		 * Flush before validation so a repeated block address
+		 * can be detected through the SIT bitmap.
+		 */
+		if (blklen && blkstart + blklen != dn->data_blkaddr) {
+			f2fs_invalidate_blocks(sbi, blkstart, blklen);
+			blklen = 0;
+		}
+
 		if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
 					DATA_GENERIC_ENHANCE)) {
 			ret = -EFSCORRUPTED;
 			break;
 		}
 
-		f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
+		if (!blklen)
+			blkstart = dn->data_blkaddr;
+		blklen++;
 		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
+	if (blklen)
+		f2fs_invalidate_blocks(sbi, blkstart, blklen);
+
 	if (index > start) {
 		f2fs_update_read_extent_cache_range(dn, start, 0,
 							index - start);
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
