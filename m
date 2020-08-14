Return-Path: <SRS0=wfIi=BY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B5C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:18:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B2720768;
	Fri, 14 Aug 2020 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dTu8FnHN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Z2fWVj+P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYsa9io3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B2720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k6g9i-00009w-At; Fri, 14 Aug 2020 20:18:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1k6g9g-00009U-MU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 14 Aug 2020 20:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fDrl6XXaol/OU+6KwIGrPwkuER1yuw4jrp90QVk3f+E=; b=dTu8FnHNoQiTzmjx8sngrLnjxB
 ajcy6qzDjpLAPdeStStyAN+jngaTGUmCUo9DGZzRTyrLTn83mFw0mxFt23/zHL2dTyZ8gTg3AUloL
 OhBDBcBHPjHa5HQrNPg/tIyFDTsF7x8KdD/hJfrA6wUtYPSP/cXBP7f2OH8Ju+5rfGPo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fDrl6XXaol/OU+6KwIGrPwkuER1yuw4jrp90QVk3f+E=; b=Z
 2fWVj+PDgBBXlcqaWLylFKDbdSs6J0m7CElq0pmw4FyC7noudJFZNOaW/KauKZFpZWQvQKO7Wg/tI
 /H8ii7xHo55Ol2XosurIh2grFRFVdsHWnaRSrJIbMWvAA96OkyWs5PpDowWmpaKaEYtvgGGj8IXqP
 GOJOTn49AfJfMqGs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k6g9a-00Eb1v-Nv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 14 Aug 2020 20:18:24 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4618320768;
 Fri, 14 Aug 2020 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597436293;
 bh=LHpYN13MSqprTmN0FRfF6cmVeafn5vcjng9yZ8PeqaU=;
 h=From:To:Cc:Subject:Date:From;
 b=UYsa9io3/Se/HAJuHdHOFJvgpkhXmdc4JhUooSfwygEkqNsydTbAeNWsmyB0XTZm5
 /65jx+N1zICXWPSonQt9Vqo7Fgnq4BjjfWfZ+FlAnjdZx8GadjYjHsbD8hL6wAtAWR
 yk+phiM3PZ9Ipo9Gd0kPSx4f8Nxv6Ly1W47JdjpQ=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 14 Aug 2020 13:18:11 -0700
Message-Id: <20200814201811.702661-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
X-Headers-End: 1k6g9a-00Eb1v-Nv
Subject: [f2fs-dev] [PATCH] f2fs_io: measure performance of write()
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 70a077a..6177d29 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -130,6 +130,25 @@ static void full_write(int fd, const void *buf, size_t count)
 	}
 }
 
+#if defined(__APPLE__)
+static u64 get_current_us()
+{
+#ifdef HAVE_MACH_TIME_H
+	return mach_absolute_time() / 1000;
+#else
+	return 0;
+#endif
+}
+#else
+static u64 get_current_us()
+{
+	struct timespec t;
+	t.tv_sec = t.tv_nsec = 0;
+	clock_gettime(CLOCK_BOOTTIME, &t);
+	return (u64)t.tv_sec * 1000000LL + t.tv_nsec / 1000;
+}
+#endif
+
 #define fsync_desc "fsync"
 #define fsync_help						\
 "f2fs_io fsync [file]\n\n"					\
@@ -434,6 +453,7 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	unsigned bs, count, i;
 	int flags = 0;
 	int fd;
+	u64 total_time = 0, max_time = 0, max_time_t = 0;
 
 	srand(time(0));
 
@@ -468,6 +488,7 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 
 	fd = xopen(argv[6], O_CREAT | O_WRONLY | flags, 0755);
 
+	total_time = get_current_us();
 	for (i = 0; i < count; i++) {
 		if (!strcmp(argv[4], "inc_num"))
 			*(int *)buf = inc_num++;
@@ -475,13 +496,20 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 			*(int *)buf = rand();
 
 		/* write data */
+		max_time_t = get_current_us();
 		ret = pwrite(fd, buf, buf_size, offset + buf_size * i);
+		max_time_t = get_current_us() - max_time_t;
+		if (max_time < max_time_t)
+			max_time = max_time_t;
 		if (ret != buf_size)
 			break;
 		written += ret;
 	}
 
-	printf("Written %"PRIu64" bytes with pattern=%s\n", written, argv[4]);
+	printf("Written %"PRIu64" bytes with pattern=%s, total_time=%"PRIu64" us, max_latency=%"PRIu64" us\n",
+				written, argv[4],
+				get_current_us() - total_time,
+				max_time);
 	exit(0);
 }
 
-- 
2.28.0.220.ged08abb693-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
