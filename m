Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913A606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TryxX2Lj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ROgNsou+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MSWRoxj4;
	dkim=neutral header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aCilGykE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Uk++kYJW9ySR/j/AZDHyayCQVhhMlLVwEuC1Dtuiq9A=; b=TryxX2LjwmMbPer/XsxB5xRI+W
	VbIKx1qWEqEaLhiMDY+hdF43tR7edMqapz/PQxVWw/xSWijigiQjysSAwawUBznE2sv/kcC4ukJTO
	9+YUJx1T0NLdQyz4wh4aIrT8W9VROBCiwJXg1/1ICTy6FnnaCzwWtJv8A1q62OJdCsrc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO5Zm-000000000D7-3e1O;
	Tue, 03 Nov 2026 03:52:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <rdunlap@infradead.org>) id 1xO5Zl-000000000D0-1fny
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 03:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BrzT7WAPrdCVBMEHfDs2E8tzNv03WR2m2eL5Qe+Xat0=; b=ROgNsou+SqfsTcz7dSQ4UkRqRp
 FTeARB/v1xTUKgiXmJjjr1Wfg2qtxt98hDlBUPhbW1zNLdWeu0WGiZFfImO/t2B5clkTCWmMP5mFb
 Fd31FKRmPEQgZMQzgYGNrUOfco/JhrcgIApJ0hIPNcFlthI0TAXQgqeRHcRLniK6pBJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BrzT7WAPrdCVBMEHfDs2E8tzNv03WR2m2eL5Qe+Xat0=; b=MSWRoxj43bnmouNXAYdYk8a6cs
 koYD+wpU6X0Aa2X+4bnjtctsLxBHG71sV6+fuYfXJxK3big2J9S1xHZ8XERCwJanD9noEFXZvkMWM
 +/VfyOQ9RPHHEr4zudw+mjLAGPb+C2DPTPJZsZZ+YpXJ4Zlc/F4u31IJXmQQsEUZTwPA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO5Zi-000000006Ce-3ffQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 03:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=BrzT7WAPrdCVBMEHfDs2E8tzNv03WR2m2eL5Qe+Xat0=; b=aCilGykEp5rHIbY7yYmgsLopsi
 apfR7gqCE0f/fTl3HYf/5rG5/BsF93AKyE+HW/K4Ih9wtvb/C4XC7Sx4JlVLHyUYzjeOcve6F2OMv
 k7IbLpLdHfPcStF4TvnR4pt/h5Bom4BmaU1CHVCOYc7rSQ9/31x/Etlp2vpjQTzh2MBgucyWz79FY
 4nOmoPGh9LqUBgHo40yvJhZnkuN8uG5/ymBIe4GgPzVVtmwoIZIx4BmsOhuS7zAI7JCjjpbkKwa/F
 eDQOk/ChAfm7ARFEVnN8osWPM3q6Xo9Bqo0X7rkOJt9YAIXXu6XUBHhxUschxuT3Uy4gRf8GVaizB
 KlAqzt+w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xO5Kj-00000000wsq-3Rdr; Tue, 03 Nov 2026 03:37:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Date: Mon,  2 Nov 2026 19:37:13 -0800
Message-ID: <20261103033713.2709978-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO5Zi-000000006Ce-3ffQ
Subject: [f2fs-dev] [PATCH] f2fs: fix various ABI documentation issues
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clean up the f2fs sysfs ABI documentation:
- use "number" instead of "#"
- use "seconds" instead of "secs"
- remove an extraneous period ('.')
- add a space for better readability
- fix grammar, spelling, & punctuation
- break up comma splices
- use a list for "gc_urgent"
- add a blank line for the list in "extension_list" &
  "effective_lookup_mode"


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>

 Documentation/ABI/testing/sysfs-fs-f2fs |  114 +++++++++++-----------
 1 file changed, 61 insertions(+), 53 deletions(-)

--- linux-next-20261102.orig/Documentation/ABI/testing/sysfs-fs-f2fs
+++ linux-next-20261102/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -36,7 +36,7 @@ Description:	This parameter controls the
 		the number of segments in the proportion to the percentage
 		over total volume size, f2fs tries to conduct checkpoint to
 		reclaim the prefree segments to free segments.
-		By default, 5% over total # of segments.
+		By default, 5% over total number of segments.
 
 What:		/sys/fs/f2fs/<disk>/main_blkaddr
 Date:		November 2019
@@ -46,12 +46,12 @@ Description:	Shows first block address o
 What:		/sys/fs/f2fs/<disk>/ipu_policy
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
-Description:	Controls the in-place-update policy.
+Description:	Controls the in-place-update policy
 		updates in f2fs. User can set:
 
 		===== =============== ===================================================
 		value policy          description
-		0x00  DISABLE         disable IPU(=default option in LFS mode)
+		0x00  DISABLE         disable IPU (=default option in LFS mode)
 		0x01  FORCE           all the time
 		0x02  SSR             if SSR mode is activated
 		0x04  UTIL            if FS utilization is over threshold
@@ -59,7 +59,7 @@ Description:	Controls the in-place-updat
 		                      threshold
 		0x10  FSYNC           activated in fsync path only for high performance
 		                      flash storages. IPU will be triggered only if the
-		                      # of dirty pages over min_fsync_blocks.
+		                      number of dirty pages is over min_fsync_blocks.
 		                      (=default option)
 		0x20  ASYNC           do IPU given by asynchronous write requests
 		0x40  NOCACHE         disable IPU bio cache
@@ -67,7 +67,7 @@ Description:	Controls the in-place-updat
 		                      FI_OPU_WRITE flag
 		===== =============== ===================================================
 
-		Refer segment.h for details.
+		Refer to segment.h for details.
 
 What:		/sys/fs/f2fs/<disk>/min_ipu_util
 Date:		November 2013
@@ -144,7 +144,7 @@ Date:		July 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Controls discard granularity of inner discard thread. Inner thread
 		will not issue discards with size that is smaller than granularity.
-		The unit size is one block(4KB), now only support configuring
+		The unit size is one block(4KB); only supports configuring
 		in range of [1, 512]. Default value is 16.
 		For small devices, default value is 1.
 
@@ -152,7 +152,7 @@ What:		/sys/fs/f2fs/<disk>/umount_discar
 Date:		January 2019
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Set timeout to issue discard commands during umount.
-	        Default: 5 secs
+	        Default: 5 seconds
 
 What:		/sys/fs/f2fs/<disk>/pending_discard
 Date:		November 2021
@@ -170,9 +170,9 @@ What:		/sys/fs/f2fs/<disk>/migration_gra
 Date:		October 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Controls migration granularity of garbage collection on large
-		section, it can let GC move partial segment{s} of one section
-		in one GC cycle, so that dispersing heavy overhead GC to
-		multiple lightweight one.
+		section. It can let GC move partial segment{s} of one section
+		in one GC cycle, dispersing heavy overhead GC to
+		multiple lightweight ones.
 
 What:		/sys/fs/f2fs/<disk>/dir_level
 Date:		March 2014
@@ -208,7 +208,7 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Contact:	"Sahitya Tummala" <quic_stummala@quicinc.com>
 Description:	Controls the idle timing of discard thread given
 		this time interval.
-		Default is 5 secs.
+		Default is 5 seconds.
 
 What:		/sys/fs/f2fs/<disk>/gc_idle_interval
 Date:		September 2018
@@ -224,7 +224,7 @@ Description:	Controls to enable/disable
 What:		/sys/fs/f2fs/<disk>/ra_nid_pages
 Date:		October 2015
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
-Description:	Controls the count of nid pages to be readaheaded.
+Description:	Controls the count of nid pages to be read ahead.
 		When building free nids, F2FS reads NAT blocks ahead for
 		speed up. Default is 0.
 
@@ -259,7 +259,7 @@ Description:	Expand /sys/fs/f2fs/<disk>/
 		project_quota (aka projquota), inode_checksum,
 		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
 		verity, sb_checksum, casefold, readonly, compression.
-		Note that, pin_file is moved into /sys/fs/f2fs/features/.
+		Note that pin_file is moved into /sys/fs/f2fs/features/.
 
 What:		/sys/fs/f2fs/features/
 Date:		July 2017
@@ -291,8 +291,8 @@ Description:	Shows the number of dirty s
 What:		/sys/fs/f2fs/<disk>/reserved_blocks
 Date:		June 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
-Description:	Controls target reserved blocks in system, the threshold
-		is soft, it could exceed current available user space.
+Description:	Controls target reserved blocks in system. The threshold
+		is soft; it could exceed current available user space.
 
 What:		/sys/fs/f2fs/<disk>/current_reserved_blocks
 Date:		October 2017
@@ -307,18 +307,21 @@ What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Do background GC aggressively when set. Set to 0 by default.
-		gc urgent high(1): does GC forcibly in a period of given
-		gc_urgent_sleep_time and ignores I/O idling check. uses greedy
-		GC approach and turns SSR mode on.
-		gc urgent low(2): lowers the bar of checking I/O idling in
-		order to process outstanding discard commands and GC a
-		little bit aggressively. always uses cost benefit GC approach,
-		and will override age-threshold GC approach if ATGC is enabled
-		at the same time.
-		gc urgent mid(3): does GC forcibly in a period of given
-		gc_urgent_sleep_time and executes a mid level of I/O idling check.
-		always uses cost benefit GC approach, and will override
-		age-threshold GC approach if ATGC is enabled at the same time.
+
+		- gc urgent high(1): does GC forcibly in a period of given
+		  gc_urgent_sleep_time and ignores I/O idling check. uses greedy
+		  GC approach and turns SSR mode on.
+
+		- gc urgent low(2): lowers the bar of checking I/O idling in
+		  order to process outstanding discard commands and GC a
+		  little bit aggressively. always uses cost benefit GC approach,
+		  and will override age-threshold GC approach if ATGC is enabled
+		  at the same time.
+
+		- gc urgent mid(3): does GC forcibly in a period of given
+		  gc_urgent_sleep_time and executes a mid level of I/O idling check.
+		  always uses cost benefit GC approach, and will override
+		  age-threshold GC approach if ATGC is enabled at the same time.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
@@ -341,6 +344,7 @@ What:		/sys/fs/f2fs/<disk>/extension_lis
 Date:		February 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Used to control configure extension list:
+
 		- Query: cat /sys/fs/f2fs/<disk>/extension_list
 		- Add: echo '[h/c]extension' > /sys/fs/f2fs/<disk>/extension_list
 		- Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
@@ -359,7 +363,7 @@ What:		/sys/fs/f2fs/<disk>/encoding
 Date:		July 2019
 Contact:	"Daniel Rosenberg" <drosen@google.com>
 Description:	Displays name and version of the encoding set for the filesystem.
-		If no encoding is set, displays (none)
+		If no encoding is set, displays ``(none)``.
 
 What:		/sys/fs/f2fs/<disk>/free_segments
 Date:		September 2019
@@ -417,13 +421,13 @@ Description:	Number of blocks moved by d
 What:		/sys/fs/f2fs/<disk>/mounted_time_sec
 Date:		February 2020
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Show the mounted time in secs of this partition.
+Description:	Show the mounted time in seconds of this partition.
 
 What:		/sys/fs/f2fs/<disk>/data_io_flag
 Date:		April 2020
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Give a way to attach REQ_META|FUA to data writes
-		given temperature-based bits. Now the bits indicate:
+		given temperature-based bits. The bits indicate:
 
 		+-------------------+-------------------+
 		|      REQ_META     |      REQ_FUA      |
@@ -437,7 +441,7 @@ What:		/sys/fs/f2fs/<disk>/node_io_flag
 Date:		June 2020
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Give a way to attach REQ_META|FUA to node writes
-		given temperature-based bits. Now the bits indicate:
+		given temperature-based bits. The bits indicate:
 
 		+-------------------+-------------------+
 		|      REQ_META     |      REQ_FUA      |
@@ -450,7 +454,7 @@ Description:	Give a way to attach REQ_ME
 What:		/sys/fs/f2fs/<disk>/iostat_period_ms
 Date:		April 2020
 Contact:	"Daeho Jeong" <daehojeong@google.com>
-Description:	Give a way to change iostat_period time. 3secs by default.
+Description:	Give a way to change iostat_period time. 3 seconds by default.
 		The new iostat trace gives stats gap given the period.
 What:		/sys/fs/f2fs/<disk>/max_io_bytes
 Date:		December 2020
@@ -565,8 +569,8 @@ What:		/sys/fs/f2fs/<disk>/atgc_candidat
 Date:		May 2021
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls candidate ratio in order to limit total
-		number of potential victim in all candidates, the value should be in
-		range of [0, 100], by default it was initialized as 20(%).
+		number of potential victim in all candidates. The value should be in
+		range of [0, 100]; by default it was initialized as 20(%).
 
 What:		/sys/fs/f2fs/<disk>/atgc_candidate_count
 Date:		May 2021
@@ -592,8 +596,8 @@ Description:	When ATGC is on, it control
 What:		/sys/fs/f2fs/<disk>/atgc_enabled
 Date:		Feb 2024
 Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
-Description:	It represents whether ATGC is on or off. The value is 1 which
-               indicates that ATGC is on, and 0 indicates that it is off.
+Description:	It represents whether ATGC is on or off. The value of 1
+		indicates that ATGC is on, and 0 indicates that it is off.
 
 What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
 Date:		July 2021
@@ -641,8 +645,8 @@ Description:	You can set the trial count
 What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
 Date:		January 2022
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Controls max # of node block writes to be used for roll forward
-		recovery. This can limit the roll forward recovery time.
+Description:	Controls max number of node block writes to be used for roll
+		forward recovery. This can limit the roll forward recovery time.
 
 What:		/sys/fs/f2fs/<disk>/unusable_blocks_per_sec
 Date:		June 2022
@@ -719,9 +723,9 @@ What:		/sys/fs/f2fs/<disk>/fault_type
 Date:		May 2016
 Contact:	"Sheng Yong" <shengyong@oppo.com>
 Contact:	"Chao Yu" <chao@kernel.org>
-Description:	Support configuring fault injection type, should be
-		enabled with fault_injection option, fault type value
-		is shown below, it supports single or combined type.
+Description:	Support configuring fault injection type. Should be
+		enabled with fault_injection option. Fault type values
+		are shown below. It supports single or combined type.
 
 		===========================      ==========
 		Type_Name                        Type_Value
@@ -759,8 +763,8 @@ Date:		January 2023
 Contact:	"Yangtao Li" <frank.li@vivo.com>
 Description:	Controls background discard granularity of inner discard thread
 		when is not in idle. Inner thread will not issue discards with size that
-		is smaller than granularity. The unit size is one block(4KB), now only
-		support configuring in range of [0, 512].
+		is smaller than granularity. The unit size is one block(4KB); only
+		supports configuring in range of [0, 512].
 		Default: 512
 
 What:		/sys/fs/f2fs/<disk>/last_age_weight
@@ -809,7 +813,7 @@ What:		/sys/fs/f2fs/<disk>/migration_win
 Date:		September 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Controls migration window granularity of garbage collection on large
-		section. it can control the scanning window granularity for GC migration
+		section. It can control the scanning window granularity for GC migration
 		in a unit of segment, while migration_granularity controls the number
 		of segments which can be migrated at the same turn.
 
@@ -824,14 +828,14 @@ Date:		September 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	If the percentage of free sections over total sections is above this
 		number, F2FS do not garbage collection for zoned devices through the
-		background GC thread. the default number is "60".
+		background GC thread. The default number is "60".
 
 What:		/sys/fs/f2fs/<disk>/gc_boost_zoned_gc_percent
 Date:		September 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	If the percentage of free sections over total sections is under this
 		number, F2FS boosts garbage collection for zoned devices through the
-		background GC thread. the default number is "25".
+		background GC thread. The default number is "25".
 
 What:		/sys/fs/f2fs/<disk>/gc_valid_thresh_ratio
 Date:		September 2024
@@ -844,7 +848,7 @@ Description:	It controls the valid block
 What:		/sys/fs/f2fs/<disk>/max_read_extent_count
 Date:		November 2024
 Contact:	"Chao Yu" <chao@kernel.org>
-Description:	It controls max read extent count for per-inode, the value of threshold
+Description:	It controls max read extent count for per-inode; the value of the threshold
 		is 10240 by default.
 
 What:		/sys/fs/f2fs/tuning/reclaim_caches_kb
@@ -867,7 +871,7 @@ Description:	For several zoned storage d
 What:		/sys/fs/f2fs/<disk>/encoding_flags
 Date:		April 2025
 Contact:	"Chao Yu" <chao@kernel.org>
-Description:	This is a read-only entry to show the value of sb.s_encoding_flags, the
+Description:	This is a read-only entry to show the value of sb.s_encoding_flags. The
 		value is hexadecimal.
 
 		============================     ==========
@@ -883,7 +887,7 @@ Contact:	"Chao Yu" <chao@kernel.org>
 Description:	This threshold is used to control triggering garbage collection while
 		fallocating on pinned file, so, it can guarantee there is enough free
 		reserved section before preallocating on pinned file.
-		By default, the value is ovp_sections, especially, for zoned ufs, the
+		By default, the value is ovp_sections; especially, for zoned ufs, the
 		value is 1.
 
 What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
@@ -896,7 +900,7 @@ Description:	Set a multiplier for the ba
 What:		/sys/fs/f2fs/<disk>/gc_boost_gc_greedy
 Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
-Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
+Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy.
 		Default: 1
 
 What:		/sys/fs/f2fs/<disk>/effective_lookup_mode
@@ -909,6 +913,7 @@ Description:
 		encoding flag, SB_ENC_NO_COMPAT_FALLBACK_FL.
 
 		Possible values are:
+
 		- "perf": Hash-only lookup.
 		- "compat": Hash-based lookup with a linear search fallback enabled
 		- "auto:perf": lookup_mode is auto and fallback is disabled on-disk
@@ -952,15 +957,16 @@ Description:	Controls write priority in
 What:		/sys/fs/f2fs/<disk>/max_lock_elapsed_time
 Date:		December 2025
 Contact:	"Chao Yu" <chao@kernel.org>
-Description:	This is a threshold, once a thread enters critical region that lock covers, total
+Description:	This is a threshold; once a thread enters critical region that lock covers, if total
 		elapsed time exceeds this threshold, f2fs will print tracepoint to dump information
-		of related context. This sysfs entry can be used to control the value of threshold,
+		of related context. This sysfs entry can be used to control the value of threshold;
 		by default, the value is 500 ms.
 
 What:		/sys/fs/f2fs/<disk>/inject_timeout_type
 Date:		December 2025
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	This sysfs entry can be used to change type of injected timeout:
+
 		==========     ===============================
 		Flag_Value     Flag_Description
 		==========     ===============================
@@ -976,6 +982,7 @@ Date:		January 2026
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	This sysfs entry can be used to enable/disable to adjust priority for task
 		which is in critical region covered by lock.
+
 		==========     ==================
 		Flag_Value     Flag_Description
 		==========     ==================
@@ -1000,7 +1007,8 @@ What:		/sys/fs/f2fs/<disk>/critical_task
 Date:		February 2026
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It can be used to tune priority of f2fs critical task, e.g. f2fs_ckpt, f2fs_gc
-		threads, limitation as below:
+		threads. Limitations as below:
+
 		- it requires user has CAP_SYS_NICE capability.
 		- the range is [100, 139], by default the value is 120.
 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
