Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA33C56207
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8dbT0tnW8Ez/7HtsptVtepHMwmcl9PfSBK83yMsZz8=; b=WxorH68jV8ccUbKAqsKbHg2OWk
	Ko2AB9AgN3g+t5IzpLFl3AONrWwbRYrIKJpUQqj3eqeKcYkWHHT1yqG0eagmhto5ZiYMN5YMJQmXU
	vUNxlvCEu3or5lcu11EHrzS1MZ2rafnqje8wqexZvJYxZCaWlP57l2XYnNp/J5zFbOyY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrzha-0000Me-VR;
	Thu, 06 Aug 2026 15:08:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wrzhY-0000MX-V7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lCUbhf58OXMKxvyQq8OhGP2VvNKpXfUqOMR0IN6rf2U=; b=hKJI/1QrQXa2dV+uZS1MkdUlV/
 BejNIyY10xRdh75ORQZgRhggQJ8t0Xo94XYivuDhNMTiLEFPXcQMgxT6uQop1RRVohRntNBP+foe2
 G7VpQR7dUT1XE5L9IwNmb9WoyTkDEbllDJIWz8zwS+bKsW3yeI+ysDdmYnOMgjmM5pnA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lCUbhf58OXMKxvyQq8OhGP2VvNKpXfUqOMR0IN6rf2U=; b=KnmQitAafB0yUs2cyz0BYFrall
 7iPsOcGZUvBJeXhll53499RFEmSezBekgtVPjJ1UEoEnH5yAJgquUXIw2X/715hZizlFQzYgk2++b
 ywoTCL3RNosgbyEsxRC/1zq0t8u4SleOQs+nnAwdbcsJFu+DoGFV0WF1mrEuLZqteakE=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrzhY-00029C-Ff for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:06 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8485b358552so2012582b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786028879; x=1786633679; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lCUbhf58OXMKxvyQq8OhGP2VvNKpXfUqOMR0IN6rf2U=;
 b=YkjXJQybVHwaidOFHPzuiwcb2feEZCK+XGWl5KohYLZl1Rmwy7E90MkwtLZRPONYx7
 YqbSv8q/1JChhNw/rLeop7hHQ86Nbq+wSUBXxIylpPphh1w4GFsarj8ntsLRqBDtKCnM
 Aj+We5p+P1CybAM5rCriW4sJ5JspKHV7E1RBIjiMEGjIUAEsaaCr2vv//Qf2jD8uTqaS
 TrkuKk7JogPMLGaMXksmrwwnPrs9JHcJQd5jpztXXgyVboFFkM0wxVPsghvsqJa5Q0hk
 rzEUSmXQfbcKHvtAwTpoHg0plMv29by975mw/FlLeqK7jof3qC+6wDdyRLaHWZGSrVb2
 Z01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786028879; x=1786633679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lCUbhf58OXMKxvyQq8OhGP2VvNKpXfUqOMR0IN6rf2U=;
 b=LzRJ1Rgr6r5Z9YBxbVPzX6lgytuZbtRwDS9OUbHvIGe82H28aFNSBzVe6eqCtIj3DQ
 xBSKHUtJHc3g+5+cvIEBsRSKDEXw22RlU28Xm13NmWxwBH9UrUH63wgf2GHDfAiJkjf8
 JHVPwiqEPR/9ywu/8lnDqL6kSCOFbhanIJSjPf21dyBAKhPevF9UACY8L+UmpIV0sQ8t
 LGGmI+oslzOrcbNj4b3QshAVmjU5npfeNFrBpjEIW8Jl65uA+x/kzk2JevLoR/IjMrs+
 YzVvP14QXHj4eozpyNRX1/51Xm1GBTgpEousR5zOsOwQybUVCzOm9caU8QLReYjnobgx
 FTGQ==
X-Gm-Message-State: AOJu0Yy/jJVTf6YzvUmHzxOdVhCWJBUQfHCi5CGSLtkYY7l3nan90Bkh
 SIHJyYJ9T9g6FnIWTcs9vdvsCs/LZghiKlfgDfott6DJvDoq8Kg54owT
X-Gm-Gg: AR+sD13DuIPHC3Hq5iKEe5bW5ldKQTJFF9aBJLvP/vE/CkO7nA5c8Rx7uF/RdTmfUhV
 j3s/+LZHRFroB9nlWhyEnxVvo8nVgc6/6TIRLkzHWv03iXaftx1SwRgKbjaH6gizPkFZQQ4AGWW
 8S3ZghLxGO234Loyx6+DOFcFoCdHZ0jK3hAZcVy5irXluJNefPb2YGRvToQ6CkMP/oAAYeqa3go
 9PSN9JM4eyCqu4+mRoZN0s5ODmxKF2a3Zr76Fvy5ViYjwFj8Of7q36dbVP6VWNJqr0+2UMiC8He
 oQKrCuTMz6s5UECx3sjdPHK+IAxqtMF/mcPbjdiN74QNhAOSxIqyMnWi7yrkFiMX6DG/uNAssvz
 z/88Jp4JW1Z76jfBOUCr9SGwOU+FuSBf802oTJw2V6uN0Wt5XzyYSmiljPVt0szTjgSLsUmqgOw
 x9nICl6ZJyKHRaPhlvMJV91U/ESIfr8kSnXc68m6l1E8pqtUkBnuX12OfEOGCCjfuLieBSdhSGy
 hbnaddB/XpFxbmj0bbWhG9C
X-Received: by 2002:a05:6a00:14ca:b0:845:3fea:96c with SMTP id
 d2e1a72fcca58-84f2e017155mr16933169b3a.21.1786028878731; 
 Thu, 06 Aug 2026 08:07:58 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45bc9c6bsm1586448b3a.56.2026.08.06.08.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:07:58 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  6 Aug 2026 23:07:46 +0800
Message-ID: <20260806150748.3554436-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
References: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wrzhY-00029C-Ff
Subject: [f2fs-dev] [RFC PATCH 1/2] f2fs: keep dropbehind write bios
 task-context safe
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Keep dropbehind folios in dropbehind-only write bios so
ordinary and dropbehind writes do not share the same
completion policy.

If a dropbehind bio completes outside task context,
defer its completion to the existing sbi->wq worker
before folio_end_writeback() runs.

Other bios keep the existing completion path.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 54 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 30e8084..8a1e407 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -43,9 +43,20 @@ struct f2fs_folio_state {
 
 struct f2fs_bio {
 	struct work_struct work;
+	bool dropbehind;
 	struct bio bio;
 };
 
+static inline struct f2fs_bio *f2fs_bio_to_f2bio(struct bio *bio)
+{
+	return container_of(bio, struct f2fs_bio, bio);
+}
+
+static inline bool f2fs_write_folio_is_dropbehind(const struct f2fs_io_info *fio)
+{
+	return fio->folio && folio_test_dropbehind(fio->folio);
+}
+
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
@@ -418,6 +429,15 @@ static void f2fs_write_end_io_work(struct work_struct *work)
 	f2fs_write_end_bio(bio);
 }
 
+static void f2fs_queue_write_end_io(struct f2fs_sb_info *sbi, struct bio *bio)
+{
+	struct work_struct *work = &container_of(bio, struct f2fs_bio,
+						 bio)->work;
+
+	INIT_WORK(work, f2fs_write_end_io_work);
+	queue_work(sbi->wq, work);
+}
+
 static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
@@ -426,15 +446,15 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
-		struct work_struct *w;
+	if (f2fs_bio_to_f2bio(bio)->dropbehind && !in_task()) {
+		f2fs_queue_write_end_io(sbi, bio);
+		return;
+	}
 
-		w = &container_of(bio, struct f2fs_bio, bio)->work;
-		INIT_WORK(w, f2fs_write_end_io_work);
-		queue_work(sbi->wq, w);
-	} else {
+	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size)
+		f2fs_queue_write_end_io(sbi, bio);
+	else
 		f2fs_write_end_bio(bio);
-	}
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -530,6 +550,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	f2fs_bio_to_f2bio(bio)->dropbehind = false;
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -796,6 +817,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 
 	/* Allocate a new bio */
 	bio = __bio_alloc(fio, 1);
+	f2fs_bio_to_f2bio(bio)->dropbehind = f2fs_write_folio_is_dropbehind(fio);
 
 	f2fs_set_bio_crypt_ctx(bio, fio_folio->mapping->host,
 			fio_folio->index, fio, GFP_NOIO);
@@ -1010,6 +1032,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	struct folio *data_folio = fio->encrypted_page ?
 			page_folio(fio->encrypted_page) : fio->folio;
 	struct folio *folio = fio->folio;
+	bool is_dropbehind = f2fs_write_folio_is_dropbehind(fio);
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
@@ -1017,17 +1040,24 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_bio(data_folio, fio);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio && (f2fs_bio_to_f2bio(bio)->dropbehind != is_dropbehind ||
+		    !page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				       fio->new_blkaddr)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_VECS);
+		f2fs_bio_to_f2bio(bio)->dropbehind = is_dropbehind;
 		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
 				folio->index, fio, GFP_NOIO);
 
 		add_bio_entry(fio->sbi, bio, data_folio, fio->temp);
 	} else {
+		if (f2fs_bio_to_f2bio(bio)->dropbehind != is_dropbehind) {
+			f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
+			goto alloc_new;
+		}
+
 		if (add_ipu_page(fio, &bio, data_folio))
 			goto alloc_new;
 	}
@@ -1073,6 +1103,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	struct folio *bio_folio;
 	struct f2fs_lock_context lc;
 	enum count_type type;
+	bool is_dropbehind;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
@@ -1100,6 +1131,7 @@ next:
 	}
 
 	verify_fio_blkaddr(fio);
+	is_dropbehind = f2fs_write_folio_is_dropbehind(fio);
 
 	if (fio->encrypted_page)
 		bio_folio = page_folio(fio->encrypted_page);
@@ -1115,7 +1147,8 @@ next:
 	inc_page_count(sbi, type);
 
 	if (io->bio &&
-	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
+	    (f2fs_bio_to_f2bio(io->bio)->dropbehind != is_dropbehind ||
+	     !io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
 				bio_folio->index, fio)))
@@ -1123,6 +1156,7 @@ next:
 alloc_new:
 	if (io->bio == NULL) {
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
+		f2fs_bio_to_f2bio(io->bio)->dropbehind = is_dropbehind;
 		f2fs_set_bio_crypt_ctx(io->bio, fio_inode(fio),
 				bio_folio->index, fio, GFP_NOIO);
 		io->fio = *fio;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
