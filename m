Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90ECC6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Apr 2024 23:54:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrnxx-0006on-Ep;
	Tue, 02 Apr 2024 23:54:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rrnxw-0006od-CT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Apr 2024 23:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uALTc6uR/btcpQFUfOCMjWlhQ236O1EVFKfefteNAN4=; b=dV9vmoqRpoe64krrdlbcDsN0pX
 hIkdsg5vCKQopDdLfMMtjUuzANy4P2DXSRwp5Fyj1Li9wyQpi2mHCXvN/xapL/UuR5PfRUlTxuMI6
 y6WtbIB5G7kI/RfjVkiXOKBLfdKlQCfngF+HPvjn90STmJysdoIjjihgfAqCZUr9w8Ik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uALTc6uR/btcpQFUfOCMjWlhQ236O1EVFKfefteNAN4=; b=D
 YGwiKg8VicKT2R8rRApmpb99dnHXVhoU45h0SmhfVdtiPEtoMolvGhaN9jqVguwQf1XwBpHCJCrY9
 yZu0125CxWQzMk9eAaRMVKwNkEVMjywJXNR3VSRdRhzbBWZrdG2HGp1yTRmTvarLeHBna+fopgC/l
 arPaas4tp3/RRqf0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rrnxv-00016m-RG for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Apr 2024 23:54:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 871336023F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  2 Apr 2024 23:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CF2C433F1;
 Tue,  2 Apr 2024 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712102090;
 bh=BHkVjW+hDfxGGoJjM/PPGymJr/tFsXJD8vdwFNgU6aM=;
 h=From:To:Cc:Subject:Date:From;
 b=LemnwvqRC9tlDYUcsbMqsxLt/fwuv4F6ZGnNikSB4QUj/aMnoB50X+oWtJSbadRPy
 zndFpcFNgn7LbnAtA1o05vj4t4/vluoXPUyCE/Jd10yPdJZVAG43i2dqk5TSidhn3O
 abqu+isLWYT03U2aLN5OzSaRTb/5vBUOTkmsvZQ6f1ffdJdtHB4GlsO9/u8Igli6Y+
 5o5vQ/1DU65o9j4wJqJgdxCN/qPQIMzYmWCGwH3asLuJN3vZYzGsOk5McV4AHm6174
 +Lq5Z/viSlmlYkOUUrbx3MkeuVUfZFYzXxZTEkRS9mzB7/FmoJbxNi1ZUR1t4wAA0u
 Vh3imfEg5V89Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  2 Apr 2024 23:54:47 +0000
Message-ID: <20240402235447.132195-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
MIME-Version: 1.0
X-Headers-End: 1rrnxv-00016m-RG
Subject: [f2fs-dev] [PATCH] f2fs-tools: give 6 sections for overprovision
 buffer
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

This addresses high GC cost at runtime.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h  | 8 +++++++-
 mkfs/f2fs_format.c | 5 +++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index fc56396fa358..870a6e4823d2 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1775,6 +1775,12 @@ static inline uint32_t get_reserved(struct f2fs_super_block *sb, double ovp)
 	return round_up(reserved, segs_per_sec) * segs_per_sec;
 }
 
+static inline uint32_t overprovision_segment_buffer(struct f2fs_super_block *sb)
+{
+	/* Give 6 current sections to avoid huge GC overheads. */
+	return 6 * get_sb(segs_per_sec);
+}
+
 static inline double get_best_overprovision(struct f2fs_super_block *sb)
 {
 	double ovp, candidate, end, diff, space;
@@ -1798,7 +1804,7 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
 		if (ovp < 0)
 			continue;
 		space = usable_main_segs - max((double)reserved, ovp) -
-					2 * get_sb(segs_per_sec);
+					overprovision_segment_buffer(sb);
 		if (max_space < space) {
 			max_space = space;
 			max_ovp = candidate;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 8f632f8d74b4..e26a513ed80c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -778,7 +778,8 @@ static int f2fs_write_check_point_pack(void)
 		 * In non configurable reserved section case, overprovision
 		 * segments are always bigger than two sections.
 		 */
-		if (get_cp(overprov_segment_count) < 2 * get_sb(segs_per_sec)) {
+		if (get_cp(overprov_segment_count) <
+					overprovision_segment_buffer(sb)) {
 			MSG(0, "\tError: Not enough overprovision segments (%u)\n",
 			    get_cp(overprov_segment_count));
 			goto free_cp_payload;
@@ -787,7 +788,7 @@ static int f2fs_write_check_point_pack(void)
 				get_cp(rsvd_segment_count));
 	 } else {
 		set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
-				2 * get_sb(segs_per_sec));
+				overprovision_segment_buffer(sb));
 	 }
 
 	if (f2fs_get_usable_segments(sb) <= get_cp(overprov_segment_count)) {
-- 
2.44.0.478.gd926399ef9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
