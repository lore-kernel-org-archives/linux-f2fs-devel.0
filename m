Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355C606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DygidYRN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W+GJZNa4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WiQSejDC;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fzyg8rYU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=huUYtjpBQ/J/eY4VcSjI4Cm5vEEKoSJkpe2vyJdspi0=; b=DygidYRN7S89AY
	PfGe8/I6Hf4OcfHV9W5QrAYkO1mJT/SoK5va3qdAVhb3YDM1Gdh6JBSwRwkKn7/oIq71DDsch1H01
	dtJUoIRajnVL9kvRyJe4anUZ89U/3RZzn1fy7aBOQFGrUV6CDqLQOxwFHu75eiTj2n2sax+mhf0IF
	OL8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQhwm-000000004ia-3YCK;
	Tue, 10 Nov 2026 09:15:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xQhwl-000000004iT-2KJd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UoZH09qLgQAYw2SPJ5rk83HvmBTANmStC0/3mUTyuA=; b=W+GJZNa4WWD7NUS/pbzQ3s7wNO
 V/Q6bmKL+bZE+eW6mHKcFtAtiCw/G4j/m56fXwK0HLyhFE4e9S2uo7nKuCmi+RIGpPFqzNoYt3RNW
 8Qcvh8gKoB/8AnS+D8bHATzhOX5ms78r7s72WGC0nvevI5bxssLuCpKx4CYItzH/xxvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UoZH09qLgQAYw2SPJ5rk83HvmBTANmStC0/3mUTyuA=; b=WiQSejDCEvvqcP0JzEed+vJ8iz
 ZmDgCdghwYuJi592wUbt4mOJ5dyyb+ZO/LsAYdkqaEeK7k36+aVsJPj9gbuy6BYkwMrwXCfPN7E78
 AtuHrzL6qopZvEwOAFY5I7QNiwRXCekpHi7j/L7MAPhmApzAMsLL39QqhtcUoyV/BtaA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQhwh-000000001Pi-0zYf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:15:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC5DB46923;
 Tue, 10 Nov 2026 09:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2651F0089F;
 Tue, 10 Nov 2026 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794302109;
 bh=1UoZH09qLgQAYw2SPJ5rk83HvmBTANmStC0/3mUTyuA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Fzyg8rYUdwc0T3JtelJbsAWjOylR/sIEtqLX+4PG8vSAD9ktREjzlTOIZp81SrrQT
 7kKqwc+98JcMsU63bxwo2r7NuS0KwgOyae+yRGmmDRCeL/DbboRk1SpJBFxMZu0FGJ
 joc51NNGXEU00Rn3AXyVay5unG7nksHiaCX/mfZDlMEiHmQomQ/54De03nnEpjHr/L
 BhFN2UjMUNyhZLeCL5/VwMo7aNPpHsV7z48c8qiIXro7svZG796WUXc04C1iCSfFAg
 +vfT16Yr6tqG0KIyvhr1gxjn1gtnYzFA/SpzHyuZK+z0d8a+wryqT4iqgyIciTd9t5
 BBWC5Iz0ZvzCw==
Message-ID: <8096047e-6e3f-4550-9b00-6a199029ff4f@kernel.org>
Date: Tue, 10 Nov 2026 17:15:07 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: huang zheng <huangzheng9869@gmail.com>, jaegeuk@kernel.org
References: <20261109014104.3614066-1-huangzheng9869@gmail.com>
Content-Language: en-US
In-Reply-To: <20261109014104.3614066-1-huangzheng9869@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQhwh-000000001Pi-0zYf
Subject: Re: [f2fs-dev] [PATCH] mm: add readahead hit rate statistics
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
Cc: huangzheng1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sent to wrong mailing list?

On 11/9/26 09:41, huang zheng wrote:
> From: Huang Zheng <huangzheng9869@gmail.com>
> 
> Add readahead hit rate statistics via debugfs at
> /sys/kernel/debug/readahead_stat/.
> 
> For each buffered read operation, now tracks:
> - demand_read_pages: the number of pages the filemap_get_pages request
> - hit_read_pages: the number of pages that filemap_get_read_batch get
> 
> The readahead hit rate is calculated as hit_read_pages / demand_read_pages,
> providing insight into readahead effectiveness.
> 
> This adds a new CONFIG_READAHEAD_STAT option that enables per-CPU statistics
> collection in filemap_get_pages().
> 
> The statistics are exposed through debugfs with the following files:
> - stat: shows aggregated statistics and calculated hit ratio
> - demand_read_pages: total pages demanded across all reads
> - hit_read_pages: total pages found in cache
> - reset: write to reset all counters
> 
> This is useful for:
> - Evaluating readahead policy effectiveness
> - Performance analysis of buffered I/O workloads
> - Tuning readahead parameters for specific workloads
> 
> The qualify test like this:
> demand_read_pages:   24901451
> hit_read_pages:      1647127
> readahead_hit_ratio: 6.61%
> 
> Signed-off-by: Huang Zheng <huangzheng1@xiaomi.com>
> ---
>  mm/Kconfig          |  14 +++++
>  mm/Makefile         |   1 +
>  mm/filemap.c        |  11 ++++
>  mm/internal.h       |  16 +++++
>  mm/readahead_stat.c | 150 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 192 insertions(+)
>  create mode 100644 mm/readahead_stat.c
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index afff1b25b543..d5a3083b78b1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1287,6 +1287,20 @@ config PERCPU_STATS
>  	  information includes global and per chunk statistics, which can
>  	  be used to help understand percpu memory usage.
>  
> +config READAHEAD_STAT
> +	bool "Collect readahead hit rate statistics"
> +	depends on DEBUG_FS
> +	help
> +	  Collect and expose statistics about the pages an application read
> +	  demands and how many of them were already in the page cache when
> +	  the read ran (i.e. had been prefetched by readahead), via debugfs
> +	  at /sys/kernel/debug/readahead_stat/.  The readahead hit rate is
> +	  hit_read_pages / demand_read_pages.
> +
> +	  This is a debugging aid that adds a small amount of overhead to
> +	  the buffered read path.  Say N unless you need to analyze
> +	  readahead behavior.
> +
>  config GUP_TEST
>  	bool "Enable infrastructure for get_user_pages()-related unit tests and benchmarks"
>  	depends on DEBUG_FS
> diff --git a/mm/Makefile b/mm/Makefile
> index 2a3ec53d62ee..5600a4a788a5 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_PTDUMP) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> +obj-$(CONFIG_READAHEAD_STAT) += readahead_stat.o
>  obj-$(CONFIG_EXECMEM) += execmem.o
>  obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
>  obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c..9e72095bf691 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2711,6 +2711,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	struct folio *folio;
>  	unsigned int flags;
>  	int err = 0;
> +	bool ra_stat_done = false;
>  
>  	/* "last_index" is the index of the folio beyond the end of the read */
>  	last_index = round_up(iocb->ki_pos + count,
> @@ -2720,6 +2721,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  		return -EINTR;
>  
>  	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
> +	/*
> +	 * Readahead hit rate: @count is the demand (in pages), the folios
> +	 * just found in the page cache are the pages readahead had already
> +	 * prefetched for it.  Account once per read even if a truncation
> +	 * race below forces a retry.
> +	 */
> +	if (!ra_stat_done) {
> +		readahead_stat_account(count, fbatch);
> +		ra_stat_done = true;
> +	}
>  	if (!folio_batch_count(fbatch)) {
>  		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 566cbd2dce48..4f297aeaa9fe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -624,6 +624,22 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
>  	force_page_cache_ra(&ractl, nr_to_read);
>  }
>  
> +/*
> + * Readahead hit rate statistics.  For every read, filemap_get_pages()
> + * accounts the pages demanded (the read size converted to pages) and the
> + * pages of that demand already found in the page cache by
> + * filemap_get_read_batch() - i.e. the pages readahead had prefetched.
> + * See mm/readahead_stat.c and /sys/kernel/debug/readahead_stat/.
> + */
> +#ifdef CONFIG_READAHEAD_STAT
> +void readahead_stat_account(size_t count, struct folio_batch *fbatch);
> +#else
> +static inline void readahead_stat_account(size_t count,
> +					  struct folio_batch *fbatch)
> +{
> +}
> +#endif
> +
>  unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
> diff --git a/mm/readahead_stat.c b/mm/readahead_stat.c
> new file mode 100644
> index 000000000000..460eea11ef05
> --- /dev/null
> +++ b/mm/readahead_stat.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * mm/readahead_stat.c - readahead hit rate statistics.
> + *
> + * For each read demanded by the application, filemap_get_pages() accounts:
> + *
> + *   demand_read_pages - the read size (@count) converted to pages, i.e. the
> + *			number of pages the application asked for.
> + *   hit_read_pages    - the pages of that demand already present in the page
> + *			cache when filemap_get_read_batch() ran, i.e. pages
> + *			readahead (or earlier reads) had already prefetched.
> + *
> + * The readahead hit rate is hit_read_pages / demand_read_pages.  Counters are
> + * per-CPU and aggregated when read through debugfs at
> + * /sys/kernel/debug/readahead_stat/.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/percpu.h>
> +#include <linux/mm.h>
> +#include <linux/pagevec.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/math64.h>
> +
> +#include "internal.h"
> +
> +struct ra_stat {
> +	unsigned long demand_pages;
> +	unsigned long hit_pages;
> +};
> +
> +static DEFINE_PER_CPU(struct ra_stat, ra_stats);
> +
> +/**
> + * readahead_stat_account - account one read for the readahead hit rate.
> + * @count:	the read size in bytes; converted to pages for the stat.
> + * @fbatch:	folios found in the page cache by filemap_get_read_batch().
> + */
> +void readahead_stat_account(size_t count, struct folio_batch *fbatch)
> +{
> +	unsigned long demand_pages = DIV_ROUND_UP(count, PAGE_SIZE);
> +	unsigned long hit_pages = 0;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_batch_count(fbatch); i++)
> +		hit_pages += folio_nr_pages(fbatch->folios[i]);
> +
> +	/* A folio may extend beyond the read; hits can't exceed the demand. */
> +	if (hit_pages > demand_pages)
> +		hit_pages = demand_pages;
> +
> +	this_cpu_add(ra_stats.demand_pages, demand_pages);
> +	this_cpu_add(ra_stats.hit_pages, hit_pages);
> +}
> +
> +static void ra_stat_sum(struct ra_stat *total)
> +{
> +	int cpu;
> +
> +	memset(total, 0, sizeof(*total));
> +	for_each_possible_cpu(cpu) {
> +		const struct ra_stat *stat = &per_cpu(ra_stats, cpu);
> +
> +		total->demand_pages += stat->demand_pages;
> +		total->hit_pages += stat->hit_pages;
> +	}
> +}
> +
> +/*********************************
> + * debugfs interface
> + *********************************/
> +static int readahead_stat_demand_get(void *data, u64 *val)
> +{
> +	struct ra_stat total;
> +
> +	ra_stat_sum(&total);
> +	*val = total.demand_pages;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(demand_fops, readahead_stat_demand_get,
> +			 NULL, "%llu\n");
> +
> +static int readahead_stat_hit_get(void *data, u64 *val)
> +{
> +	struct ra_stat total;
> +
> +	ra_stat_sum(&total);
> +	*val = total.hit_pages;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(hit_fops, readahead_stat_hit_get, NULL, "%llu\n");
> +
> +static int readahead_stat_reset_set(void *data, u64 val)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct ra_stat *stat = &per_cpu(ra_stats, cpu);
> +
> +		stat->demand_pages = 0;
> +		stat->hit_pages = 0;
> +	}
> +	return 0;
> +}
> +
> +static int readahead_stat_reset_get(void *data, u64 *val)
> +{
> +	*val = 0;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(reset_fops, readahead_stat_reset_get,
> +			 readahead_stat_reset_set, "%llu\n");
> +
> +static int readahead_stat_show(struct seq_file *m, void *v)
> +{
> +	struct ra_stat total;
> +
> +	ra_stat_sum(&total);
> +	seq_printf(m, "demand_read_pages:   %lu\n", total.demand_pages);
> +	seq_printf(m, "hit_read_pages:      %lu\n", total.hit_pages);
> +	if (total.demand_pages) {
> +		u64 hit_x100 = div64_u64((u64)total.hit_pages * 10000ULL,
> +					 total.demand_pages);
> +
> +		seq_printf(m, "readahead_hit_ratio: %llu.%02llu%%\n",
> +			   hit_x100 / 100, hit_x100 % 100);
> +	}
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(readahead_stat);
> +
> +static int __init readahead_stat_init(void)
> +{
> +	struct dentry *dir;
> +
> +	if (!debugfs_initialized())
> +		return 0;
> +
> +	dir = debugfs_create_dir("readahead_stat", NULL);
> +	debugfs_create_file("demand_read_pages", 0444, dir, NULL, &demand_fops);
> +	debugfs_create_file("hit_read_pages", 0444, dir, NULL, &hit_fops);
> +	debugfs_create_file("stat", 0444, dir, NULL, &readahead_stat_fops);
> +	debugfs_create_file("reset", 0200, dir, NULL, &reset_fops);
> +
> +	return 0;
> +}
> +late_initcall(readahead_stat_init);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
