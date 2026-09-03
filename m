Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7604C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1cg6K1wUGwhKkbx7fj+gcmETn7cQ1R7KAeEP7RDYyc=; b=MR69vV3Ua9GV0WlMrIkMUH9qeR
	1fOcX1QVzrxomZMWH7phz1RwurOZIbvMih3DzlZcimpGL/7pDPB9E2x8GLirOqkjmmaUwPdsoKOoK
	jQg2bXpztQXpm9Pbo4xIP1YlU7YPI0z5yfX2OsH7RADwQtg0qA3JLB73X6IWvlBJrYRg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x273D-0007Km-Ls;
	Thu, 03 Sep 2026 13:00:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x273C-0007Kg-D1
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=; b=by+IfEvSIO5LFtBnkKGbCD6IHf
 lhXyNsEiWcGOUGfMKvQ376496rL8LgTpqZ/NWds7Qb9ADVcb9VnIHgsxculR8tOuogXRYgVRPpJri
 A6wb9Q5khm/blOJxUjrYkzy/QD5UVDlhrQ+NyIm7CMsHBouqAd9svzq05YejG/IguWiQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=; b=LInqfdhNbmUeeNmKls0EkVUW25
 zaVzFzhcj1gRBgDr9aQSaW3BJxAW4KqWld+eCguX6Hm5DEk8beKYzlAdVgB1Va/72DxoMG7h9roub
 Qq6s9xBLCUPWkzRtcvI/VAFF9tUOgi39BVbyfEkoNX7VqeqHj8SKWSDtBfDGfkc/sleE=;
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x273A-0003AI-Ae for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:19 +0000
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1980686b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788440411; x=1789045211; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
 b=WlqRtDbF2Pyces/a0OAU5kgAxLbFDGzL/GZYNWXQLHzx+LkPWGRtQWs7iu+Ujrqx7+
 mRD7X3hQ0Gpm9pkanmhMhMFotm63rsXb/Yo/44vLCF5TCB5gt6mg3++EMnUWQk9CR8qX
 JOU2/mfxmFl4P7ejpLp+wrku92aYFZ5QyWsfmfH/H8AxXtJjEaIrUvVlZlby/ZDY5Wi+
 On2GNVDI87AAGI62zUf2Nj3XldSVTfdPcrpiy8Cw2mG3ewiMu89Zl+sE7VJ0PrhH9jKK
 0OKSmolIdKwmhvZPeYGugcY3w2wziiDdNdcK5XDmeFtZgob7PcNuHP02/WxhOC9ljTA7
 oJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440411; x=1789045211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
 b=ViiIbto0/mvXfKYEl858wnCkuZyEtChj+XrO2IPTcjWzru60rUuAZiveQltByJ+Ndn
 kgjfT6o21se33FLdCv/bBUvDm67mt9GEvSVMrZXgFNNSLslqTvX9TIjrEYKHdvmZC77Z
 5w4Akv8ncAGJQADT28oi9ixvwvYdt/gleKCIsBQ42aqEDLRi3AvetFI6keEhzC0GC24g
 YZMwISDmkpZZFerj7gs31icJB+8Ra7dFs7jkbHwEcfhtewRQPa9JS4yG4w/a+xaXzSfV
 aj0XYTSUrKVzO2Jc5prjwiJTcDvmc5WPI0xHdNb7UHXoWjaK2kwgGOkG+tXr7OmpgUQK
 2isA==
X-Gm-Message-State: AFuF++lae+M3/FfJhJjbCHsdtacjX5hTikFyjgPw/V3o8fQHAQVdTFFn
 T/FS8vjGQq99nS+ksYo5Fi6LR8pql7nZ/041u0nIFkKrlZNt0IaE8ES9BKUqnhOm
X-Gm-Gg: AYBFou2B2EAs1RI2elY3vyNFSOv7BGNGjdW1x28QuiuEf9zpbIibt+xE5qyx74A2eQt
 9CsSPtAKlqXsPDG1a9mzBRIoHh5HvHJc9Xad5ftGvnXFXPghg7kRETcVzAM6SW3MF7XbRq01wUv
 /zg5t2F5QxqmHSBCkGmrncY4SwbuT1rtOqnxAxKUtGTXEBmkJ5Mxv0YNoK3qZQaearf1csgVpXE
 Sc0y59nsKYts8UEuyTfReQxf2yxV5lUTgLGZLCw0+6qk0/VxRzDxYaABg8F/W/A3Sak94Q9UG8m
 NbxLL3uHT6pSMhBLSLJU2g3/cehNmJgeyQV7K6/CDXVs/LDY0Ph2DRzZfBqHNsiDYAoeLNqvfmF
 Ox+AH0bivCB4kcSJHmSD3HsuPsgOo5gJzJu+1/ic/07QKQRelLWxf0vvLgp2rx06yF4HPx4kzYq
 ac7+8E/4Y8MHBn8oW87s+0V0E49/7Mc1395pjXXgVkczqNdmtL2qdHNctzRa1iZlQPOlo7AKuk+
 vhV+gi9KoI8JUx+Y+1AGXAw
X-Received: by 2002:a05:6a00:1408:b0:852:3726:dfde with SMTP id
 d2e1a72fcca58-85ed25e2492mr15794500b3a.9.1788440410410; 
 Thu, 03 Sep 2026 06:00:10 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:00:09 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  3 Sep 2026 20:59:52 +0800
Message-ID: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x273A-0003AI-Ae
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: complete dropbehind write bios in
 task context
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
F2FS completion in task context when needed.

Use the same flag to keep normal and dropbehind folios from merging in the
IPU and OPU paths. Classify the original page-cache folio rather than an
encrypted or compressed replacement folio.

Keep the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22..b0fedacfd12 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
 }
 
+static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
+					  struct f2fs_io_info *fio)
+{
+	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
+		folio_test_dropbehind(fio->folio);
+}
+
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 						struct f2fs_io_info *fio)
 {
@@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_bio(data_folio, fio);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio &&
+	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				fio->new_blkaddr) ||
+	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
@@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				bio_folio->index, fio)))
+				bio_folio->index, fio) ||
+	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
