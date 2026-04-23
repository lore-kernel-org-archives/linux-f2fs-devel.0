Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58521FAD3F7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZMlIyFiL59+uhz+ANwzWBsMPxe9nJ4k9jvdYBv8bC2c=; b=nICN12POsYYsf7k1SEquUlvIDF
	KQV4IgWITnZchJ/nT+TPCpvd3EPyA89IaQdeHFVih/7e/yx9jnobIPm3xxwaaJjKOT1WMVNioXgq/
	T1UuFHk4luKhKqjVrvBkk9uvI7QbaJYP5+wfeH+1KHpaiu6UDbvK3g/myqspXiajzAAA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFkzb-0001Jk-Kt;
	Thu, 23 Apr 2026 03:44:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wFkzZ-0001Je-TK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 03:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CuLCO+IisxSmgjGpiuEZKXzGYCqRtBN3ugPoaZV1BR8=; b=MqhbUOwFJpPVmgjqwD6fk0scNi
 yWre6rCRL+YGcp1BO+1rLxvVe/fva7MqPTiadNO3x+7VeSozkSTnNPrAVst3H/rziUxIvZfQxZC1p
 aECwSYqX9BKxzVx8Km4FfjYWhC62lyL3Y7GEFxklPvpwxVBhayQ6oJuUpw/Pg89qbLm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CuLCO+IisxSmgjGpiuEZKXzGYCqRtBN3ugPoaZV1BR8=; b=f
 sxdSSRCmeceflJ+O/C39KGLe3DqcuDq4vaB63xb61aUnkXoScI+XMmlsl+KOfkCzZ6Imoq8E5YUFG
 30SgQODWIsXc3ZQ454qtntgIYPs6Ru3xjdae9JlyjoBqjEwtIOOJ2uP6Am1ez07wzUEAVXr0UabND
 ILlo/cfCagHg0qoQ=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wFkzZ-0001bB-GD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 03:44:41 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-82f0884bcfaso4354776b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Apr 2026 20:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776915871; x=1777520671; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CuLCO+IisxSmgjGpiuEZKXzGYCqRtBN3ugPoaZV1BR8=;
 b=sJmyGhwUYpp7iHnyuc2psSfj9DcS4SiXW2Boll+E2DJ7iFfZaHut2MAx42LAy3o19G
 QqkjWuILDEbojjGNoUZSp4VHl/529XEf0mIYEOYtsbqNjddUX3CtSaN3UUVko/OwJXSP
 9Gp41sa9A67CQlLcoVZUOAzK6MOGqqW1Lrg2hSR3JnaAuFTW2tp/4x81EQ3JU7djtreZ
 OFAWP0M9AV+V1psuOgpBwh86RD4im8TuDB4MdD9UZmS1f7wuxzFQ3tFm0qCsKOwVJ73o
 jdG2C4Tgm1Y2I6yPnnXrYTxMbj7Y8OeTEdAqkSnknbF9FokktUiYtTM2nOT+Mbi8bJOx
 I75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776915871; x=1777520671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuLCO+IisxSmgjGpiuEZKXzGYCqRtBN3ugPoaZV1BR8=;
 b=XKV8+NF6kE8kyz23g/y5ety2JG8gdJmF0oK9/LzPB5Gzx53x6melEgiIfQ3+wcSuuO
 QA9vxYJur4E3tlN0TKjIIGZgZcJy8woUc17ULK36NBsGI+h4A7rIJAJKiYL0eXzRMpYc
 GK4cis0107oE9hmcCcRU90QtaWQU8yr8Qmx/5hUyoh50Yap/kTID+uH/Ainkytxt+LvT
 2jqTQOGae0gzNOFGCn3H7JSE7u0Va5dEqjIC8SrbkUfEOJKDW1hSnjehUDzOWH2hHLPM
 qcfULZ5KpnmWVEHxDRnEXa3+3kBYimYu5j4JgXMGyyAtsw7jSgpsG7mBN6wQy/MEaV+o
 Bgeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BWe4pQClkLXE/NRHcJ5idm7uuqLAAZ9wUmV3AeJxE/RukvIWiQhPVrh0WmyVZ4luBsaOGtObwY5RaG1pRjbR1@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw9e+Q/rM47mudWSk/dYEMBE6dutz0ey5v5HktLzgz/RAC4swtA
 j1YXQD2+W64OnfRe5LamhcrbdWOL+uAGh0qwl5X4boZtk69HVKW4sNhq
X-Gm-Gg: AeBDieut1LnbtIjoLeT044lDdQ3zSxmaYV3lk32qqBXHrbhsxLdAxDJgdohELC3u91A
 u4qDslyfrGVV8Dr1jddjtIxKffgqYhcxhtphnG6kgJ8keVxZo93BbEbkuObe0M/6mJSlW+w/jPl
 b+rIhzhiibNwLoy/4FnMfHFIQ5uwfzAZSiFMtEjCo+rGedB26naZvTeXy9vNLXHl+dORGVV5AoT
 HVM+ChgQH4NGPd0bSa3vX0auDdBGr1OVftjk2DANa30LDmjDZlt+WTkU1Tsr+znRD+nyENFvAb+
 YbY4XCLlyQSjThO8uXeEiN4ETak6y5HjUpHbX2WvqSxoKPvj6uur6LasUCZ+7pva3Cdf+WLzAx4
 Lrx4x6BO87Vf6vJXOLg7vGpsbyqcDn2CSNL7SsejwqP7KWZEmy8nKOd3SY6u9Ct1mESph5IZvwP
 ZrcKGgaMQV73g7XfMNaBr2Vy94fl7fQlHLi93TF4Kovg==
X-Received: by 2002:a05:6a00:418b:b0:82c:7383:3745 with SMTP id
 d2e1a72fcca58-82f8c834458mr27740097b3a.19.1776915870688; 
 Wed, 22 Apr 2026 20:44:30 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe40dasm18450063b3a.40.2026.04.22.20.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 20:44:30 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Thu, 23 Apr 2026 11:42:23 +0800
Message-ID: <20260423034223.1369837-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wFkzZ-0001bB-GD
Subject: [f2fs-dev] [PATCH] f2fs: add iostat tracking for direct IO
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
Cc: jinbaoliu365@gmail.com, shengyong1 <shengyong1@xiaomi.com>,
 liujinbao1 <liujinbao1@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

F2FS did not collect iostat statistics for direct IO reads and writes,
hook submit_io to bind an iostat context and record the submission
timestamp, replace bi_end_io to collect IO latency on completion and
then call back to the original iomap_dio_bio_end_io(), to add iostat
tracking support for F2FS DIO.

Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/file.c   | 27 +++++++++++++++++++++++++++
 fs/f2fs/iostat.c |  2 +-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c4880f24b54..fcf725931fd8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4774,6 +4774,16 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	return true;
 }
 
+static void f2fs_dio_end_bio(struct bio *bio)
+{
+	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+	void *orig_bi_private = iostat_ctx->post_read_ctx;
+
+	iostat_update_and_unbind_ctx(bio);
+	bio->bi_private = orig_bi_private;
+	iomap_dio_bio_end_io(bio);
+}
+
 static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 				unsigned int flags)
 {
@@ -4786,8 +4796,21 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 	return 0;
 }
 
+static void f2fs_dio_read_submit_io(const struct iomap_iter *iter,
+					struct bio *bio, loff_t file_offset)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(iter->inode);
+	void *bi_private = bio->bi_private;
+
+	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
+	iostat_update_submit_ctx(bio, DATA);
+	bio->bi_end_io = f2fs_dio_end_bio;
+	blk_crypto_submit_bio(bio);
+}
+
 static const struct iomap_dio_ops f2fs_iomap_dio_read_ops = {
 	.end_io = f2fs_dio_read_end_io,
+	.submit_io = f2fs_dio_read_submit_io,
 };
 
 static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -5064,8 +5087,12 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
+	void *bi_private = bio->bi_private;
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
+	iostat_update_submit_ctx(bio, DATA);
+	bio->bi_end_io = f2fs_dio_end_bio;
 	blk_crypto_submit_bio(bio);
 }
 
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index f8703038e1d8..57d2c3e68a1b 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -218,7 +218,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	unsigned long flags;
 
-	if (!sbi->iostat_enable)
+	if (!sbi->iostat_enable || iostat_ctx->submit_ts == 0)
 		return;
 
 	ts_diff = jiffies - iostat_ctx->submit_ts;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
