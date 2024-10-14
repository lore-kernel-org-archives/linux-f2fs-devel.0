Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEF5D18153
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Oct 2024 21:32:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0Sg7-0003kD-V3;
	Mon, 14 Oct 2024 21:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1t0Sg6-0003k5-SI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 21:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B0aPC2E6Icn6HYxd8/hNydibZThv7YtjhNjTd2Ghr5E=; b=nBzc26b8Sm0B5weBUn6F8uCk5E
 TvdZe1Y2hue2xHit5yZjHqcStQLRSEynNneN5ZnuvfxqBU4kerkOivrUAFUO9SdLzWV2AmRqikWDj
 UGnlHJOX/IsEPeNJEtrL8qepcwo2CE8fZKL/aixMYHTUc7TZl2iYLG0Kh/MEAvJfL5h0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B0aPC2E6Icn6HYxd8/hNydibZThv7YtjhNjTd2Ghr5E=; b=R
 L3AQbJDHaUReWMLS1ckQoK1m6WjeDDRTojGqtaHMVdhsAyDxbAjzdcgBuvW7Y5MpglWcyg2v/3etw
 E1f5siUfWxeXBqQ2N5IYTj6ncjAwP6MwmFzFGaAY5jXQxqtLt+k01JJJD1LH5SsRQMfyMHPSdgGTC
 VasfLPOgT0a3UbjY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t0Sg6-00016D-7m for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 21:32:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5D3E05C591B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Oct 2024 21:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5530AC4CEC3;
 Mon, 14 Oct 2024 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728941543;
 bh=6xAHmC1sqHIbb+Fls85VH1FXONnNyQpdMKr7QSdVi98=;
 h=From:To:Cc:Subject:Date:From;
 b=Y0D3Hd9zyiyNKEND5WqE8fPjvldNB5932XmDYEy4bu1wyU1YvFo9cjHSzludmLXIr
 4+arwD0P8qZqJesysgm1Y07HNcct0avlWTnqMJ8oP0HHJhuwx4RnUaPjQ9XYv1RDY6
 vSkhzqz0sd8JGo4YRPBUQdgQP/NIKoK5wB/rCOBdGlGQFKoRZnHaR2wkXh9VpbXeKg
 H1a6TVC+juZ4RK59zCd3veEiQF8cPt8kvZSsz97dxFX1xZp4czmEXnNRqg+byrVgad
 5QVlTDPaFuG+5dgp5PdL26VoBLQ/uC1LHV4KoVCTMjhjEZlZryYwO2/anAjgwIwTIe
 1AOYkGUQ7w/Ug==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 14 Oct 2024 21:32:21 +0000
Message-ID: <20241014213221.2599772-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
MIME-Version: 1.0
X-Headers-End: 1t0Sg6-00016D-7m
Subject: [f2fs-dev] [PATCH] f2fs_io: choose MB/s instead of MiB/s
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 5b67a92e0947..bcf9f491c14d 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -926,7 +926,7 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 	}
 	printf("Read %"PRIu64" bytes total_time = %"PRIu64" us, BW = %.Lf MB/s print %u bytes:\n",
 		read_cnt, get_current_us() - total_time,
-		((long double)read_cnt / (get_current_us() - total_time) * 1000/1024 * 1000/1024 ), print_bytes);
+		((long double)read_cnt / (get_current_us() - total_time)), print_bytes);
 	printf("%08"PRIx64" : ", offset);
 	for (i = 1; i <= print_bytes; i++) {
 		printf("%02x", print_buf[i - 1]);
-- 
2.47.0.rc1.288.g06298d1525-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
