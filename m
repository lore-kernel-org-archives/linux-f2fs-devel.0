Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1613CCFA13
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Nov 2025 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0xpBkMOkysmnDUb5qQfABvSVzZfGWuCZZz2fsKuQn/M=; b=abnZ47Im61WOK+M3//LsXn1GBD
	NoVBSPyzZhX3HmXNeqvfc7Y1lRBWNE/HP4y9YkWDo4BRbTmde74puS9aN9ga8hH4nz5FMlU36SGoD
	zkRCElvC4X432bzgsX25ZC/jGjv1EquIa1yEvP9445gWYzSZlGf6aiDEYenqGK1jbxHI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vINpQ-0005Ox-VV;
	Mon, 10 Nov 2025 09:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vINp2-0005OZ-4Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Nov 2025 09:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZK0SwlZ6aOAzbFOIBUCXWckSXIFnLfVzfCIAlEkZXZ4=; b=iLov2BLYFH9VqFZeSpMyiKnlFs
 CU5CzORBNadrj7Pzb2hEox90U5EidUWznJYrAcWnjS2EEJ1BHtRF5f0AqU8hzIYOyJXJHvLnvNnB2
 wrZDXvMgogn2gVozLd9KjAh2OT6EN/MyfH/iC4L+YI+Ccw1Z0IFbPMcei0cmTybhBXOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZK0SwlZ6aOAzbFOIBUCXWckSXIFnLfVzfCIAlEkZXZ4=; b=I
 BNdVVUUUsomu50/dXvdyRr4iLEbwQO50nRZUuDAGZO21ejmnhxz3gr7tyR3UP35L2j736GEUzEXBl
 fadjQ/Ox+L+VWYpO30gjl6XtXMU7fOHPtVE30ZGd6FWx+kdIT4RY4HpdWkKF+JuYa5lXfHwszjV67
 Z6vajyQYdpYh//I4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vINp1-0003Q5-Oc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Nov 2025 09:04:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BC1F415F2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Nov 2025 09:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B59C116B1;
 Mon, 10 Nov 2025 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762765458;
 bh=yrNFF4O9oJj5bX4gZ2U0fKhoqap12Uy17PYqLL1EaEg=;
 h=From:To:Cc:Subject:Date:From;
 b=YilNZE2LPjC58hbufvoVsPNJR7siXrKgGnX7+vdESvLMzL9//h9eOV9x64A1NR7KT
 XUeU9dYXKvJEa0HdG8++K0XZtZAx6nYAC7MLTjds1ZhEo+r5/BhBL0ymVIqdKx1k3z
 nTpTkHItAbk7o9CDyXSsHyFyXikl3kuENrrJ8jZNIUFufNnakqYvGLXRKjSOCJGqJ/
 OZMzSOqcdWIhxIDB1zYWpTj0ZD8HSKlyBQRlvkIOrfTqeyxBcBfhul42z4tXYiY+nn
 Rlulr8BiKPyv1miPwiBc8TyiXSjiHxO0EmKPp/am/EAFve2rmenScD6eM5a4iZrTP7
 OnWkAet+1lvDQ==
To: jaegeuk@kernel.org
Date: Mon, 10 Nov 2025 17:04:09 +0800
Message-ID: <20251110090409.1279009-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
MIME-Version: 1.0
X-Headers-End: 1vINp1-0003Q5-Oc
Subject: [f2fs-dev] [PATCH] f2fs_io: fix to keep output order of do_read()
 for forward compatibility
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Some scripts relies on output order of do_read(), let's append the
new logs to keep forward compatibility.

e.g.
f2fs_io read 128 0 $((2*1024)) buffered 1 0 /mnt/f2fs/file

Before:
Read 1073741824 bytes IO time = 153715 us mlock time = 0 us, BW = 6985 MB/s print 0 bytes:
00000000 :

After:
Read 1073741824 bytes total_time = 155166 us, BW = 6920 MB/s, IO time = 155166 us, mlock time = 0 us, print 0 bytes:
00000000 :

Fixes: 615036f ("f2fs_io: calculate IO bandwidth vs. mlock latency")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 231da47..326b3bd 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1065,10 +1065,13 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 		}
 		io_time_end = get_current_us();
 	}
-	printf("Read %"PRIu64" bytes IO time = %"PRIu64" us mlock time = %"PRIu64" us, BW = %.Lf MB/s print %u bytes:\n",
-		read_cnt, io_time_end - io_time_start,
+	printf("Read %"PRIu64" bytes total_time = %"PRIu64" us, BW = %.Lf MB/s, "
+		"IO time = %"PRIu64" us, mlock time = %"PRIu64" us, print %u bytes:\n",
+		read_cnt, get_current_us() - io_time_start,
+		((long double)read_cnt / (get_current_us() - io_time_start)),
+		io_time_end - io_time_start,
 		mlock_time_end - mlock_time_start,
-		((long double)read_cnt / (io_time_end - io_time_start)), print_bytes);
+		print_bytes);
 	printf("%08"PRIx64" : ", offset);
 	for (i = 1; i <= print_bytes; i++) {
 		printf("%02x", print_buf[i - 1]);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
