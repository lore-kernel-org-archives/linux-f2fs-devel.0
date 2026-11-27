Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE741606A686
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kPvT/cQH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ehvjPN5v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eOmhdaBx;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubLuhikm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=rmMyH9PDL74CLyOHrwP7jV8WhtIE8GVm54PDk/R4Q0I=; b=kPvT/cQH90Ir5oAMqeqJK57Nin
	qXd3aV/3kp4f5yJSRYlMfekN4xs0JqgfyoOZCjXLWJ5wobwnPs1MUyymsU5G47uaUbWsTWTCqo+oy
	4f3Q/yP8EVlbQXoiMWCL5c/mIn3KTPitRWdkR7vP/8gPUgqjqKs0gi3TLWhW9uVWJDSg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWrde-000000005M0-1Dja;
	Fri, 27 Nov 2026 08:49:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <qwjhust@gmail.com>) id 1xWrdd-000000005Lm-1Z89
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=; b=ehvjPN5vy5GxZWe19uqeEwki17
 TZU9prPHeZZ7tQIjZkK5Ewzq8EiGUbrLYfL5G5YdmU5XTnxjm2gDO3La8oiCA96j1rLURWKf1y7Hc
 U2OxvOCeFBY36HzKXe44KhsDpRkfZGohcwPYkbzBFTfXiFNYh++lURXivJBNgtY8pgQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=; b=eOmhdaBxlOblBA7FdPj/cLzXZb
 FG9Coi46lzehYDvBOTgmhQsY6nO59CFuGnXx4ogmCZ88Ko2gKAnDjfvV5XpDBaP7yVRKZhzjwayGH
 +0naNF1hrB60coka/YU8ZE1etD9L+BegBm7Bj9NTC8N9fDqcrITOb5mumUDnjknBZ1nM=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWrdc-000000005QX-0AaN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:01 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b402824d07so5209809a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795769334; x=1796374134; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
 b=ubLuhikmufeV1oKLq0jGfv8eB5BhiV2oFrRSLa2PVqut8mni7LXxf8m6+TCeu6Rbxh
 ddukaVUyKpXwleWmvo/QolLa3a8jsOP/wXTSR03HNtlgzz+9H0HOZNG2Zn6ztSDDr7Pp
 rf0oJ3uMht6M7k7iNakbikQACxMlCUgEEcbD0SZTtPJcRwxIw0BIvBbawoMdLiNzSomm
 jTewUCpSW7DjcQzARunHhmmAaOMPiXGMmxODuEQDGuo4gFo3WFZYHSkpOfULGTnwphBP
 2Sy+Xk9Fu/kI/CZHVZscijbZQSVYjmdLsHDwQzpl0JK8kucyb9e8OVGXWt1qXfT1n2He
 agYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795769334; x=1796374134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
 b=Z60V5hR2FkLHwfWHwAsN8Z8O+jsikfJW/BEj4A9cOyj1cm5ZYk26b9kATHmAaHpyGQ
 AatnPAWMv0ODgJAq8/ABAHeNC7psAkaKDvpHJ3oNTsoG/ZQAcjpZZnolPerFsnf4ZDAc
 q2icydCCWgDCgRjkLNNTirf+Z+LD1YjRO3sGKYX2yMK/C+SBD62B6pidFMRo1bxlfSeN
 RU4fiUrrLBLNWjxJGCIMhsYCxflX4ccVPnvn3XHkOTHlzDVepARdm2EyB7hFFUNF+jMw
 kxhv1JX8MZJ1I4C6pbW3kyAYc9JxqkVXwjsnxjCvqIHnYVCgHyc1qFrpXkcVZNV/sp31
 JYcg==
X-Gm-Message-State: APuU4Z9n5QaCvzODsEukqUYwzIx8nUJr47WwSAsrPjwSW7p8oiZ5jbp2
 87UaT41ZBMZINETSf5DPOkffMbDDEayO0m6Cayy8BCT+YAtr8KmoBVoj
X-Gm-Gg: AZFdTZcIouoDp0mCwjmQZJSkJd4DJwZo4UwBktO3+hbttR7D271t0fGSea73mDrEApt
 8zWF2Y/QvfGnxSyzf28at0EMb/tF7HuKL20Ab8CHXnxO7+3DncfNqXGEJd+lcdQfULS22qvzHpm
 zvpC8OdmZxBUgn2E8UYuJvk3WvUzMKa/I10XQ92Fm2FuTN00yTviX6++/wXe4zWYXJ/uj2GYK+r
 FkzL36qfjdZy5vlvt/hMp0bx5NFNVI6x11WxSHseJBvS5rhlXMr6w58hoIpCa83E0kUpmpS/ZcP
 xcofH71jB4W9jQrSgQASBq4q4MecxQB7L7eghAFD9UUzWaB7XM//a2HONQBWozo2qsJJ5Ti+TDl
 tApo6VL8Z+WVdtmMPOTQPwSJiDfwwOttKUeUy2Dn2wwzExxl3t/bKl4fQ3/d1wT7di+GkkR2Z1L
 t+s2loqWQjOaMf21kqK5NjXNoE7qMSTFSMPI7guMz7INToL8+QpMr23W/kdd3b9YOgTALZcF3g2
 wzCApN1qiFl0OHBurIQXecGd1jSEuWI+ixlx5zUI98nynMMLOkQRR6n3vMa1LvtPcLK2cB/5ez9
 HiVR66afQkK4W4DprzMV7/y+dDVg1ZWv5usBH881GCYIdSzVsIh/FabnFoUmNmttxbzGonGWfL6
 Vh30v5MeAYgM=
X-Received: by 2002:a17:90b:390e:b0:3b4:fcba:8f7d with SMTP id
 98e67ed59e1d1-3b4fcba9627mr7869895a91.29.1795769334244; 
 Fri, 27 Nov 2026 00:48:54 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 00:48:53 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 27 Nov 2026 16:48:43 +0800
Message-ID: <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWrdc-000000005QX-0AaN
Subject: [f2fs-dev] [PATCH v6 0/2] f2fs: enable buffered RWF_DONTCACHE
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables buffered RWF_DONTCACHE on F2FS for one-pass streaming
I/O, where retaining the transferred data can displace more useful cache.

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK. Normal and
dropbehind folios may share otherwise mergeable IPU and OPU bios; the flag
is set when a dropbehind folio joins a bio. The block layer handles
deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the buffered write folio lookup and
advertises FOP_DONTCACHE, enabling buffered reads and writes. Internal
write_begin callers that pass a NULL kiocb remain supported.

Tests used x86-64 QEMU/KVM with two vCPUs, 2 GiB RAM, and an NVMe-backed
F2FS image. Each attempt transferred a 1-GiB file sequentially in a fresh
guest, with memory.max=255852544 (244 MiB) and memory.swap.max=0. Normal
and dontcache each ran ten counterbalanced rounds. Values below are
arithmetic means of the ten runs per mode. Write throughput excludes the
final fdatasync().

Throughput was:

 Operation  I/O       Normal MiB/s  Dontcache MiB/s  Change
 Read       1 MiB         4137.96          5869.38  +41.84%
 Write      8 KiB          686.09          1752.24 +155.39%
 Write      1 MiB          714.91          2161.02 +202.28%

Average memory.current was:

 Operation  I/O       Normal MiB  Dontcache MiB  Change
 Read       1 MiB         197.26          13.70 -93.06%
 Write      8 KiB         214.22          13.15 -93.86%
 Write      1 MiB         215.20          19.52 -90.93%

Mean reclaim counters per run were:

 Operation  I/O       pgscan normal/DC   pgsteal normal/DC
 Read       1 MiB          200999.7/0          200888.4/0
 Write      8 KiB          201136.8/0          201120.8/0
 Write      1 MiB          200899.3/0          200883.3/0

Scan counts pages examined by reclaim; steal counts pages reclaimed.
memory.current includes all memory charged to the workload, not only
file-cache pages.

Dontcache left zero target pages resident after reads and one 4-KiB page
after write synchronization.

Changes since v5:

- Rebase onto the F2FS dev branch, adapting the bio tagging to the
  sub-folio merge paths and excluding metadata-cache I/O.
- Drop the Android 6.12 backport results, as its dropbehind implementation
  differs substantially from that in the current dev branch.
- Add memory-limited read results and update the write results,
  reporting arithmetic means of ten runs per mode.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 10 ++++++++++
 fs/f2fs/file.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
