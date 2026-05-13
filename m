Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D5FCD4F21
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L/N3ABpC7X5j1ZPpurPmZkM1bXYoFspDTm08HOpFJZw=; b=hdakBOBKcaSRGg70RghIyxNV+G
	JZzQAbgdgl+JE96E2OfyBeC7GzIUwjLvIF2ehSxOaNHYsITbdoUFgviJivtap1dcSWmkspdrfyKSv
	PYsDWk/2XrmIcFFsQeu97hOFg8CkRpY+D++Uo1LarhjhTPp5GqSqfk6JX0HipjvLQJ/w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNAMX-0007Pl-OT;
	Wed, 13 May 2026 14:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wNAMW-0007Pf-Jf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QGiVjld9Fz/Bnj3nYz57d9gyW+vT89JpU+MF+oM8uF8=; b=Dmc9C6q3/TiKRTsF7XjzWwNYLY
 w58rxsmUkt+n3WV0aufqDNpiy5n2goSEW8K/CnRmaDscZ46Ey+wKkeseZbGwHUNDbVF6CNxzd6bHu
 7zi6tiEozNo/1dRiC8LQznhyexZ23rFXOkOOWDw9QLue4T8+Mn4qy5lizw9vDwwhjt/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QGiVjld9Fz/Bnj3nYz57d9gyW+vT89JpU+MF+oM8uF8=; b=P
 3lQHd6/pFIRfQoi++kcFWijr5fmi2cv/itPyQ7HPOi3frCYdtvd1DngFSOekYyLHs9K+Q3/++a+Vo
 lEdzPVgaUo94HHXU10Wpu1nRMJTbW/GMc6xuG6nlkzemjQOTWLSXxwrfF4lcxQr+EDQ1NgP4H4sp8
 M4fLE3fGop9kwYn8=;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNAMQ-0003C2-T7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:14:58 +0000
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-83538fbd0b2so2742744b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778681690; x=1779286490; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QGiVjld9Fz/Bnj3nYz57d9gyW+vT89JpU+MF+oM8uF8=;
 b=gTEV2OX4E+wuVLbqgbjfoPpPItqnYTGQ9RlmOVjA6dEUqqbqBcFyCKVCKXBpQf7JMa
 cfHJPODExoPFWcPxgrV6dEUKjKJH+54g9CAgWhYdKN8qbxBfpB/5K1r08X8olfs6vAom
 hR65W0/2Rlj13bTcdySb8EupSmM+0YlmYxsxR/E9kp5BkMvxbWnNDpe9sM5ImHe4dczN
 r9lBHQLWtZIFGksCe78YJTIPxyX/utu/RbkAARCIav1g356AYDnM77AsMc++qJEhrsKf
 Cv3zGMXqc/kEedK0RVtVd1A/3qE7e5+z0yHtN5uKS0P71706kMz+e17UT+sAhEEoBjAX
 O9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681690; x=1779286490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGiVjld9Fz/Bnj3nYz57d9gyW+vT89JpU+MF+oM8uF8=;
 b=Oav/KwCaHOS2I4Lk+zsUidaMW+xKfGH2A8Lyj58IX51+leHKBEsknm+rs4THFtsDDS
 uDfqSbGREa04l5ouKkjjsYbAKMiEPDEZpcMeFh8eAGGmdSSlzQRQEgnBX9Yhj2C98Yvb
 SaM9VrL+Zf+jJUlZDskEl+O7/5SyCvtxTu+aOZE4pRUDOxCCiciSe6DHC48vIYW1QJsN
 sjNMFKCH8W4fzR70ryuJEg49xJ4cO4zkHwW062Vi+mjHtyk8q8w1pZ/GSp0fkzMv9wnK
 MPCdmoi8uAWAUi+w/tTWhEENVztJRz6YcK0pKI06h5URp2LBqzJ/Ouovc89UBL8vqmX0
 4HAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WY3kwwgrvt1bNJMRyF1W3LXqqAxHY9/x+QW0J4jh28kRJFPtTXe4T32/WOCeo66QDR8r3uUBkAe1w2dJTGl63@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxE6emrvsb72RVHfs74LVuyJ9c3aftPI3i1buBvCRXD2XrhGcrZ
 cyQ8jGdyUcs0/RMq9UfO4U3lg7rhUNt9hE9fuVS51SPymhAf6XNOAY+N
X-Gm-Gg: Acq92OHe08z8UqwB+BxvQkXYNqf4/EAxdiGyOegfLQTdl86AitTiptRK3LwK0i75cXn
 fnOJMACoNguZdvuqOJr90fRChWRkXMNH2N2315ze+bpcpxYnogdVrWgtrx0y1LPd1Y7QfBHe0AE
 DYnXp0pe+TgNsEpna2YZqfdC0DELC+rN7S0G25iC+rMndQLT+ufbQYzgW8Nc1e7WAWooU7MAviq
 EyrW5IjdkHYHKO2ov45z8oCO4JVahmzgpOXV6kLN8KICmYaSama0pvpLPfs2WxsfWNeB6hP16rU
 8MvCyyt5+EC5+TiOID5f17ULrYayYFyCHD+YI7pcjk1Qvg3kX7ZOkA3D+tt+uM2bZZ9+/yShmYG
 TCNHfr6x7jcJSH463JkzickzRlJhrrYzjBcvv4Fa4JDm/fsdrIJJLWafZ0Y5ZSUA2iGVVn5DUII
 eJWP8YWJ+iWGZXA+IFIk1H6XH3CXZW7Q==
X-Received: by 2002:a05:6a20:2451:b0:39b:8905:4e13 with SMTP id
 adf61e73a8af0-3af7ee34f83mr4301803637.6.1778681689607; 
 Wed, 13 May 2026 07:14:49 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:1053:8f4f:7961:1c05])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c826767c6d7sm15314509a12.7.2026.05.13.07.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:14:49 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Wed, 13 May 2026 22:14:36 +0800
Message-ID: <20260513141436.1278665-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wNAMQ-0003C2-T7
Subject: [f2fs-dev] [PATCH v3] f2fs: add iostat latency tracking for direct
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
v3:
- drop the submit_ts == 0 guard in __update_iostat_latency()
v2:
- add f2fs_dio_iostat_start() to avoid duplicated code
  and CONFIG_F2FS_IOSTAT guard
---
 fs/f2fs/file.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c4880f24b54..c86eaca20955 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4774,6 +4774,30 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
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
@@ -4786,8 +4810,18 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
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
@@ -5066,6 +5100,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	f2fs_dio_iostat_start(sbi, bio);
 	blk_crypto_submit_bio(bio);
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
