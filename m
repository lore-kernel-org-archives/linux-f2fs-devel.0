Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B508CD3436
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 May 2026 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3NV86PnmuYLKxcX1aj9dR4qwY5BtaAcsU2uhyefvsd4=; b=ioDp7jTMtM/cKaBepxp1j0R6vn
	9YFqNsrpRSv39kKmw/rwwurUK+VhA0Mj5VEOyRtOJV8GpCE2tN2WoVlNvllxTfE3XvYJgoWeMHfgV
	wzxPhi5r0sI0MlHWXW2e2HcFlWsqdG1uzAvnpUNBkxZkERsPxB5dOrRNILiXzdAkZ9zQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLLki-0007Uy-5x;
	Fri, 08 May 2026 14:00:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wLLkg-0007Up-Ht
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 May 2026 14:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fZZm+1LVauU6WpOg+01uQkjx+pYSJEw0OjEeITCE/Jo=; b=JXeKca+UmusEHQ1n9uF+j72aoM
 VzH2woyxxxOdzZ0mFSP5EJ2tqP/PrQjCq+1S9V9tZi+5lZzroTqQRzUIS/y5hBVHMSdb17sK4xivm
 Y7+6HXH7FmpkjLWWxdiYjLph+Dt2ktVqRxPonWYoOA6/gWqH+vR2gtSy2k0jd+tc+6c8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fZZm+1LVauU6WpOg+01uQkjx+pYSJEw0OjEeITCE/Jo=; b=G
 My6kLfjcitRcpj/Bz+JecPSs+pC6G3yrazYlqqfK3AMa9jNg7DXbnO6Gds7iSC2Xxn1SwjrzuDitN
 LTsz5UKOxGVH+zhiyjZaviO7SfHzpD/XP5KK8J8PRgkqlT3kA2B0HAW7u+Iv9bkQY6qinkNvDRVt6
 AMiyHwY0qM3+sruc=;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wLLkZ-0001My-Su for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 May 2026 14:00:24 +0000
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so938544b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 08 May 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778248809; x=1778853609; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZZm+1LVauU6WpOg+01uQkjx+pYSJEw0OjEeITCE/Jo=;
 b=T8UUFbOkPFV3r6fxUzn9jSJichF2Et17k1qoYKiv0j+RVbublDwTnqcSkNe+jCfQhx
 qbFEIvve8Z4tJvljbDWD5Uai+ikUSzitvlWpm8uikLcX9mrS0MxLMWC1e3YSICXCVNNo
 fYa021FrRMucnmBzxmzYRvlSSN6/AF9KUd3QADTw0E9iJLNVxdBFmKIrDLNRKfvcYQpW
 cpg436doVMuhnlwOzifbHaPsVofTTvxoBBq6o023+E36f4UktGUfzVPFUEXrMjdgmBBO
 k8bQG1Og0zuqC+bnTNzKwoIXwTIlIKmt108ttHZ6KFiE1O26tq8B9qyRd93GCbBsiqtH
 1Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778248809; x=1778853609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZZm+1LVauU6WpOg+01uQkjx+pYSJEw0OjEeITCE/Jo=;
 b=LlpSXh5rYXi93PYu+R/xuOfxnFp50tsknAwax/enuL0ikks700ikkQRtalJtPqnFTu
 7x6KDKCAao9Miok7Qtr8qfG26f+H7rC3mXUy4eK0nCv9WTKl+dgCUSasZ5cCWwkp2G2K
 YSrdEZfesVdMPDk4V74VNo+G/HM8eoUeBFAJw2RKWCq1cgvBs6yNoYgyW9M5E2WFIp+0
 VyT3UyWR87+7lOOwCGasRq3OSD7QV8vhqFymeSZ/IEzjANbJS+yk4pjcwduBLCBgk9Ex
 yXS3Uc8m9W2QCH0mxxiQw0iz1FDVQt9qpUil7y640qCKk392ewdlX1jrIP9NQnl4it1p
 3qHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PdsKUPfksj5XLOlfP2lGF8FVpzYMsKuuzlrg7eUK3TcIoes56VBvjO6fQ0q2JGOgNt4e5XfUfeJ0WjLQaqULN@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywoq9bLQHsvT5B3THZb44yDHz219xcJio9JcAeLa26VWGygKK8/
 Gs5iJQ8TUF8dWN31o2Qu2N4obZm+UcQBaFt+/Ue0iBQCv8Qr8HRWE+Tj4b8A4g==
X-Gm-Gg: Acq92OGZvii//gJI9LGrhg54G2/r3eVWs+A8nXDy3r/60q1+GDeo5I9bGvsMx2f+NSV
 pWlkQOLoOerl+R/WHelkMObF8QEixwP9krDsYHRXoMrg2v7TqZHS4QuuPA7Ni5YDVt4ZmJ3omOT
 tSkBxRZqjDKUpPM5liichyNyJKVAYs8AqD+scAsRwE6cygdDLA31Y6fm0dQTM7z9GOEX6m6clEg
 47z45mMwA/xZ3tlGmLZwj45tUG5adUqMWp+RZ8MsAEaX661V1HDItytS+ZEfXNEyELesk/Ep3WG
 75AhGB0PU8ZUEwDzTmhkQNiiuYohAJSXN/HBiBW0efQTfTFLGk0JmTew6kkR4Lgve7RMYuWsqQ2
 bFygFl7n2HAzIj0U2jX7yQXratfD0Pp3tiomZxZm5lNDSbC6dW0GgqvteL5BQndbFP09FoslpEj
 w7lFvlXMEHZJIDPWGLhQpIL5iGBFqtVQ==
X-Received: by 2002:a05:6a00:3315:b0:838:c01a:7a4c with SMTP id
 d2e1a72fcca58-83a5d876c21mr12128266b3a.33.1778248808405; 
 Fri, 08 May 2026 07:00:08 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:3870:3721:82b1:c4a9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbf0cesm15802959b3a.46.2026.05.08.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 07:00:07 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Fri,  8 May 2026 21:59:55 +0800
Message-ID: <20260508135955.2391208-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wLLkZ-0001My-Su
Subject: [f2fs-dev] [PATCH v2] f2fs: add iostat latency tracking for direct
 IO
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

F2FS did not collect iostat latency for direct IO reads and writes,
hook iomap_dio_ops.submit_io to bind an iostat context and record the
submission timestamp. Replace bi_end_io with f2fs_dio_end_bio() to
collect IO latency on completion before calling back to the original
iomap_dio_bio_end_io(), to add iostat latency tracking support for
F2FS DIO.

Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
v2:
- add f2fs_dio_iostat_start() to avoid duplicated code
and CONFIG_F2FS_IOSTAT guard
---
 fs/f2fs/file.c   | 35 +++++++++++++++++++++++++++++++++++
 fs/f2fs/iostat.c |  2 +-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 091a9db29228..d35e3cf158bf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4790,6 +4790,30 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	return true;
 }
 
+#ifdef CONFIG_F2FS_IOSTAT
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
+static void f2fs_dio_iostat_start(struct f2fs_sb_info *sbi, struct bio *bio)
+{
+	void *bi_private = bio->bi_private;
+
+	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
+	iostat_update_submit_ctx(bio, DATA);
+	bio->bi_end_io = f2fs_dio_end_bio;
+}
+#else
+static inline void f2fs_dio_iostat_start(struct f2fs_sb_info *sbi,
+					 struct bio *bio) {}
+#endif
+
 static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 				unsigned int flags)
 {
@@ -4802,8 +4826,18 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
 	return 0;
 }
 
+static void f2fs_dio_read_submit_io(const struct iomap_iter *iter,
+					struct bio *bio, loff_t file_offset)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(iter->inode);
+
+	f2fs_dio_iostat_start(sbi, bio);
+	blk_crypto_submit_bio(bio);
+}
+
 static const struct iomap_dio_ops f2fs_iomap_dio_read_ops = {
 	.end_io = f2fs_dio_read_end_io,
+	.submit_io = f2fs_dio_read_submit_io,
 };
 
 static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -5082,6 +5116,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	f2fs_dio_iostat_start(sbi, bio);
 	blk_crypto_submit_bio(bio);
 }
 
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index ae265e3e9b2c..232fdec036c1 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -254,7 +254,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
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
