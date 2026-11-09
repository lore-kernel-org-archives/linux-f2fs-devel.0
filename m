Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8381606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l7Ze6hRV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=maGxVhY3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L2U8fk7C;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVMhVOZu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=+aG9xYal2chpiYFhJ/Dr/dqVzWvKbFpJC4vUMzBkRl8=; b=l7Ze6hRVqdZ+JiLHM9b5fkoUlb
	w+MzvPRRw24F/fCJPp5a3/rQZSNQS5Wcht9ibuHGGRnrPepA31+AAwWYaaPEAyE9TJP6iCwHYwGCJ
	lOz0O7EFN1tMFwoKoTGFSERbMVcyklOAvJFrJ2CSkOb6wfWU56FVNCSfbFVaVWQHq5Ho=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQEOE-000000004la-3S07;
	Mon, 09 Nov 2026 01:41:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <huangzheng9869@gmail.com>) id 1xQENu-000000004jy-1x0M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 01:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OmVqZvyk1sLhGMQW9PnlCw7KbRQ4+agndD0nwiQ+bAM=; b=maGxVhY35/Mj58rAEJnOh8Fv4T
 uJvmgUbxkKIYY9BzP+cUp9Gi8vSHSnqGBRZuncpcszLRtpt8kG7cJznNzyU2Ku8Hgtv5sfPOTrUMo
 3pF61IuMljvIv+QMDKO9eBWURrK8tBx1h9D04iGcrgWkJHqteMK482uXP8gJ1Y+JboVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OmVqZvyk1sLhGMQW9PnlCw7KbRQ4+agndD0nwiQ+bAM=; b=L2U8fk7CMvoMQwH9GiKmagUT5E
 GyIw1Ygb9NkLNjVwN58+ARi6TTIN4Ve9eLskKJHcDZOegGIBP/b0+ud+vGpMD46wNBTSQZUeVOnA/
 3vifPPZmNkH4YQre8Y4wr2TkNm3e92GuobvSAgewn+K3rENLreedySTMsAxK24VzSlNc=;
Received: from mail-dy1-f172.google.com ([74.125.82.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQENt-000000006hT-2OJH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 01:41:22 +0000
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-372bdb942dbso541289eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794188476; x=1794793276; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OmVqZvyk1sLhGMQW9PnlCw7KbRQ4+agndD0nwiQ+bAM=;
 b=CVMhVOZuF/oH2UkbcW/qH3Q6O66o1nmMDpIbewrUvHpinM5UgVJkE/SVEuYGsh3lXd
 FFsGK1zb3oDkA/gbCPqJ8pPPUcnrBYaYgIVp5MUmdSifWSx0Q8huDXyWkI1q7kAFsQ6t
 Wc8f6FD5TPu5/ShCGOLEU+xlMADmhfMFitsobuAvs+Q8WGWDXuU0WSXKscfCySPOJ0kB
 9GpQJv0Nn0XkmrD/c42GgKJS1cSL8U8KJEqL06SDPYwrQqzpLYRgku7HMZ0t+NJ+A0/A
 a+1+8t0vDU7FIZwVciH9aEDfHTs7JRZNicRx7qZH1brnDiAS5l2731UCkgz0HpM2w7y9
 qT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794188476; x=1794793276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OmVqZvyk1sLhGMQW9PnlCw7KbRQ4+agndD0nwiQ+bAM=;
 b=ccy+56KpOH6+0iMeUzCA/pXD2UYdJy0e6lOSS6B/EPtGLg1gjC6VFDNUoNeMYpkOd6
 rP1mjpTi26mT4uIpPowWwS71EzbE40OEcKYuKGhxLuixyVlfonRo8eYuTENgBQHbSsJi
 U0JIGqIpr8yYENsn4wySvOEhc0GZB/TK6QJQJ4tY0SVqhOpMFAqx1nSC6FKZ9/RrUIJE
 vuq9y9Xmul3YOlYFti18Y0YLPTSX1ARO9DUvoBVEcvedDeTfkqrPmznypjAR2gC3zihH
 TjJgt0l570Dwo+UNNdYg3BuNlPzxL7s0g5CtnSfUXZgIygk8zZcYlcY0dGEH9MMXjX3R
 1MDQ==
X-Gm-Message-State: APuU4Z8ZHG3jOAiYtJWY41d4VWkDIGC7fU1B/abfkrzav1lgxM2ljiWl
 e1m4Py+u70pB23yAex1PXwPKUCVaTUcI/YdtOI5vC5oFInsszE/F2WNPp0aIuif0
X-Gm-Gg: AYBFou1WKsKYmErBEMzRKUtpw7KekwoiARQdCcs4iCfUbtheMEcqE0vSokukK0F9Lxt
 re0j454uVyou5B3Uj+GN+7l1xHw7KYOxZNb13Oi66q17rctZZ6nz1CVQzzhiAqF/GlE8TsUFyER
 YMBBNyshLeg8UjDlK5vj9tbTOMVLrp60IJTIDJ/kAdz4c4tYg7KMBAk5UGiJCrF6WLeNd1W8NHp
 2KJh6M6kE+uHWbMj67ikIHQzVTI2izFuuYY67fyzWCy9A3u2Kwhmo7HWfCfIoyes+ZPu5s55roB
 FXACrmHg/xq0TKn9Blodd3l3zDpnUtC2asPRgvRMjfD/mTg1Zggqz2xPvauGlrNbcOnTqViz4OX
 HcQIOQxcDKrfhLgY9t811ccE0WsBXyk9MbxI94ibU0f6vJDypkeb3cs56OJI/HM/GR5T4R7DPXO
 VajzZu9ua+RcJsZJsqGPGniwELqB199b3eYSPPlJjJSb64SH7IMOri24yJdwOTnFRk7LOq4WIF0
 0i1CLEfHQ1PHROPU4JAu6jalrU258rx219kC/muEahJiqXY5cSmuXwtJoWZpj+QqbmDJnqFzlME
 zbVi8A2Yl0lYDIqMlnjML5k0srbO7WlAqxzpvtKZ3xGpSubMbaFhJBo++Tze
X-Received: by 2002:a05:7300:d401:b0:371:5cb0:4929 with SMTP id
 5a478bee46e88-372571d8554mr5883878eec.25.1794188475745; 
 Sun, 08 Nov 2026 17:41:15 -0800 (PST)
Received: from hp.mioffice.cn ([2408:8607:1b00:8:77fa:2c90:bd01:d846])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm12994409eec.19.2026.11.08.17.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:41:15 -0800 (PST)
From: huang zheng <huangzheng9869@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  9 Nov 2026 09:41:04 +0800
Message-ID: <20261109014104.3614066-1-huangzheng9869@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xQENt-000000006hT-2OJH
Subject: [f2fs-dev] [PATCH] mm: add readahead hit rate statistics
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Huang Zheng <huangzheng9869@gmail.com>, huangzheng1@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huang Zheng <huangzheng9869@gmail.com>

Add readahead hit rate statistics via debugfs at
/sys/kernel/debug/readahead_stat/.

For each buffered read operation, now tracks:
- demand_read_pages: the number of pages the filemap_get_pages request
- hit_read_pages: the number of pages that filemap_get_read_batch get

The readahead hit rate is calculated as hit_read_pages / demand_read_pages,
providing insight into readahead effectiveness.

This adds a new CONFIG_READAHEAD_STAT option that enables per-CPU statistics
collection in filemap_get_pages().

The statistics are exposed through debugfs with the following files:
- stat: shows aggregated statistics and calculated hit ratio
- demand_read_pages: total pages demanded across all reads
- hit_read_pages: total pages found in cache
- reset: write to reset all counters

This is useful for:
- Evaluating readahead policy effectiveness
- Performance analysis of buffered I/O workloads
- Tuning readahead parameters for specific workloads

The qualify test like this:
demand_read_pages:   24901451
hit_read_pages:      1647127
readahead_hit_ratio: 6.61%

Signed-off-by: Huang Zheng <huangzheng1@xiaomi.com>
---
 mm/Kconfig          |  14 +++++
 mm/Makefile         |   1 +
 mm/filemap.c        |  11 ++++
 mm/internal.h       |  16 +++++
 mm/readahead_stat.c | 150 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 mm/readahead_stat.c

diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..d5a3083b78b1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1287,6 +1287,20 @@ config PERCPU_STATS
 	  information includes global and per chunk statistics, which can
 	  be used to help understand percpu memory usage.
 
+config READAHEAD_STAT
+	bool "Collect readahead hit rate statistics"
+	depends on DEBUG_FS
+	help
+	  Collect and expose statistics about the pages an application read
+	  demands and how many of them were already in the page cache when
+	  the read ran (i.e. had been prefetched by readahead), via debugfs
+	  at /sys/kernel/debug/readahead_stat/.  The readahead hit rate is
+	  hit_read_pages / demand_read_pages.
+
+	  This is a debugging aid that adds a small amount of overhead to
+	  the buffered read path.  Say N unless you need to analyze
+	  readahead behavior.
+
 config GUP_TEST
 	bool "Enable infrastructure for get_user_pages()-related unit tests and benchmarks"
 	depends on DEBUG_FS
diff --git a/mm/Makefile b/mm/Makefile
index 2a3ec53d62ee..5600a4a788a5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_PTDUMP) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_READAHEAD_STAT) += readahead_stat.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..9e72095bf691 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2711,6 +2711,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	struct folio *folio;
 	unsigned int flags;
 	int err = 0;
+	bool ra_stat_done = false;
 
 	/* "last_index" is the index of the folio beyond the end of the read */
 	last_index = round_up(iocb->ki_pos + count,
@@ -2720,6 +2721,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		return -EINTR;
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
+	/*
+	 * Readahead hit rate: @count is the demand (in pages), the folios
+	 * just found in the page cache are the pages readahead had already
+	 * prefetched for it.  Account once per read even if a truncation
+	 * race below forces a retry.
+	 */
+	if (!ra_stat_done) {
+		readahead_stat_account(count, fbatch);
+		ra_stat_done = true;
+	}
 	if (!folio_batch_count(fbatch)) {
 		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
 
diff --git a/mm/internal.h b/mm/internal.h
index 566cbd2dce48..4f297aeaa9fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -624,6 +624,22 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
+/*
+ * Readahead hit rate statistics.  For every read, filemap_get_pages()
+ * accounts the pages demanded (the read size converted to pages) and the
+ * pages of that demand already found in the page cache by
+ * filemap_get_read_batch() - i.e. the pages readahead had prefetched.
+ * See mm/readahead_stat.c and /sys/kernel/debug/readahead_stat/.
+ */
+#ifdef CONFIG_READAHEAD_STAT
+void readahead_stat_account(size_t count, struct folio_batch *fbatch);
+#else
+static inline void readahead_stat_account(size_t count,
+					  struct folio_batch *fbatch)
+{
+}
+#endif
+
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
diff --git a/mm/readahead_stat.c b/mm/readahead_stat.c
new file mode 100644
index 000000000000..460eea11ef05
--- /dev/null
+++ b/mm/readahead_stat.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mm/readahead_stat.c - readahead hit rate statistics.
+ *
+ * For each read demanded by the application, filemap_get_pages() accounts:
+ *
+ *   demand_read_pages - the read size (@count) converted to pages, i.e. the
+ *			number of pages the application asked for.
+ *   hit_read_pages    - the pages of that demand already present in the page
+ *			cache when filemap_get_read_batch() ran, i.e. pages
+ *			readahead (or earlier reads) had already prefetched.
+ *
+ * The readahead hit rate is hit_read_pages / demand_read_pages.  Counters are
+ * per-CPU and aggregated when read through debugfs at
+ * /sys/kernel/debug/readahead_stat/.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/percpu.h>
+#include <linux/mm.h>
+#include <linux/pagevec.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/math64.h>
+
+#include "internal.h"
+
+struct ra_stat {
+	unsigned long demand_pages;
+	unsigned long hit_pages;
+};
+
+static DEFINE_PER_CPU(struct ra_stat, ra_stats);
+
+/**
+ * readahead_stat_account - account one read for the readahead hit rate.
+ * @count:	the read size in bytes; converted to pages for the stat.
+ * @fbatch:	folios found in the page cache by filemap_get_read_batch().
+ */
+void readahead_stat_account(size_t count, struct folio_batch *fbatch)
+{
+	unsigned long demand_pages = DIV_ROUND_UP(count, PAGE_SIZE);
+	unsigned long hit_pages = 0;
+	unsigned int i;
+
+	for (i = 0; i < folio_batch_count(fbatch); i++)
+		hit_pages += folio_nr_pages(fbatch->folios[i]);
+
+	/* A folio may extend beyond the read; hits can't exceed the demand. */
+	if (hit_pages > demand_pages)
+		hit_pages = demand_pages;
+
+	this_cpu_add(ra_stats.demand_pages, demand_pages);
+	this_cpu_add(ra_stats.hit_pages, hit_pages);
+}
+
+static void ra_stat_sum(struct ra_stat *total)
+{
+	int cpu;
+
+	memset(total, 0, sizeof(*total));
+	for_each_possible_cpu(cpu) {
+		const struct ra_stat *stat = &per_cpu(ra_stats, cpu);
+
+		total->demand_pages += stat->demand_pages;
+		total->hit_pages += stat->hit_pages;
+	}
+}
+
+/*********************************
+ * debugfs interface
+ *********************************/
+static int readahead_stat_demand_get(void *data, u64 *val)
+{
+	struct ra_stat total;
+
+	ra_stat_sum(&total);
+	*val = total.demand_pages;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(demand_fops, readahead_stat_demand_get,
+			 NULL, "%llu\n");
+
+static int readahead_stat_hit_get(void *data, u64 *val)
+{
+	struct ra_stat total;
+
+	ra_stat_sum(&total);
+	*val = total.hit_pages;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(hit_fops, readahead_stat_hit_get, NULL, "%llu\n");
+
+static int readahead_stat_reset_set(void *data, u64 val)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct ra_stat *stat = &per_cpu(ra_stats, cpu);
+
+		stat->demand_pages = 0;
+		stat->hit_pages = 0;
+	}
+	return 0;
+}
+
+static int readahead_stat_reset_get(void *data, u64 *val)
+{
+	*val = 0;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(reset_fops, readahead_stat_reset_get,
+			 readahead_stat_reset_set, "%llu\n");
+
+static int readahead_stat_show(struct seq_file *m, void *v)
+{
+	struct ra_stat total;
+
+	ra_stat_sum(&total);
+	seq_printf(m, "demand_read_pages:   %lu\n", total.demand_pages);
+	seq_printf(m, "hit_read_pages:      %lu\n", total.hit_pages);
+	if (total.demand_pages) {
+		u64 hit_x100 = div64_u64((u64)total.hit_pages * 10000ULL,
+					 total.demand_pages);
+
+		seq_printf(m, "readahead_hit_ratio: %llu.%02llu%%\n",
+			   hit_x100 / 100, hit_x100 % 100);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(readahead_stat);
+
+static int __init readahead_stat_init(void)
+{
+	struct dentry *dir;
+
+	if (!debugfs_initialized())
+		return 0;
+
+	dir = debugfs_create_dir("readahead_stat", NULL);
+	debugfs_create_file("demand_read_pages", 0444, dir, NULL, &demand_fops);
+	debugfs_create_file("hit_read_pages", 0444, dir, NULL, &hit_fops);
+	debugfs_create_file("stat", 0444, dir, NULL, &readahead_stat_fops);
+	debugfs_create_file("reset", 0200, dir, NULL, &reset_fops);
+
+	return 0;
+}
+late_initcall(readahead_stat_init);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
